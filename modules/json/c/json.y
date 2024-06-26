/*
 * JSON parser, yacc/bison based. Manual lexer.
 * Mikhail.
 */

%define api.pure full

%{
/* * ** *** ***** ******** ************* ********************* */
#include <tcl.h>
#include <ctype.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>

#include <json_y.h>

#define TOKEN(tok)   TRACE (("TOKEN  %s\n", tok))
#define TOKEN1(tok)  TRACE (("TOKEN  %s (%s)\n", tok, Tcl_GetString(context->obj)))
#define REDUCE(rule) TRACE (("REDUCE %s\n", rule))

#define TRUE_O  (Tcl_NewStringObj("true",  4)) /* OK tcl9 */
#define FALSE_O (Tcl_NewStringObj("false", 5)) /* OK tcl9 */
#define NULL_O  (Tcl_NewStringObj("null",  4)) /* OK tcl9 */

typedef union YYSTYPE YYSTYPE;

static void jsonerror (struct context *, const char *);
static int  jsonlexp  (YYSTYPE *lvalp, struct context *context);

#define yylex   jsonlexp
#define yyerror jsonerror

/* * ** *** ***** ******** ************* *********************
** User declarations <EOF>
 */
%}

%union {
	Tcl_Obj		*obj;
	struct {
		Tcl_Obj	*key;
		Tcl_Obj	*val;
	} keyval;
};

%lex-param   {struct context* context}
%parse-param {struct context* context}

%token STRING CONSTANT

%type <obj>	tree
%type <obj>	json
%type <obj>	object
%type <obj>	list
%type <obj>	values
%type <obj>	members
%type <obj>	value
%type <obj>	string
%type <keyval>	member

%%

tree    : json
	{
		REDUCE("TREE");
		if (context->I) {
		  Tcl_SetObjResult(context->I, $1);
		  TRACE (("  RESULT (%s)\n", Tcl_GetString($1)));
		}
		context->result = TCL_OK;
	}
	;

json    : value
	;

object	: '{' members '}'
	{
		$$ = $2;
	}
	| '{' '}'
	{
		$$ = Tcl_NewObj();
	}
	;

list	: '[' values ']'
	{
		$$ = $2;
	}
	| '[' ']'
	{
		$$ = Tcl_NewObj();
	}
	;

values	: value
	{	
		$$ = Tcl_NewListObj(1, &$1); /* OK tcl9 */
	}
	| values ',' value
	{
		Tcl_ListObjAppendElement(NULL, $1, $3);
		$$ = $1;
	}
	;

members	: member
	{
	        $$ = Tcl_NewListObj(0, NULL);); /* OK tcl9 */
	}
	| values ',' value
	{
		Tcl_ListObjAppendElement(NULL, $1, $3);
		$$ = $1;
	}
	;

members	: member
	{
	        $$ = Tcl_NewListObj(0, NULL); /* OK tcl9 */
		Tcl_ListObjAppendElement(NULL, $$, $1.key);
		Tcl_ListObjAppendElement(NULL, $$, $1.val);
	}
	| members ',' member
	{
		Tcl_ListObjAppendElement(NULL, $1, $3.key);
		Tcl_ListObjAppendElement(NULL, $1, $3.val);
		$$ = $1;
	}
	;

member	: string ':' value
	{
		$$.key = $1;
		$$.val = $3;
	}
	;

string	: STRING
	{
		$$ = context->obj;
	}
	;

value	: CONSTANT
	{
		$$ = context->obj;
	}
	| string
	| object
	| list
	;

%%
/* * ** *** ***** ******** ************* *********************
** User definitions
 */

void
jsonparse (struct context* context)
{
  yyparse (context);
}

#define HAVE(n) (context->remaining >= n)

#define DRAIN(n) context->text += n, context->remaining -= n

#define	STORESTRINGSEGMENT()				\
	if (initialized) {				\
		if (context->text != bp) {		\
			Tcl_AppendToObj(context->obj, /* OK tcl9 */	\
			    bp, context->text - bp);	\
		}					\
	} else {					\
		context->obj = Tcl_NewStringObj( /* OK tcl9 */	\
		    bp, context->text - bp);		\
		initialized = 1;			\
	}

void
jsonskip(struct context *context)
{
  while (context->remaining) {
    switch (*context->text) {
    case '\n':
    case ' ':
    case '\t':
    case '\r':
      DRAIN(1);
      continue;
    }
    break;
  }
}

