(* ::Package:: *)

(* ::Section:: *)
(*Calculating \[Lambda]1, \[Lambda]0 and their resultant*)


(* ::Subsection::Closed:: *)
(*Initialization*)


Remove[a,b,c,x,\[Lambda]1,\[Lambda]0,P,A,B,Z,Projectification,AffinePatch];


(* ::Subsection:: *)
(*Calculate \[Lambda]1 and \[Lambda]0*)


\[Lambda]1[a_,b_,c_]:=Coefficient[PolynomialRemainder[64+36 c+110 x+96 c x+325 x^2+380 c x^2+144 c^2 x^2+452 x^3+416 c x^3+96 c^2 x^3+271 x^4+184 c x^4+16 c^2 x^4+74 x^5+40 c x^5+8 x^6+4 c x^6,x^2+a x+b,x],x,1];\[Lambda]0[a_,b_,c_]:=Coefficient[PolynomialRemainder[64+36 c+110 x+96 c x+325 x^2+380 c x^2+144 c^2 x^2+452 x^3+416 c x^3+96 c^2 x^3+271 x^4+184 c x^4+16 c^2 x^4+74 x^5+40 c x^5+8 x^6+4 c x^6,x^2+a x+b,x],x,0];
Collect[\[Lambda]1[a,b,c],c]
Collect[\[Lambda]0[a,b,c],c]


(* ::Output:: *)
(*110-325 a+452 a^2-271 a^3+74 a^4-8 a^5-452 b+542 a b-222 a^2 b+32 a^3 b+74 b^2-24 a b^2+(96-380 a+416 a^2-184 a^3+40 a^4-4 a^5-416 b+368 a b-120 a^2 b+16 a^3 b+40 b^2-12 a b^2) c+(-144 a+96 a^2-16 a^3-96 b+32 a b) c^2*)


(* ::Output:: *)
(*64-325 b+452 a b-271 a^2 b+74 a^3 b-8 a^4 b+271 b^2-148 a b^2+24 a^2 b^2-8 b^3+(36-380 b+416 a b-184 a^2 b+40 a^3 b-4 a^4 b+184 b^2-80 a b^2+12 a^2 b^2-4 b^3) c+(-144 b+96 a b-16 a^2 b+16 b^2) c^2*)


(* ::Subsection:: *)
(*The resultant*)


(* ::Subsubsection::Closed:: *)
(*Case 1. The leading coefficient of \[Lambda]1 (w.r.t. c) vanishes.*)


(* ::Input:: *)
(*Factor[-144 a+96 a^2-16 a^3-96 b+32 a b]*)


(* ::Output:: *)
(*-16 (-3+a) (-3 a+a^2-2 b)*)


(* ::Text:: *)
(*Either a=3 or b=a(a-3)/2. If a=3,*)


(* ::Input:: *)
(*Factor[Resultant[\[Lambda]0[a,b,c]/.{a->3},\[Lambda]1[a,b,c]/.{a->3},c]]*)


(* ::Output:: *)
(*-16 b (8+b+2 b^2) (-720-204 b+102 b^2+38 b^3+3 b^4)*)


(* ::Text:: *)
(*b=0 is the only rational root. However,*)


(* ::Input:: *)
(*\[Lambda]1[a,b,c]/.{a->3,b->0}*)
(*\[Lambda]0[a,b,c]/.{a->3,b->0}*)


(* ::Output:: *)
(*-64*)


(* ::Output:: *)
(*64+36 c*)


(* ::Text:: *)
(*No rational solution!*)
(**)
(*If b=a(a-3)/2,*)


(* ::Input:: *)
(*Factor[Resultant[\[Lambda]0[a,b,c]/.{b->a (a-3)/2},\[Lambda]1[a,b,c]/.{b->a (a-3)/2},c]]*)


(* ::Output:: *)
(*-(1/4) (-3+a) (279552+2625536 a+7495040 a^2+2649120 a^3-20661120 a^4+19971528 a^5-8511944 a^6+1084314 a^7+655910 a^8-407133 a^9+114059 a^10-19200 a^11+1988 a^12-117 a^13+3 a^14)*)


(* ::Text:: *)
(*Again, a=3 and b=0 is the only potential rational solution. No solution for c as above.*)


