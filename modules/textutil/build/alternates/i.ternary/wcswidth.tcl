###
# This file is automatically generated by the build/build.tcl file
# based on information in the following database:
# http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt
#
# (This is the 35th edition, thus version 35 for our package)
#
# Author: Sean Woods <yoda@etoyoc.com>
# Author: Andreas Kupries <andreas.kupries@gmail.com>
###
package require Tcl 8.5
package provide textutil::wcswidth 35.2
namespace eval ::textutil {}

proc ::textutil::wcswidth_type char {
    return [expr {
	(($char <= 9734)
	? (($char <= 8318)
	    ? (($char <= 465)
		? (($char <= 252)
		    ? (($char <= 208)
			? (($char <= 175)
			    ? (($char <= 168)
				? (($char <= 164)
				    ? (($char <= 163)
					? (($char <= 161)
					    ? (($char <= 160)
						? "N"
						: "A")
					    : "N")
					: "A")
				    : (($char <= 166)
					? "N"
					: "A"))
				: (($char <= 172)
				    ? (($char <= 170)
					? (($char <= 169)
					    ? "N"
					    : "A")
					: "N")
				    : (($char <= 174)
					? "A"
					: "N")))
			    : (($char <= 191)
				? (($char <= 186)
				    ? (($char <= 181)
					? (($char <= 180)
					    ? "A"
					    : "N")
					: "A")
				    : (($char <= 187)
					? "N"
					: "A"))
				: (($char <= 207)
				    ? (($char <= 198)
					? (($char <= 197)
					    ? "N"
					    : "A")
					: "N")
				    : "A")))
			: (($char <= 237)
			    ? (($char <= 230)
				? (($char <= 225)
				    ? (($char <= 221)
					? (($char <= 216)
					    ? (($char <= 214)
						? "N"
						: "A")
					    : "N")
					: "A")
				    : (($char <= 229)
					? "N"
					: "A"))
				: (($char <= 235)
				    ? (($char <= 234)
					? (($char <= 231)
					    ? "N"
					    : "A")
					: "N")
				    : "A"))
			    : (($char <= 246)
				? (($char <= 241)
				    ? (($char <= 240)
					? (($char <= 239)
					    ? "N"
					    : "A")
					: "N")
				    : (($char <= 243)
					? "A"
					: "N"))
				: (($char <= 251)
				    ? (($char <= 250)
					? "A"
					: "N")
				    : "A"))))
		    : (($char <= 318)
			? (($char <= 283)
			    ? (($char <= 273)
				? (($char <= 257)
				    ? (($char <= 256)
					? (($char <= 254)
					    ? (($char <= 253)
						? "N"
						: "A")
					    : "N")
					: "A")
				    : (($char <= 272)
					? "N"
					: "A"))
				: (($char <= 282)
				    ? (($char <= 275)
					? (($char <= 274)
					    ? "N"
					    : "A")
					: "N")
				    : "A"))
			    : (($char <= 304)
				? (($char <= 298)
				    ? (($char <= 295)
					? (($char <= 293)
					    ? "N"
					    : "A")
					: "N")
				    : (($char <= 299)
					? "A"
					: "N"))
				: (($char <= 312)
				    ? (($char <= 311)
					? (($char <= 307)
					    ? "A"
					    : "N")
					: "A")
				    : "N")))
			: (($char <= 357)
			    ? (($char <= 332)
				? (($char <= 327)
				    ? (($char <= 324)
					? (($char <= 323)
					    ? (($char <= 322)
						? "A"
						: "N")
					    : "A")
					: "N")
				    : (($char <= 331)
					? "A"
					: "N"))
				: (($char <= 339)
				    ? (($char <= 337)
					? (($char <= 333)
					    ? "A"
					    : "N")
					: "A")
				    : "N"))
			    : (($char <= 462)
				? (($char <= 363)
				    ? (($char <= 362)
					? (($char <= 359)
					    ? "A"
					    : "N")
					: "A")
				    : (($char <= 461)
					? "N"
					: "A"))
				: (($char <= 464)
				    ? (($char <= 463)
					? "N"
					: "A")
				    : "N")))))
		: (($char <= 944)
		    ? (($char <= 712)
			? (($char <= 476)
			    ? (($char <= 471)
				? (($char <= 469)
				    ? (($char <= 468)
					? (($char <= 467)
					    ? (($char <= 466)
						? "A"
						: "N")
					    : "A")
					: "N")
				    : (($char <= 470)
					? "A"
					: "N"))
				: (($char <= 474)
				    ? (($char <= 473)
					? (($char <= 472)
					    ? "A"
					    : "N")
					: "A")
				    : (($char <= 475)
					? "N"
					: "A")))
			    : (($char <= 707)
				? (($char <= 608)
				    ? (($char <= 593)
					? (($char <= 592)
					    ? "N"
					    : "A")
					: "N")
				    : (($char <= 609)
					? "A"
					: "N"))
				: (($char <= 711)
				    ? (($char <= 710)
					? (($char <= 708)
					    ? "A"
					    : "N")
					: "A")
				    : "N")))
			: (($char <= 734)
			    ? (($char <= 727)
				? (($char <= 719)
				    ? (($char <= 717)
					? (($char <= 716)
					    ? (($char <= 715)
						? "A"
						: "N")
					    : "A")
					: "N")
				    : (($char <= 720)
					? "A"
					: "N"))
				: (($char <= 733)
				    ? (($char <= 732)
					? (($char <= 731)
					    ? "A"
					    : "N")
					: "A")
				    : "N"))
			    : (($char <= 929)
				? (($char <= 879)
				    ? (($char <= 767)
					? (($char <= 735)
					    ? "A"
					    : "N")
					: "A")
				    : (($char <= 912)
					? "N"
					: "A"))
				: (($char <= 937)
				    ? (($char <= 930)
					? "N"
					: "A")
				    : "N"))))
		    : (($char <= 8221)
			? (($char <= 4351)
			    ? (($char <= 1039)
				? (($char <= 1024)
				    ? (($char <= 969)
					? (($char <= 962)
					    ? (($char <= 961)
						? "A"
						: "N")
					    : "A")
					: "N")
				    : (($char <= 1025)
					? "A"
					: "N"))
				: (($char <= 1105)
				    ? (($char <= 1104)
					? (($char <= 1103)
					    ? "A"
					    : "N")
					: "A")
				    : "N"))
			    : (($char <= 8214)
				? (($char <= 8208)
				    ? (($char <= 8207)
					? (($char <= 4447)
					    ? "W"
					    : "N")
					: "A")
				    : (($char <= 8210)
					? "N"
					: "A"))
				: (($char <= 8219)
				    ? (($char <= 8217)
					? (($char <= 8215)
					    ? "N"
					    : "A")
					: "N")
				    : "A")))
			: (($char <= 8244)
			    ? (($char <= 8239)
				? (($char <= 8227)
				    ? (($char <= 8226)
					? (($char <= 8223)
					    ? "N"
					    : "A")
					: "N")
				    : (($char <= 8231)
					? "A"
					: "N"))
				: (($char <= 8243)
				    ? (($char <= 8241)
					? (($char <= 8240)
					    ? "A"
					    : "N")
					: "A")
				    : "N"))
			    : (($char <= 8254)
				? (($char <= 8251)
				    ? (($char <= 8250)
					? (($char <= 8245)
					    ? "A"
					    : "N")
					: "A")
				    : (($char <= 8253)
					? "N"
					: "A"))
				: (($char <= 8308)
				    ? (($char <= 8307)
					? "N"
					: "A")
				    : "N"))))))
	    : (($char <= 8775)
		? (($char <= 8657)
		    ? (($char <= 8485)
			? (($char <= 8453)
			    ? (($char <= 8363)
				? (($char <= 8360)
				    ? (($char <= 8324)
					? (($char <= 8320)
					    ? (($char <= 8319)
						? "A"
						: "N")
					    : "A")
					: "N")
				    : (($char <= 8361)
					? "H"
					: "N"))
				: (($char <= 8451)
				    ? (($char <= 8450)
					? (($char <= 8364)
					    ? "A"
					    : "N")
					: "A")
				    : (($char <= 8452)
					? "N"
					: "A")))
			    : (($char <= 8469)
				? (($char <= 8466)
				    ? (($char <= 8457)
					? (($char <= 8456)
					    ? "N"
					    : "A")
					: "N")
				    : (($char <= 8467)
					? "A"
					: "N"))
				: (($char <= 8482)
				    ? (($char <= 8480)
					? (($char <= 8470)
					    ? "A"
					    : "N")
					: "A")
				    : "N")))
			: (($char <= 8559)
			    ? (($char <= 8538)
				? (($char <= 8530)
				    ? (($char <= 8491)
					? (($char <= 8490)
					    ? (($char <= 8486)
						? "A"
						: "N")
					    : "A")
					: "N")
				    : (($char <= 8532)
					? "A"
					: "N"))
				: (($char <= 8555)
				    ? (($char <= 8543)
					? (($char <= 8542)
					    ? "A"
					    : "N")
					: "A")
				    : "N"))
			    : (($char <= 8601)
				? (($char <= 8585)
				    ? (($char <= 8584)
					? (($char <= 8569)
					    ? "A"
					    : "N")
					: "A")
				    : (($char <= 8591)
					? "N"
					: "A"))
				: (($char <= 8633)
				    ? (($char <= 8631)
					? "N"
					: "A")
				    : "N"))))
		    : (($char <= 8725)
			? (($char <= 8710)
			    ? (($char <= 8703)
				? (($char <= 8678)
				    ? (($char <= 8660)
					? (($char <= 8659)
					    ? (($char <= 8658)
						? "A"
						: "N")
					    : "A")
					: "N")
				    : (($char <= 8679)
					? "A"
					: "N"))
				: (($char <= 8707)
				    ? (($char <= 8705)
					? (($char <= 8704)
					    ? "A"
					    : "N")
					: "A")
				    : "N"))
			    : (($char <= 8719)
				? (($char <= 8715)
				    ? (($char <= 8714)
					? (($char <= 8712)
					    ? "A"
					    : "N")
					: "A")
				    : (($char <= 8718)
					? "N"
					: "A"))
				: (($char <= 8724)
				    ? (($char <= 8721)
					? (($char <= 8720)
					    ? "N"
					    : "A")
					: "N")
				    : "A")))
			: (($char <= 8742)
			    ? (($char <= 8738)
				? (($char <= 8732)
				    ? (($char <= 8730)
					? (($char <= 8729)
					    ? "N"
					    : "A")
					: "N")
				    : (($char <= 8736)
					? "A"
					: "N"))
				: (($char <= 8741)
				    ? (($char <= 8740)
					? (($char <= 8739)
					    ? "A"
					    : "N")
					: "A")
				    : "N"))
			    : (($char <= 8759)
				? (($char <= 8750)
				    ? (($char <= 8749)
					? (($char <= 8748)
					    ? "A"
					    : "N")
					: "A")
				    : (($char <= 8755)
					? "N"
					: "A"))
				: (($char <= 8765)
				    ? (($char <= 8763)
					? "N"
					: "A")
				    : "N")))))
		: (($char <= 9203)
		    ? (($char <= 8853)
			? (($char <= 8809)
			    ? (($char <= 8799)
				? (($char <= 8785)
				    ? (($char <= 8780)
					? (($char <= 8779)
					    ? (($char <= 8776)
						? "A"
						: "N")
					    : "A")
					: "N")
				    : (($char <= 8786)
					? "A"
					: "N"))
				: (($char <= 8807)
				    ? (($char <= 8803)
					? (($char <= 8801)
					    ? "A"
					    : "N")
					: "A")
				    : "N"))
			    : (($char <= 8835)
				? (($char <= 8815)
				    ? (($char <= 8813)
					? (($char <= 8811)
					    ? "A"
					    : "N")
					: "A")
				    : (($char <= 8833)
					? "N"
					: "A"))
				: (($char <= 8852)
				    ? (($char <= 8839)
					? (($char <= 8837)
					    ? "N"
					    : "A")
					: "N")
				    : "A")))
			: (($char <= 8987)
			    ? (($char <= 8895)
				? (($char <= 8869)
				    ? (($char <= 8868)
					? (($char <= 8857)
					    ? (($char <= 8856)
						? "N"
						: "A")
					    : "N")
					: "A")
				    : (($char <= 8894)
					? "N"
					: "A"))
				: (($char <= 8985)
				    ? (($char <= 8978)
					? (($char <= 8977)
					    ? "N"
					    : "A")
					: "N")
				    : "W"))
			    : (($char <= 9199)
				? (($char <= 9192)
				    ? (($char <= 9002)
					? (($char <= 9000)
					    ? "N"
					    : "W")
					: "N")
				    : (($char <= 9196)
					? "W"
					: "N"))
				: (($char <= 9202)
				    ? (($char <= 9200)
					? "W"
					: "N")
				    : "W"))))
		    : (($char <= 9659)
			? (($char <= 9621)
			    ? (($char <= 9587)
				? (($char <= 9547)
				    ? (($char <= 9450)
					? (($char <= 9449)
					    ? (($char <= 9311)
						? "N"
						: "A")
					    : "N")
					: "A")
				    : (($char <= 9551)
					? "N"
					: "A"))
				: (($char <= 9617)
				    ? (($char <= 9615)
					? (($char <= 9599)
					    ? "N"
					    : "A")
					: "N")
				    : "A"))
			    : (($char <= 9649)
				? (($char <= 9634)
				    ? (($char <= 9633)
					? (($char <= 9631)
					    ? "N"
					    : "A")
					: "N")
				    : (($char <= 9641)
					? "A"
					: "N"))
				: (($char <= 9655)
				    ? (($char <= 9653)
					? (($char <= 9651)
					    ? "A"
					    : "N")
					: "A")
				    : "N")))
			: (($char <= 9681)
			    ? (($char <= 9672)
				? (($char <= 9665)
				    ? (($char <= 9663)
					? (($char <= 9661)
					    ? "A"
					    : "N")
					: "A")
				    : (($char <= 9669)
					? "N"
					: "A"))
				: (($char <= 9677)
				    ? (($char <= 9675)
					? (($char <= 9674)
					    ? "N"
					    : "A")
					: "N")
				    : "A"))
			    : (($char <= 9724)
				? (($char <= 9710)
				    ? (($char <= 9701)
					? (($char <= 9697)
					    ? "N"
					    : "A")
					: "N")
				    : (($char <= 9711)
					? "A"
					: "N"))
				: (($char <= 9732)
				    ? (($char <= 9726)
					? "W"
					: "N")
				    : "A")))))))
	: (($char <= 65497)
	    ? (($char <= 10070)
		? (($char <= 9918)
		    ? (($char <= 9829)
			? (($char <= 9791)
			    ? (($char <= 9749)
				? (($char <= 9743)
				    ? (($char <= 9741)
					? (($char <= 9737)
					    ? (($char <= 9736)
						? "N"
						: "A")
					    : "N")
					: "A")
				    : (($char <= 9747)
					? "N"
					: "W"))
				: (($char <= 9757)
				    ? (($char <= 9756)
					? (($char <= 9755)
					    ? "N"
					    : "A")
					: "N")
				    : (($char <= 9758)
					? "A"
					: "N")))
			    : (($char <= 9811)
				? (($char <= 9794)
				    ? (($char <= 9793)
					? (($char <= 9792)
					    ? "A"
					    : "N")
					: "A")
				    : (($char <= 9799)
					? "N"
					: "W"))
				: (($char <= 9826)
				    ? (($char <= 9825)
					? (($char <= 9823)
					    ? "N"
					    : "A")
					: "N")
				    : "A")))
			: (($char <= 9875)
			    ? (($char <= 9839)
				? (($char <= 9837)
				    ? (($char <= 9835)
					? (($char <= 9834)
					    ? (($char <= 9830)
						? "N"
						: "A")
					    : "N")
					: "A")
				    : (($char <= 9838)
					? "N"
					: "A"))
				: (($char <= 9874)
				    ? (($char <= 9855)
					? (($char <= 9854)
					    ? "N"
					    : "W")
					: "N")
				    : "W"))
			    : (($char <= 9897)
				? (($char <= 9888)
				    ? (($char <= 9887)
					? (($char <= 9885)
					    ? "N"
					    : "A")
					: "N")
				    : (($char <= 9889)
					? "W"
					: "N"))
				: (($char <= 9916)
				    ? (($char <= 9899)
					? "W"
					: "N")
				    : "W"))))
		    : (($char <= 9978)
			? (($char <= 9955)
			    ? (($char <= 9939)
				? (($char <= 9933)
				    ? (($char <= 9925)
					? (($char <= 9923)
					    ? (($char <= 9919)
						? "A"
						: "N")
					    : "W")
					: "A")
				    : (($char <= 9934)
					? "W"
					: "A"))
				: (($char <= 9954)
				    ? (($char <= 9953)
					? (($char <= 9940)
					    ? "W"
					    : "A")
					: "N")
				    : "A"))
			    : (($char <= 9971)
				? (($char <= 9962)
				    ? (($char <= 9961)
					? (($char <= 9959)
					    ? "N"
					    : "A")
					: "W")
				    : (($char <= 9969)
					? "A"
					: "W"))
				: (($char <= 9977)
				    ? (($char <= 9973)
					? (($char <= 9972)
					    ? "A"
					    : "W")
					: "A")
				    : "W")))
			: (($char <= 10044)
			    ? (($char <= 9993)
				? (($char <= 9988)
				    ? (($char <= 9983)
					? (($char <= 9981)
					    ? (($char <= 9980)
						? "A"
						: "W")
					    : "A")
					: "N")
				    : (($char <= 9989)
					? "W"
					: "N"))
				: (($char <= 10024)
				    ? (($char <= 10023)
					? (($char <= 9995)
					    ? "W"
					    : "N")
					: "W")
				    : "N"))
			    : (($char <= 10062)
				? (($char <= 10060)
				    ? (($char <= 10059)
					? (($char <= 10045)
					    ? "A"
					    : "N")
					: "W")
				    : (($char <= 10061)
					? "N"
					: "W"))
				: (($char <= 10069)
				    ? (($char <= 10066)
					? "N"
					: "W")
				    : "N")))))
		: (($char <= 12771)
		    ? (($char <= 11930)
			? (($char <= 11034)
			    ? (($char <= 10159)
				? (($char <= 10132)
				    ? (($char <= 10111)
					? (($char <= 10101)
					    ? (($char <= 10071)
						? "W"
						: "N")
					    : "A")
					: "N")
				    : (($char <= 10135)
					? "W"
					: "N"))
				: (($char <= 10175)
				    ? (($char <= 10174)
					? (($char <= 10160)
					    ? "W"
					    : "N")
					: "W")
				    : "N"))
			    : (($char <= 11093)
				? (($char <= 11088)
				    ? (($char <= 11087)
					? (($char <= 11036)
					    ? "W"
					    : "N")
					: "W")
				    : (($char <= 11092)
					? "N"
					: "W"))
				: (($char <= 11929)
				    ? (($char <= 11903)
					? (($char <= 11097)
					    ? "A"
					    : "N")
					: "W")
				    : "N")))
			: (($char <= 12438)
			    ? (($char <= 12287)
				? (($char <= 12271)
				    ? (($char <= 12245)
					? (($char <= 12031)
					    ? (($char <= 12019)
						? "W"
						: "N")
					    : "W")
					: "N")
				    : (($char <= 12283)
					? "W"
					: "N"))
				: (($char <= 12352)
				    ? (($char <= 12350)
					? (($char <= 12288)
					    ? "F"
					    : "W")
					: "N")
				    : "W"))
			    : (($char <= 12592)
				? (($char <= 12548)
				    ? (($char <= 12543)
					? (($char <= 12440)
					    ? "N"
					    : "W")
					: "N")
				    : (($char <= 12591)
					? "W"
					: "N"))
				: (($char <= 12687)
				    ? (($char <= 12686)
					? "W"
					: "N")
				    : "W"))))
		    : (($char <= 65039)
			? (($char <= 42182)
			    ? (($char <= 19903)
				? (($char <= 12871)
				    ? (($char <= 12831)
					? (($char <= 12830)
					    ? (($char <= 12783)
						? "N"
						: "W")
					    : "N")
					: "W")
				    : (($char <= 12879)
					? "A"
					: "W"))
				: (($char <= 42127)
				    ? (($char <= 42124)
					? (($char <= 19967)
					    ? "N"
					    : "W")
					: "N")
				    : "W"))
			    : (($char <= 57343)
				? (($char <= 44031)
				    ? (($char <= 43388)
					? (($char <= 43359)
					    ? "N"
					    : "W")
					: "N")
				    : (($char <= 55203)
					? "W"
					: "N"))
				: (($char <= 65023)
				    ? (($char <= 64255)
					? (($char <= 63743)
					    ? "A"
					    : "W")
					: "N")
				    : "A")))
			: (($char <= 65376)
			    ? (($char <= 65126)
				? (($char <= 65106)
				    ? (($char <= 65071)
					? (($char <= 65049)
					    ? "W"
					    : "N")
					: "W")
				    : (($char <= 65107)
					? "N"
					: "W"))
				: (($char <= 65280)
				    ? (($char <= 65131)
					? (($char <= 65127)
					    ? "N"
					    : "W")
					: "N")
				    : "F"))
			    : (($char <= 65487)
				? (($char <= 65479)
				    ? (($char <= 65473)
					? (($char <= 65470)
					    ? "H"
					    : "N")
					: "H")
				    : (($char <= 65481)
					? "N"
					: "H"))
				: (($char <= 65495)
				    ? (($char <= 65489)
					? "N"
					: "H")
				    : "N"))))))
	    : (($char <= 127991)
		? (($char <= 127247)
		    ? (($char <= 110580)
			? (($char <= 94193)
			    ? (($char <= 65532)
				? (($char <= 65511)
				    ? (($char <= 65510)
					? (($char <= 65503)
					    ? (($char <= 65500)
						? "H"
						: "N")
					    : "F")
					: "N")
				    : (($char <= 65518)
					? "H"
					: "N"))
				: (($char <= 94180)
				    ? (($char <= 94175)
					? (($char <= 65533)
					    ? "A"
					    : "N")
					: "W")
				    : (($char <= 94191)
					? "N"
					: "W")))
			    : (($char <= 101631)
				? (($char <= 100351)
				    ? (($char <= 100343)
					? (($char <= 94207)
					    ? "N"
					    : "W")
					: "N")
				    : (($char <= 101589)
					? "W"
					: "N"))
				: (($char <= 110579)
				    ? (($char <= 110575)
					? (($char <= 101640)
					    ? "W"
					    : "N")
					: "W")
				    : "N")))
			: (($char <= 110959)
			    ? (($char <= 110927)
				? (($char <= 110591)
				    ? (($char <= 110590)
					? (($char <= 110588)
					    ? (($char <= 110587)
						? "W"
						: "N")
					    : "W")
					: "N")
				    : (($char <= 110882)
					? "W"
					: "N"))
				: (($char <= 110951)
				    ? (($char <= 110947)
					? (($char <= 110930)
					    ? "W"
					    : "N")
					: "W")
				    : "N"))
			    : (($char <= 127183)
				? (($char <= 126980)
				    ? (($char <= 126979)
					? (($char <= 111355)
					    ? "W"
					    : "N")
					: "W")
				    : (($char <= 127182)
					? "N"
					: "W"))
				: (($char <= 127242)
				    ? (($char <= 127231)
					? "N"
					: "A")
				    : "N"))))
		    : (($char <= 127589)
			? (($char <= 127487)
			    ? (($char <= 127374)
				? (($char <= 127343)
				    ? (($char <= 127337)
					? (($char <= 127279)
					    ? (($char <= 127277)
						? "A"
						: "N")
					    : "A")
					: "N")
				    : (($char <= 127373)
					? "A"
					: "W"))
				: (($char <= 127404)
				    ? (($char <= 127386)
					? (($char <= 127376)
					    ? "A"
					    : "W")
					: "A")
				    : "N"))
			    : (($char <= 127560)
				? (($char <= 127547)
				    ? (($char <= 127503)
					? (($char <= 127490)
					    ? "W"
					    : "N")
					: "W")
				    : (($char <= 127551)
					? "N"
					: "W"))
				: (($char <= 127583)
				    ? (($char <= 127569)
					? (($char <= 127567)
					    ? "N"
					    : "W")
					: "N")
				    : "W")))
			: (($char <= 127903)
			    ? (($char <= 127798)
				? (($char <= 127788)
				    ? (($char <= 127776)
					? (($char <= 127743)
					    ? "N"
					    : "W")
					: "N")
				    : (($char <= 127797)
					? "W"
					: "N"))
				: (($char <= 127891)
				    ? (($char <= 127869)
					? (($char <= 127868)
					    ? "W"
					    : "N")
					: "W")
				    : "N"))
			    : (($char <= 127984)
				? (($char <= 127955)
				    ? (($char <= 127950)
					? (($char <= 127946)
					    ? "W"
					    : "N")
					: "W")
				    : (($char <= 127967)
					? "N"
					: "W"))
				: (($char <= 127988)
				    ? (($char <= 127987)
					? "N"
					: "W")
				    : "N")))))
		: (($char <= 129008)
		    ? (($char <= 128591)
			? (($char <= 128335)
			    ? (($char <= 128254)
				? (($char <= 128065)
				    ? (($char <= 128064)
					? (($char <= 128063)
					    ? (($char <= 128062)
						? "W"
						: "N")
					    : "W")
					: "N")
				    : (($char <= 128252)
					? "W"
					: "N"))
				: (($char <= 128334)
				    ? (($char <= 128330)
					? (($char <= 128317)
					    ? "W"
					    : "N")
					: "W")
				    : "N"))
			    : (($char <= 128406)
				? (($char <= 128378)
				    ? (($char <= 128377)
					? (($char <= 128359)
					    ? "W"
					    : "N")
					: "W")
				    : (($char <= 128404)
					? "N"
					: "W"))
				: (($char <= 128506)
				    ? (($char <= 128420)
					? (($char <= 128419)
					    ? "N"
					    : "W")
					: "N")
				    : "W")))
			: (($char <= 128735)
			    ? (($char <= 128722)
				? (($char <= 128716)
				    ? (($char <= 128715)
					? (($char <= 128709)
					    ? (($char <= 128639)
						? "N"
						: "W")
					    : "N")
					: "W")
				    : (($char <= 128719)
					? "N"
					: "W"))
				: (($char <= 128732)
				    ? (($char <= 128727)
					? (($char <= 128724)
					    ? "N"
					    : "W")
					: "N")
				    : "W"))
			    : (($char <= 128991)
				? (($char <= 128755)
				    ? (($char <= 128748)
					? (($char <= 128746)
					    ? "N"
					    : "W")
					: "N")
				    : (($char <= 128764)
					? "W"
					: "N"))
				: (($char <= 129007)
				    ? (($char <= 129003)
					? "W"
					: "N")
				    : "W"))))
		    : (($char <= 129733)
			? (($char <= 129660)
			    ? (($char <= 129535)
				? (($char <= 129349)
				    ? (($char <= 129339)
					? (($char <= 129338)
					    ? (($char <= 129291)
						? "N"
						: "W")
					    : "N")
					: "W")
				    : (($char <= 129350)
					? "N"
					: "W"))
				: (($char <= 129655)
				    ? (($char <= 129652)
					? (($char <= 129647)
					    ? "N"
					    : "W")
					: "N")
				    : "W"))
			    : (($char <= 129711)
				? (($char <= 129679)
				    ? (($char <= 129670)
					? (($char <= 129663)
					    ? "N"
					    : "W")
					: "N")
				    : (($char <= 129708)
					? "W"
					: "N"))
				: (($char <= 129727)
				    ? (($char <= 129722)
					? "W"
					: "N")
				    : "W")))
			: (($char <= 196607)
			    ? (($char <= 129775)
				? (($char <= 129759)
				    ? (($char <= 129753)
					? (($char <= 129743)
					    ? "N"
					    : "W")
					: "N")
				    : (($char <= 129767)
					? "W"
					: "N"))
				: (($char <= 196605)
				    ? (($char <= 131071)
					? (($char <= 129782)
					    ? "W"
					    : "N")
					: "W")
				    : "N"))
			    : (($char <= 1048573)
				? (($char <= 917999)
				    ? (($char <= 917759)
					? (($char <= 262141)
					    ? "W"
					    : "N")
					: "A")
				    : (($char <= 983039)
					? "N"
					: "A"))
				: (($char <= 1114109)
				    ? (($char <= 1048575)
					? "N"
					: "A")
				    : "N"))))))))
    }]
}