static int
jsonlexp(YYSTYPE *lvalp, struct context *context)
{
  const char *bp = NULL;

  /* Question: Why not plain numbers 1,2 for the states
   *           but these specific hex patterns ?
   */
  enum {
    PLAIN	= 0x0000ff00,
    INSTR	= 0x00ff0000
  } lstate;
  double 	 d;
  char		*end;
  const char	*p;
  int		 initialized = 0;

  /*
   * Do not auto-lex beyond a full json structure.
   */
  if (context->result == TCL_OK) {
    TOKEN ("<<eof>>");
    return 0;
  }

  /*
   * Quickly skip and ignore whitespace.
   */
  while (context->remaining) {
    switch (*context->text) {
    case '\n':
    case ' ':
    case '\t':
    case '\r':
      DRAIN(1);
      continue;
    }
    break;
  }

  /*
   * Handle the token following the whitespace. Small state machine to
   * handle strings and escapes in them, and bare words (various
   * contants, and numbers).
   */
  for (lstate = PLAIN; context->remaining > 0; DRAIN(1)) {
    if (lstate == INSTR) {
      if (*context->text == '"') {
	/*
	 * End of quoted string
	 */

	STORESTRINGSEGMENT();
	DRAIN(1);
	TOKEN1 ("STRING");
	return STRING;
      }

      if (*context->text == '\\') {
	/*
	 * Escaped sequence. The 9 sequences specified at json.org
	 * are:
	 *       \"  \\  \/  \b  \f  \n  \r  \t  \uXXXX
	 */
	char	 buf[TCL_UTF_MAX];
	Tcl_Size len;
	int      consumed;

	STORESTRINGSEGMENT();

	/*
	 * Perform additional checks to restrict the set of accepted
	 * escape sequence to what is allowed by json.org instead of
	 * Tcl_UtfBackslash. -- OK tcl9
	 */

	if (!HAVE(1)) {
	  Tcl_AppendToObj(context->obj, "\\", 1); /* OK tcl9 */
	  yyerror(context,"incomplete escape at <<eof> error");
	  TOKEN("incomplete escape at <<eof>> error");
	  return -1;
	}
	switch (context->text[1]) {
	  case '"':
	  case '\\':
	  case '/':
	  case 'b':
	  case 'f':
	  case 'n':
	  case 'r':
	  case 't':
	    break;
	  case 'u':
	    if (!HAVE(5)) {
	      Tcl_AppendToObj(context->obj, "\\u", 2); /* OK tcl9 */
	      yyerror(context,"incomplete escape at <<eof> error");
	      TOKEN("incomplete escape at <<eof>> error");
	      return -1;
	    }
	    break;
	  default:
	    Tcl_AppendToObj(context->obj, context->text + 1, 1); /* OK tcl9 */
	    yyerror(context,"bad escape");
	    TOKEN("bad escape");
	    return -1;
	}

	/*
	 * XXX Tcl_UtfBackslash() may be more -- OK tcl9
	 * XXX permissive, than JSON standard.
	 * XXX But that may be a good thing:
	 * XXX "be generous in what you accept".
	 */
	len = Tcl_UtfBackslash(context->text, /* OK tcl9 */
			       &consumed, buf);
	DRAIN(consumed - 1);
	bp = context->text + 1;
	Tcl_AppendToObj(context->obj, buf, len); /* OK tcl9 */
      }
      continue;
    }

    switch (*context->text) {
    case ',':
    case '{':
    case ':':
    case '}':
    case '[':
    case ']':
      DRAIN(1);
      TOKEN (context->text[-1]);
      return context->text[-1];
    case 't':
      if ((context->remaining < 4) ||
	  strncmp("rue", context->text + 1, 3))
	goto bareword;
      DRAIN(4);
      context->obj = TRUE_O;
      TOKEN1 ("CONSTANT");
      return CONSTANT;
    case 'f':
      if ((context->remaining < 5) ||
	  strncmp("alse", context->text + 1, 4))
	goto bareword;
      DRAIN(5);
      context->obj = FALSE_O;
      TOKEN1 ("CONSTANT");
      return CONSTANT;
    case 'n':
      if ((context->remaining < 4) ||
	  strncmp("ull", context->text + 1, 3))
	goto bareword;
      DRAIN(4);
      context->obj = NULL_O;
      TOKEN1 ("CONSTANT");
      return CONSTANT;
    case '"':
      bp = context->text + 1;
      lstate = INSTR;
      continue;
    case '\\':
      yyerror(context,"Escape character outside of string");
      TOKEN ("escape error");
      return -1;
    }

    /*
     * We already considered the null, true, and false
     * above, so it can only be a number now.
     *
     * NOTE: At this point we do not care about double
     * versus integer, nor about the possible integer
     * range. We generate a plain string Tcl_Obj and leave
     * it to the user of the generated structure to
     * convert to a number when actually needed. This
     * defered conversion also ensures that the Tcl and
     * platform we are building against does not matter
     * regarding integer range, only the abilities of the
     * Tcl at runtime.
     */

    d = strtod(context->text, &end);
    if (end == context->text)
      goto bareword; /* Nothing parsed */

    context->obj = Tcl_NewStringObj (context->text, /* OK tcl9 */
				     end - context->text);

    context->remaining -= (end - context->text);
    context->text = end;
    TOKEN1 ("CONSTANT");
    return CONSTANT;
  }

  TOKEN ("<<eof>>");
  return 0;
 bareword:
  yyerror(context,"Bare word encountered");
  TOKEN ("bare word error");
  return -1;
}