(* ::Subsubsection::Closed:: *)
(*Case 2. The leading coefficient of \[Lambda]0 (w.r.t. c) vanishes.*)


(* ::Input:: *)
(*Factor[-144 b+96 a b-16 a^2 b+16 b^2]*)


(* ::Output:: *)
(*16 b (-9+6 a-a^2+b)*)


(* ::Text:: *)
(*Either b=0 or b=(a-3)^2. If b=0,*)


(* ::Input:: *)
(*Factor[Resultant[\[Lambda]0[a,b,c]/.{b->0},\[Lambda]1[a,b,c]/.{b->0},c]]*)


(* ::Output:: *)
(*-16 (4914+8469 a-1284 a^2-449 a^3-234 a^4+72 a^5)*)


(* ::Text:: *)
(*No rational solution.*)
(**)
(*If b=(a-3)^2,*)


(* ::Input:: *)
(*Factor[Resultant[\[Lambda]0[a,b,c]/.{b->(a-3)^2},\[Lambda]1[a,b,c]/.{b->(a-3)^2},c]]*)


(* ::Output:: *)
(*16 (2837172096-13478306787 a+29815106730 a^2-40797544587 a^3+38675604270 a^4-26948666005 a^5+14283976382 a^6-5877418715 a^7+1897965602 a^8-482728220 a^9+96390664 a^10-14951386 a^11+1765744 a^12-153431 a^13+9246 a^14-345 a^15+6 a^16)*)


(* ::Text:: *)
(*No rational solution.*)


(* ::Subsubsection:: *)
(*Case 3. Both leading coefficients are non-vanishing (both \[Lambda]1 and \[Lambda]2 have degree 2 in c).*)


(* ::Input:: *)
(*Resultant[\[Lambda]0[a,b,c],\[Lambda]1[a,b,c],c]*)


(* ::Output:: *)
(*11321856 a+11964672 a^2-14708736 a^3+3105792 a^4-178176 a^5+410368 a^6-170496 a^7+18432 a^8-22643712 b-28975104 a b+71396352 a^2 b-67047936 a^3 b+41148416 a^4 b-15422464 a^5 b+3035136 a^6 b-238080 a^7 b+145953792 b^2-43043328 a b^2-53477376 a^2 b^2+24088576 a^3 b^2-555008 a^4 b^2+545792 a^5 b^2-942080 a^6 b^2+244224 a^7 b^2-18432 a^8 b^2-353387520 b^3+658876416 a b^3-578035712 a^2 b^3+316189696 a^3 b^3-114433024 a^4 b^3+26433024 a^5 b^3-3499008 a^6 b^3+201216 a^7 b^3+497255424 b^4-813162496 a b^4+556814080 a^2 b^4-203473920 a^3 b^4+41673216 a^4 b^4-4500992 a^5 b^4+196864 a^6 b^4+53603328 b^5-82706944 a b^5+53479424 a^2 b^5-17784320 a^3 b^5+3004416 a^4 b^5-204800 a^5 b^5-20829184 b^6+19633664 a b^6-6557184 a^2 b^6+877056 a^3 b^6-33792 a^4 b^6-4210688 b^7+3134976 a b^7-775168 a^2 b^7+63488 a^3 b^7-274432 b^8+137728 a b^8-17664 a^2 b^8-6144 b^9+1536 a b^9*)


P[a_,b_]:=11321856 a+11964672 a^2-14708736 a^3+3105792 a^4-178176 a^5+410368 a^6-170496 a^7+18432 a^8-22643712 b-28975104 a b+71396352 a^2 b-67047936 a^3 b+41148416 a^4 b-15422464 a^5 b+3035136 a^6 b-238080 a^7 b+145953792 b^2-43043328 a b^2-53477376 a^2 b^2+24088576 a^3 b^2-555008 a^4 b^2+545792 a^5 b^2-942080 a^6 b^2+244224 a^7 b^2-18432 a^8 b^2-353387520 b^3+658876416 a b^3-578035712 a^2 b^3+316189696 a^3 b^3-114433024 a^4 b^3+26433024 a^5 b^3-3499008 a^6 b^3+201216 a^7 b^3+497255424 b^4-813162496 a b^4+556814080 a^2 b^4-203473920 a^3 b^4+41673216 a^4 b^4-4500992 a^5 b^4+196864 a^6 b^4+53603328 b^5-82706944 a b^5+53479424 a^2 b^5-17784320 a^3 b^5+3004416 a^4 b^5-204800 a^5 b^5-20829184 b^6+19633664 a b^6-6557184 a^2 b^6+877056 a^3 b^6-33792 a^4 b^6-4210688 b^7+3134976 a b^7-775168 a^2 b^7+63488 a^3 b^7-274432 b^8+137728 a b^8-17664 a^2 b^8-6144 b^9+1536 a b^9;