proc ::textutil::wcswidth_char char {
    return [expr {
	(($char <= 94193)
	? (($char <= 10160)
	    ? (($char <= 9934)
		? (($char <= 9799)
		    ? (($char <= 9199)
			? (($char <= 9000)
			    ? (($char <= 8985)
				? (($char <= 4447)
				    ? (($char <= 4351)
					? 1
					: 2)
				    : 1)
				: (($char <= 8987)
				    ? 2
				    : 1))
			    : (($char <= 9196)
				? (($char <= 9192)
				    ? (($char <= 9002)
					? 2
					: 1)
				    : 2)
				: 1))
			: (($char <= 9726)
			    ? (($char <= 9203)
				? (($char <= 9202)
				    ? (($char <= 9200)
					? 2
					: 1)
				    : 2)
				: (($char <= 9724)
				    ? 1
				    : 2))
			    : (($char <= 9749)
				? (($char <= 9747)
				    ? 1
				    : 2)
				: 1)))
		    : (($char <= 9897)
			? (($char <= 9875)
			    ? (($char <= 9855)
				? (($char <= 9854)
				    ? (($char <= 9811)
					? 2
					: 1)
				    : 2)
				: (($char <= 9874)
				    ? 1
				    : 2))
			    : (($char <= 9889)
				? (($char <= 9888)
				    ? 1
				    : 2)
				: 1))
			: (($char <= 9923)
			    ? (($char <= 9918)
				? (($char <= 9916)
				    ? (($char <= 9899)
					? 2
					: 1)
				    : 2)
				: 1)
			    : (($char <= 9933)
				? (($char <= 9925)
				    ? 2
				    : 1)
				: 2))))
		: (($char <= 9995)
		    ? (($char <= 9977)
			? (($char <= 9969)
			    ? (($char <= 9961)
				? (($char <= 9940)
				    ? (($char <= 9939)
					? 1
					: 2)
				    : 1)
				: (($char <= 9962)
				    ? 2
				    : 1))
			    : (($char <= 9973)
				? (($char <= 9972)
				    ? (($char <= 9971)
					? 2
					: 1)
				    : 2)
				: 1))
			: (($char <= 9988)
			    ? (($char <= 9981)
				? (($char <= 9980)
				    ? (($char <= 9978)
					? 2
					: 1)
				    : 2)
				: 1)
			    : (($char <= 9993)
				? (($char <= 9989)
				    ? 2
				    : 1)
				: 2)))
		    : (($char <= 10069)
			? (($char <= 10061)
			    ? (($char <= 10059)
				? (($char <= 10024)
				    ? (($char <= 10023)
					? 1
					: 2)
				    : 1)
				: (($char <= 10060)
				    ? 2
				    : 1))
			    : (($char <= 10066)
				? (($char <= 10062)
				    ? 2
				    : 1)
				: 2))
			: (($char <= 10135)
			    ? (($char <= 10132)
				? (($char <= 10071)
				    ? (($char <= 10070)
					? 1
					: 2)
				    : 1)
				: 2)
			    : (($char <= 10159)
				? 1
				: 2)))))
	    : (($char <= 12831)
		? (($char <= 12283)
		    ? (($char <= 11903)
			? (($char <= 11087)
			    ? (($char <= 11034)
				? (($char <= 10175)
				    ? (($char <= 10174)
					? 1
					: 2)
				    : 1)
				: (($char <= 11036)
				    ? 2
				    : 1))
			    : (($char <= 11093)
				? (($char <= 11092)
				    ? (($char <= 11088)
					? 2
					: 1)
				    : 2)
				: 1))
			: (($char <= 12031)
			    ? (($char <= 12019)
				? (($char <= 11930)
				    ? (($char <= 11929)
					? 2
					: 1)
				    : 2)
				: 1)
			    : (($char <= 12271)
				? (($char <= 12245)
				    ? 2
				    : 1)
				: 2)))
		    : (($char <= 12591)
			? (($char <= 12440)
			    ? (($char <= 12352)
				? (($char <= 12350)
				    ? (($char <= 12287)
					? 1
					: 2)
				    : 1)
				: (($char <= 12438)
				    ? 2
				    : 1))
			    : (($char <= 12548)
				? (($char <= 12543)
				    ? 2
				    : 1)
				: 2))
			: (($char <= 12771)
			    ? (($char <= 12687)
				? (($char <= 12686)
				    ? (($char <= 12592)
					? 1
					: 2)
				    : 1)
				: 2)
			    : (($char <= 12830)
				? (($char <= 12783)
				    ? 1
				    : 2)
				: 1))))
		: (($char <= 65049)
		    ? (($char <= 43359)
			? (($char <= 42124)
			    ? (($char <= 19903)
				? (($char <= 12879)
				    ? (($char <= 12871)
					? 2
					: 1)
				    : 2)
				: (($char <= 19967)
				    ? 1
				    : 2))
			    : (($char <= 42182)
				? (($char <= 42127)
				    ? 1
				    : 2)
				: 1))
			: (($char <= 63743)
			    ? (($char <= 55203)
				? (($char <= 44031)
				    ? (($char <= 43388)
					? 2
					: 1)
				    : 2)
				: 1)
			    : (($char <= 65039)
				? (($char <= 64255)
				    ? 2
				    : 1)
				: 2)))
		    : (($char <= 65376)
			? (($char <= 65127)
			    ? (($char <= 65107)
				? (($char <= 65106)
				    ? (($char <= 65071)
					? 1
					: 2)
				    : 1)
				: (($char <= 65126)
				    ? 2
				    : 1))
			    : (($char <= 65280)
				? (($char <= 65131)
				    ? 2
				    : 1)
				: 2))
			: (($char <= 94180)
			    ? (($char <= 94175)
				? (($char <= 65510)
				    ? (($char <= 65503)
					? 1
					: 2)
				    : 1)
				: 2)
			    : (($char <= 94191)
				? 1
				: 2))))))
	: (($char <= 128254)
	    ? (($char <= 127503)
		? (($char <= 110930)
		    ? (($char <= 110580)
			? (($char <= 101631)
			    ? (($char <= 100351)
				? (($char <= 100343)
				    ? (($char <= 94207)
					? 1
					: 2)
				    : 1)
				: (($char <= 101589)
				    ? 2
				    : 1))
			    : (($char <= 110579)
				? (($char <= 110575)
				    ? (($char <= 101640)
					? 2
					: 1)
				    : 2)
				: 1))
			: (($char <= 110591)
			    ? (($char <= 110590)
				? (($char <= 110588)
				    ? (($char <= 110587)
					? 2
					: 1)
				    : 2)
				: 1)
			    : (($char <= 110927)
				? (($char <= 110882)
				    ? 2
				    : 1)
				: 2)))
		    : (($char <= 127183)
			? (($char <= 126979)
			    ? (($char <= 110959)
				? (($char <= 110951)
				    ? (($char <= 110947)
					? 1
					: 2)
				    : 1)
				: (($char <= 111355)
				    ? 2
				    : 1))
			    : (($char <= 127182)
				? (($char <= 126980)
				    ? 2
				    : 1)
				: 2))
			: (($char <= 127386)
			    ? (($char <= 127376)
				? (($char <= 127374)
				    ? (($char <= 127373)
					? 1
					: 2)
				    : 1)
				: 2)
			    : (($char <= 127490)
				? (($char <= 127487)
				    ? 1
				    : 2)
				: 1))))
		: (($char <= 127903)
		    ? (($char <= 127776)
			? (($char <= 127569)
			    ? (($char <= 127560)
				? (($char <= 127551)
				    ? (($char <= 127547)
					? 2
					: 1)
				    : 2)
				: (($char <= 127567)
				    ? 1
				    : 2))
			    : (($char <= 127743)
				? (($char <= 127589)
				    ? (($char <= 127583)
					? 1
					: 2)
				    : 1)
				: 2))
			: (($char <= 127868)
			    ? (($char <= 127798)
				? (($char <= 127797)
				    ? (($char <= 127788)
					? 1
					: 2)
				    : 1)
				: 2)
			    : (($char <= 127891)
				? (($char <= 127869)
				    ? 1
				    : 2)
				: 1)))
		    : (($char <= 127991)
			? (($char <= 127984)
			    ? (($char <= 127955)
				? (($char <= 127950)
				    ? (($char <= 127946)
					? 2
					: 1)
				    : 2)
				: (($char <= 127967)
				    ? 1
				    : 2))
			    : (($char <= 127988)
				? (($char <= 127987)
				    ? 1
				    : 2)
				: 1))
			: (($char <= 128065)
			    ? (($char <= 128064)
				? (($char <= 128063)
				    ? (($char <= 128062)
					? 2
					: 1)
				    : 2)
				: 1)
			    : (($char <= 128252)
				? 2
				: 1)))))
	    : (($char <= 129008)
		? (($char <= 128715)
		    ? (($char <= 128406)
			? (($char <= 128359)
			    ? (($char <= 128334)
				? (($char <= 128330)
				    ? (($char <= 128317)
					? 2
					: 1)
				    : 2)
				: (($char <= 128335)
				    ? 1
				    : 2))
			    : (($char <= 128404)
				? (($char <= 128378)
				    ? (($char <= 128377)
					? 1
					: 2)
				    : 1)
				: 2))
			: (($char <= 128591)
			    ? (($char <= 128506)
				? (($char <= 128420)
				    ? (($char <= 128419)
					? 1
					: 2)
				    : 1)
				: 2)
			    : (($char <= 128709)
				? (($char <= 128639)
				    ? 1
				    : 2)
				: 1)))
		    : (($char <= 128746)
			? (($char <= 128727)
			    ? (($char <= 128722)
				? (($char <= 128719)
				    ? (($char <= 128716)
					? 2
					: 1)
				    : 2)
				: (($char <= 128724)
				    ? 1
				    : 2))
			    : (($char <= 128735)
				? (($char <= 128732)
				    ? 1
				    : 2)
				: 1))
			: (($char <= 128991)
			    ? (($char <= 128764)
				? (($char <= 128755)
				    ? (($char <= 128748)
					? 2
					: 1)
				    : 2)
				: 1)
			    : (($char <= 129007)
				? (($char <= 129003)
				    ? 2
				    : 1)
				: 2))))
		: (($char <= 129711)
		    ? (($char <= 129652)
			? (($char <= 129350)
			    ? (($char <= 129339)
				? (($char <= 129338)
				    ? (($char <= 129291)
					? 1
					: 2)
				    : 1)
				: (($char <= 129349)
				    ? 2
				    : 1))
			    : (($char <= 129647)
				? (($char <= 129535)
				    ? 2
				    : 1)
				: 2))
			: (($char <= 129670)
			    ? (($char <= 129663)
				? (($char <= 129660)
				    ? (($char <= 129655)
					? 1
					: 2)
				    : 1)
				: 2)
			    : (($char <= 129708)
				? (($char <= 129679)
				    ? 1
				    : 2)
				: 1)))
		    : (($char <= 129775)
			? (($char <= 129753)
			    ? (($char <= 129733)
				? (($char <= 129727)
				    ? (($char <= 129722)
					? 2
					: 1)
				    : 2)
				: (($char <= 129743)
				    ? 1
				    : 2))
			    : (($char <= 129767)
				? (($char <= 129759)
				    ? 1
				    : 2)
				: 1))
			: (($char <= 196607)
			    ? (($char <= 196605)
				? (($char <= 131071)
				    ? (($char <= 129782)
					? 2
					: 1)
				    : 2)
				: 1)
			    : (($char <= 262141)
				? 2
				: 1)))))))
    }]
}

proc ::textutil::wcswidth {string} {
    set width 0
    set len [string length $string]
    foreach c [split $string {}] {
	scan $c %c char
	set n [::textutil::wcswidth_char $char]
	if {$n < 0} {
	    return -1
	}
	incr width $n
    }
    return $width
}

# This file is automatically generated by the build/build.tcl file
# based on information in the following database:
# http://www.unicode.org/Public/UCD/latest/ucd/EastAsianWidth.txt
return
