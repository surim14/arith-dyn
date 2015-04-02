(* ::Package:: *)

(* ::Section:: *)
(*Code*)


(* Define the dynatomic polynomial Subscript[\[CapitalPhi], N](z,c). *)
\[Phi][z_,c_]:=z^2+c;
\[CapitalPhi][N_,z_,c_]:=Product[If[Divisible[N,d],(Nest[\[Phi][#,c]&,z,d]-z)^(MoebiusMu[N/d]),1],{d,1,N}];


(* Set the cycle size N and the maximum height to enumerate to.
This cell can and should be customized.*)
cycleSizeN=4;
maxHeight=1000;


(* Test if Subscript[\[Phi], c](z) has quadratic periodic points of exact period N
by factorizing Subscript[\[CapitalPhi], N,c](z) over Q and looking for quadratic factors. *)
hasQuadraticPeriodicPoints[c_]:=Block[{z,factorList,numFactors,factorDegreeList},
	(* Calculate the list of degrees of the irreducible factors of Subscript[\[CapitalPhi], N,c](z) over Q. *)
	factorList=Drop[Transpose[FactorList[\[CapitalPhi][cycleSizeN,z,c]]][[1]],1];
	numFactors=Length[factorList];
	factorDegreeList=Array[Exponent[factorList[[#]],z]&,numFactors];
	Return[MemberQ[factorDegreeList,2]];
];

(* Enumerate c up to maxHeight *)
results={}; (* the c's found will be saved to this list *)
startTime=AbsoluteTime[];
lastStatusUpdateTime=startTime;
For[denominator=1,denominator<=maxHeight,denominator++,
	For[numerator=-maxHeight,numerator<=maxHeight,numerator++,
		If[!CoprimeQ[denominator,numerator],Continue[]];
		c=numerator/denominator;
		If[hasQuadraticPeriodicPoints[c],
			Print[c];
			AppendTo[results,c];
		];
		(* status update every minute *)
		If[AbsoluteTime[]-lastStatusUpdateTime>=60,
			Print["// ", Floor[AbsoluteTime[]-startTime]," seconds elapsed; ",
                  "current denominator: ",denominator,";"];
			lastStatusUpdateTime=AbsoluteTime[];
		];
	];
];
Print[results];
Print["// Total wall clock time elapsed: ",AbsoluteTime[]-startTime," seconds"];


(* ::Section:: *)
(*Results*)


(* ::Subsection:: *)
(*cycleSizeN=4, maxHeight=1000*)


(* ::Text:: *)
(*The list of c found is:*)


(* ::Print:: *)
(*{-(5/4),-(95/48),-(31/48),-(209/72),-(155/72),199/720}*)


(* ::Text:: *)
(*It turns out that c=-(5/4) only gives rise to quadratic periodic points of exact period 2; all others give rise to quadratic periodic points of exact period 4.*)


(* ::Subsection:: *)
(*cycleSizeN=5, maxHeight=1000*)


(* ::Text:: *)
(*No c found.*)


(* ::Subsection:: *)
(*cycleSizeN=6, maxHeight=500*)


(* ::Text:: *)
(*The only c found is -(71/48), and it gives rise to quadratic periodic points of exact period 6.*)