(* ::Section:: *)
(*Rational points on P(a,b)=0*)


(* ::Text:: *)
(*Hypothetically, the only affine rational points on P(a,b)=0 are (3,0), (0,0), (4,1/3), (1,8/3), and (6,9).*)
(*See mma/pab-ratpoint.nb for details.*)


(* ::Section:: *)
(*Singularies*)


(* ::Subsection::Closed:: *)
(*(a, b) = (3, 0) \[LongDash] node*)


(* ::Input:: *)
(*D[P[a,b],a]/.{a->3,b->0}*)
(*D[P[a,b],b]/.{a->3,b->0}*)


(* ::Output:: *)
(*0*)


(* ::Output:: *)
(*0*)


(* ::Text:: *)
(*Singular!*)


(* ::Input:: *)
(*Expand[P[a+3,b]]*)


(* ::Output:: *)
(*3981312 a^2-4409856 a^3-776448 a^4+2853888 a^5+1474816 a^6+271872 a^7+18432 a^8-2654208 a b-1317888 a^2 b+2727936 a^3 b-5430784 a^4 b-5787136 a^5 b-1964544 a^6 b-238080 a^7 b-2174976 a b^2+6127104 a^2 b^2-621056 a^3 b^2+6733312 a^4 b^2+1877504 a^5 b^2-458240 a^6 b^2-198144 a^7 b^2-18432 a^8 b^2+1474560 b^3-356352 a b^3+715264 a^2 b^3+2948608 a^3 b^3-154624 a^4 b^3+1480704 a^5 b^3+726528 a^6 b^3+201216 a^7 b^3+602112 b^4-1240576 a b^4-175616 a^2 b^4-2178048 a^3 b^4+734976 a^4 b^4-957440 a^5 b^4+196864 a^6 b^4+211968 b^5-474112 a b^5+363008 a^2 b^5-163328 a^3 b^5-67584 a^4 b^5-204800 a^5 b^5+512 b^6+321536 a b^6-488448 a^2 b^6+471552 a^3 b^6-33792 a^4 b^6-68096 b^7+198144 a b^7-203776 a^2 b^7+63488 a^3 b^7-20224 b^8+31744 a b^8-17664 a^2 b^8-1536 b^9+1536 a b^9*)


(* ::Text:: *)
(*Lowest order terms: 3981312a^2-2654208 a b \[LongDash] node.*)
(*At most two rational points upstairs.*)


(* ::Subsection::Closed:: *)
(*(a, b) = (0, 0) \[LongDash] regular point*)


(* ::Input:: *)
(*D[P[a,b],a]/.{a->0,b->0}*)
(*D[P[a,b],b]/.{a->0,b->0}*)


(* ::Output:: *)
(*11321856*)


(* ::Output:: *)
(*-22643712*)


(* ::Text:: *)
(*Not singular!*)


(* ::Subsection::Closed:: *)
(*(a, b) = (4, 1/3) \[LongDash] regular point*)


(* ::Input:: *)
(*D[P[a,b],a]/.{a->4,b->1/3}*)
(*D[P[a,b],b]/.{a->4,b->1/3}*)


(* ::Output:: *)
(*384123392/243*)


(* ::Output:: *)
(*-(3841233920/729)*)


(* ::Text:: *)
(*Not singular!*)


(* ::Subsection::Closed:: *)
(*(a, b) = (1, 8/3) \[LongDash] regular point*)


(* ::Input:: *)
(*D[P[a,b],a]/.{a->1,b->8/3}*)
(*D[P[a,b],b]/.{a->1,b->8/3}*)


(* ::Output:: *)
(*-(26661048899584/6561)*)


(* ::Output:: *)
(*-(2900365152256/729)*)


(* ::Text:: *)
(*Not singular!*)


(* ::Subsection::Closed:: *)
(*(a, b) = (6, 9) \[LongDash] regular point*)