#if 0
int
jsonlex(struct context *context)
{
  const char *bp = NULL;

  /* Question: Why not plain numbers 1,2 for the states
   *           but these specific hex patterns ?
   */
  enum {
    PLAIN	= 0x0000ff00,
    INSTR	= 0x00ff0000
  } lstate;
  double 	 d;
  char		*end;
  const char	*p;
  int		 initialized = 0;

  while (context->remaining) {
    /* Iterate over the whole string and check all tokens.
     * Nothing else.
     */

    /*
     * Quickly skip and ignore whitespace.
     */
    while (context->remaining) {
      switch (*context->text) {
      case '\n':
      case ' ':
      case '\t':
      case '\r':
	DRAIN(1);
	continue;
      }
      break;
    }

  /*
   * Handle the token following the whitespace. Small state machine to
   * handle strings and escapes in them, and bare words (various
   * contants, and numbers).
   */
  for (lstate = PLAIN; context->remaining > 0; DRAIN(1)) {
    if (lstate == INSTR) {
      if (*context->text == '"') {
	/*
	 * End of quoted string
	 */
	DRAIN(1);
	goto next_token;
      }

      if (*context->text == '\\') {
	/*
	 * Escaped sequence
	 */
	char	buf[TCL_UTF_MAX];
	int	len, consumed;

	/*
	 * XXX Tcl_UtfBackslash() may be more -- OK tcl9
	 * XXX permissive, than JSON standard.
	 * XXX But that may be a good thing:
	 * XXX "be generous in what you accept".
	 */
	len = Tcl_UtfBackslash(context->text, &consumed, buf); /* OK tcl9 */
	DRAIN(consumed - 1);
      }
      continue;
    }

    switch (*context->text) {
    case ',':
    case '{':
    case ':':
    case '}':
    case '[':
    case ']':
      DRAIN(1);
      goto next_token;

    case 't':
      if ((context->remaining < 4) ||
	  strncmp("rue", context->text + 1, 3))
	return -1; /* bare word */
      DRAIN(4);
      goto next_token;
    case 'f':
      if ((context->remaining < 5) ||
	  strncmp("alse", context->text + 1, 4))
	return -1; /* bare word */
      DRAIN(5);
      goto next_token;
    case 'n':
      if ((context->remaining < 4) ||
	  strncmp("ull", context->text + 1, 3))
	return -1; /* bare word */
      DRAIN(4);
      goto next_token;
    case '"':
      bp = context->text + 1;
      lstate = INSTR;
      continue;
    case '\\':
      /* Escape outside string, abort. */
      return -1;
    }

    /*
     * We already considered the null, true, and false
     * above, so it can only be a number now.
     *
     * NOTE: At this point we do not care about double
     * versus integer, nor about the possible integer
     * range. We generate a plain string Tcl_Obj and leave
     * it to the user of the generated structure to
     * convert to a number when actually needed. This
     * defered conversion also ensures that the Tcl and
     * platform we are building against does not matter
     * regarding integer range, only the abilities of the
     * Tcl at runtime.
     */

    d = strtod(context->text, &end);
    if (end == context->text)
      return -1; /* bare word */

    context->remaining -= (end - context->text);
    context->text = end;
    goto next_token;
  }

  return 0;

  next_token:
  continue;
  }
}
#endif

static void
jsonerror(struct context *context, const char *message)
{
  char*    fullmessage;
  char*    yytext;
  Tcl_Size yyleng;

  if (context->has_error) return;

  if (context->obj) {
    yytext = Tcl_GetStringFromObj(context->obj, &yyleng); /* OK tcl9 */
    fullmessage = Tcl_Alloc(strlen(message) + 63 + yyleng);

    sprintf(fullmessage,
	    "%s %" TCL_SIZE_MODIFIER "d bytes before end, around ``%.*s''",
	    message, context->remaining, (int) yyleng, yytext);
    /* Beware: The `%.*s` format accepts only `int` length information.
     * Which means a string longer than 2GB will not print correctly.
     * I am accepting this under the assumption that such a large string
     * will not happen.
     */
  } else {
    fullmessage = Tcl_Alloc(strlen(message) + 63);

    sprintf(fullmessage, "%s %" TCL_SIZE_MODIFIER "d bytes before end",
	    message, context->remaining);
  }

  TRACE ((">>> %s\n",fullmessage));
  Tcl_SetResult    (context->I, fullmessage, TCL_DYNAMIC);
  Tcl_SetErrorCode (context->I, "JSON", "SYNTAX", NULL);
  context->has_error = 1;
}
