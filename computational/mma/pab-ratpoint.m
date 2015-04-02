(* ::Package:: *)

(* ::Section:: *)
(*Initialization*)


Remove[a,b];


(* The derivation can be found in mma/abc.nb. *)
P[a_,b_]:=11321856 a+11964672 a^2-14708736 a^3+3105792 a^4-178176 a^5+410368 a^6-170496 a^7+18432 a^8-22643712 b-28975104 a b+71396352 a^2 b-67047936 a^3 b+41148416 a^4 b-15422464 a^5 b+3035136 a^6 b-238080 a^7 b+145953792 b^2-43043328 a b^2-53477376 a^2 b^2+24088576 a^3 b^2-555008 a^4 b^2+545792 a^5 b^2-942080 a^6 b^2+244224 a^7 b^2-18432 a^8 b^2-353387520 b^3+658876416 a b^3-578035712 a^2 b^3+316189696 a^3 b^3-114433024 a^4 b^3+26433024 a^5 b^3-3499008 a^6 b^3+201216 a^7 b^3+497255424 b^4-813162496 a b^4+556814080 a^2 b^4-203473920 a^3 b^4+41673216 a^4 b^4-4500992 a^5 b^4+196864 a^6 b^4+53603328 b^5-82706944 a b^5+53479424 a^2 b^5-17784320 a^3 b^5+3004416 a^4 b^5-204800 a^5 b^5-20829184 b^6+19633664 a b^6-6557184 a^2 b^6+877056 a^3 b^6-33792 a^4 b^6-4210688 b^7+3134976 a b^7-775168 a^2 b^7+63488 a^3 b^7-274432 b^8+137728 a b^8-17664 a^2 b^8-6144 b^9+1536 a b^9;


(* ::Section:: *)
(*Search for rational points*)


(* bMaxHeight is the max height to enumerate b to.
This cell can and should be customized. *)
bMaxHeight=10000;


(* Returns the set of rational a's solving P(a,b)=0 given a specific b. *)
rationalSolutionsToPab[b_]:=Block[{rationalSolutions,factorList,a,numFactors,i,factor},
	rationalSolutions={};
	factorList=Drop[Transpose[FactorList[P[a,b]]][[1]],1];
	numFactors=Length[factorList];
	For[i=1,i<=numFactors,i++,
		factor=factorList[[i]];
		If[Exponent[factor,a]==1,
			AppendTo[rationalSolutions,a/.Solve[factor==0,a][[1]]];
		];
	];
	rationalSolutions
];

(* Enumerate b up to bMaxHeight. *)
results={}; (* the pairs {a,b} found will be saved to this list *)
startTime=AbsoluteTime[];
lastStatusUpdateTime=startTime;
For[denominator=1,denominator<=bMaxHeight,denominator++,
	For[numerator=-bMaxHeight,numerator<=bMaxHeight,numerator++,
		If[!CoprimeQ[denominator,numerator],Continue[]];
		b=numerator/denominator;
		rationalSolutions=rationalSolutionsToPab[b];
		numRationalSolutions=Length[rationalSolutions];
		For[i=1,i<=numRationalSolutions,i++,
			a=rationalSolutions[[i]];
			Print["(a, b) = (",a,", ",b,")"];
			AppendTo[results,{a,b}];
		];
	];
	(* status update every minute *)
	If[AbsoluteTime[]-lastStatusUpdateTime>=60,
		Print["// ", Floor[AbsoluteTime[]-startTime]," seconds elapsed; ",
			  "current denominator: ",denominator,";"];
		lastStatusUpdateTime=AbsoluteTime[];
	];
];
Print[results];
Print["// Total wall clock time elapsed: ",AbsoluteTime[]-startTime," seconds"];


(* ::Section:: *)
(*Results*)


(* ::Text:: *)
(*Up to bMaxHeight=10000, we found five affine rational points.*)


(* ::Print:: *)
(*{{3,0},{0,0},{6,9},{4,1/3},{1,8/3}}*)


(* ::Text:: *)
(*See mma/abc.nb for a discussion of singularity.*)