(* ::Input:: *)
(*D[P[a,b],a]/.{a->6,b->9}*)
(*D[P[a,b],b]/.{a->6,b->9}*)


(* ::Output:: *)
(*17274539520*)


(* ::Output:: *)
(*-5922699264*)


(* ::Text:: *)
(*Not singular!*)


(* ::Subsection:: *)
(*Points at infinity*)


(* ::Text:: *)
(*Projectify:*)


Projectification[A_,B_,Z_]:=11321856 A Z^9+11964672 A^2 Z^8-14708736 A^3 Z^7+3105792 A^4 Z^6-178176 A^5 Z^5+410368 A^6 Z^4-170496 A^7 Z^3+18432 A^8 Z^2-22643712 B Z^9-28975104 A B Z^8+71396352 A^2 B Z^7-67047936 A^3 B Z^6+41148416 A^4 B Z^5-15422464 A^5 B Z^4+3035136 A^6 B Z^3-238080 A^7 B Z^2+145953792 B^2 Z^8-43043328 A B^2 Z^7-53477376 A^2 B^2 Z^6+24088576 A^3 B^2 Z^5-555008 A^4 B^2 Z^4+545792 A^5 B^2 Z^3-942080 A^6 B^2 Z^2+244224 A^7 B^2 Z-18432 A^8 B^2-353387520 B^3 Z^7+658876416 A B^3 Z^6-578035712 A^2 B^3 Z^5+316189696 A^3 B^3 Z^4-114433024 A^4 B^3 Z^3+26433024 A^5 B^3 Z^2-3499008 A^6 B^3 Z+201216 A^7 B^3+497255424 B^4 Z^6-813162496 A B^4 Z^5+556814080 A^2 B^4 Z^4-203473920 A^3 B^4 Z^3+41673216 A^4 B^4 Z^2-4500992 A^5 B^4 Z+196864 A^6 B^4+53603328 B^5 Z^5-82706944 A B^5 Z^4+53479424 A^2 B^5 Z^3-17784320 A^3 B^5 Z^2+3004416 A^4 B^5 Z-204800 A^5 B^5-20829184 B^6 Z^4+19633664 A B^6 Z^3-6557184 A^2 B^6 Z^2+877056 A^3 B^6 Z-33792 A^4 B^6-4210688 B^7 Z^3+3134976 A B^7 Z^2-775168 A^2 B^7 Z+63488 A^3 B^7-274432 B^8 Z^2+137728 A B^8 Z-17664 A^2 B^8-6144 B^9 Z+1536 A B^9


(* ::Input:: *)
(*Factor[Projectification[A,B,0]]*)


(* ::Output:: *)
(*-256 A (3 A-B)^2 B^2 (A^2-12 A B+3 B^2) (8 A^3+14 A^2 B+3 A B^2-2 B^3)*)


(* ::Text:: *)
(*From the above there are three rational points at infinity: [0, 1, 0], [1, 3, 0], and [1, 0, 0].*)
(*Again, test for singularity.*)


(* ::Subsubsection::Closed:: *)
(*(A, B, Z) = (0, 1, 0) \[LongDash] regular point*)


(* ::Input:: *)
(*D[Projectification[A,B,Z],A]/.{A->0,B->1,Z->0}*)
(*D[Projectification[A,B,Z],B]/.{A->0,B->1,Z->0}*)
(*D[Projectification[A,B,Z],Z]/.{A->0,B->1,Z->0}*)


(* ::Output:: *)
(*1536*)


(* ::Output:: *)
(*0*)


(* ::Output:: *)
(*-6144*)


(* ::Text:: *)
(*Not singular!*)


(* ::Subsubsection::Closed:: *)
(*(A, B, Z) = (1, 3, 0) \[LongDash] node*)


(* ::Input:: *)
(*D[Projectification[A,B,Z],A]/.{A->1,B->3,Z->0}*)
(*D[Projectification[A,B,Z],B]/.{A->1,B->3,Z->0}*)
(*D[Projectification[A,B,Z],Z]/.{A->1,B->3,Z->0}*)


(* ::Output:: *)
(*0*)


(* ::Output:: *)
(*0*)


(* ::Output:: *)
(*0*)


(* ::Text:: *)
(*Singular! Take affine patch:*)


AffinePatch[b_,z_]:=Projectification[1,b,z];


(* ::Input:: *)
(*Expand[AffinePatch[b+3,z]]*)


(* ::Output:: *)
(*423936 b^2-440832 b^3-566528 b^4+154624 b^5+331776 b^6+137216 b^7+23808 b^8+1536 b^9+7630848 b z-25592832 b^2 z-13135872 b^3 z+19234816 b^4 z+17823744 b^5 z+5371392 b^6 z+539648 b^7 z-28160 b^8 z-6144 b^9 z+33914880 z^2-358195200 b z^2+114640384 b^2 z^2+538229760 b^3 z^2+296211456 b^4 z^2+41755648 b^5 z^2-9879552 b^6 z^2-3451392 b^7 z^2-274432 b^8 z^2-1457565696 z^3+3739342848 b z^3+4790262272 b^2 z^3+921906176 b^3 z^3-729838080 b^4 z^3-388934656 b^5 z^3-68790784 b^6 z^3-4210688 b^7 z^3+18305947648 z^4+4789027328 b z^4-14725220864 b^2 z^4-11693425664 b^3 z^4-3495729920 b^4 z^4-457632256 b^5 z^4-20829184 b^6 z^4-68107453440 z^5-81533486080 b z^5-34616109056 b^2 z^5-5511686144 b^3 z^5-9112576 b^4 z^5+53603328 b^5 z^5+57388018176 z^6+71105336832 b z^6+32728203264 b^2 z^6+6625941504 b^3 z^6+497255424 b^4 z^6-9729372672 z^7-9728326656 b z^7-3223531008 b^2 z^7-353387520 b^3 z^7+1238623488 z^8+846747648 b z^8+145953792 b^2 z^8-56609280 z^9-22643712 b z^9*)


(* ::Text:: *)
(*Lowest order terms: 423936 b^2+7630848 b z \[LongDash] node.*)
(*At most two rational points upstairs.*)


(* ::Subsubsection::Closed:: *)
(*(A, B, Z) = (1, 0, 0) \[LongDash] node*)


(* ::Input:: *)
(*D[Projectification[A,B,Z],A]/.{A->1,B->0,Z->0}*)
(*D[Projectification[A,B,Z],B]/.{A->1,B->0,Z->0}*)
(*D[Projectification[A,B,Z],Z]/.{A->1,B->0,Z->0}*)


(* ::Output:: *)
(*0*)


(* ::Output:: *)
(*0*)


(* ::Output:: *)
(*0*)


(* ::Text:: *)
(*Singular! Use the same affine patch as above.*)


(* ::Input:: *)
(*Expand[AffinePatch[b,z]]*)


(* ::Output:: *)
(*-18432 b^2+201216 b^3+196864 b^4-204800 b^5-33792 b^6+63488 b^7-17664 b^8+1536 b^9+244224 b^2 z-3499008 b^3 z-4500992 b^4 z+3004416 b^5 z+877056 b^6 z-775168 b^7 z+137728 b^8 z-6144 b^9 z+18432 z^2-238080 b z^2-942080 b^2 z^2+26433024 b^3 z^2+41673216 b^4 z^2-17784320 b^5 z^2-6557184 b^6 z^2+3134976 b^7 z^2-274432 b^8 z^2-170496 z^3+3035136 b z^3+545792 b^2 z^3-114433024 b^3 z^3-203473920 b^4 z^3+53479424 b^5 z^3+19633664 b^6 z^3-4210688 b^7 z^3+410368 z^4-15422464 b z^4-555008 b^2 z^4+316189696 b^3 z^4+556814080 b^4 z^4-82706944 b^5 z^4-20829184 b^6 z^4-178176 z^5+41148416 b z^5+24088576 b^2 z^5-578035712 b^3 z^5-813162496 b^4 z^5+53603328 b^5 z^5+3105792 z^6-67047936 b z^6-53477376 b^2 z^6+658876416 b^3 z^6+497255424 b^4 z^6-14708736 z^7+71396352 b z^7-43043328 b^2 z^7-353387520 b^3 z^7+11964672 z^8-28975104 b z^8+145953792 b^2 z^8+11321856 z^9-22643712 b z^9*)


(* ::Text:: *)
(*Lowest order terms: -18432 b^2+18432z^2 \[LongDash] node.*)
(*At most two rational points upstairs.*)
