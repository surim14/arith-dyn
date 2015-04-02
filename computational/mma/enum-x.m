(* ::Package:: *)

(* ::Section:: *)
(*Initialization*)


Remove[a,b,sqrtd,d];


(* ::Text:: *)
(*Subscript[C, 0](5) is birationally equivalent to y^2=f(x), where f(x) is defined as follows.*)


f[x_]:=x^6+8x^5+22x^4+22x^3+5x^2+6x+1;


(* ::Text:: *)
(*For a, b, and d rational, f(a + b Sqrt[d]) will be written in the form (rational part)+(irrational part)Sqrt[d] to facilitate taking the norm in the quadratic extension Q(Sqrt[d]) to Q.*)


(* rational part *)
Sum[Coefficient[f[a+b sqrtd],sqrtd,2i]d^i,{i,0,3}]
(* irrational part *)
Sum[Coefficient[f[a+b sqrtd],sqrtd,2i+1]d^i,{i,0,2}]


(* ::Output:: *)
(*1+6 a+5 a^2+22 a^3+22 a^4+8 a^5+a^6+(5 b^2+66 a b^2+132 a^2 b^2+80 a^3 b^2+15 a^4 b^2) d+(22 b^4+40 a b^4+15 a^2 b^4) d^2+b^6 d^3*)


(* ::Output:: *)
(*6 b+10 a b+66 a^2 b+88 a^3 b+40 a^4 b+6 a^5 b+(22 b^3+88 a b^3+80 a^2 b^3+20 a^3 b^3) d+(8 b^5+6 a b^5) d^2*)


rationalPart[a_,b_,d_]:=1+6 a+5 a^2+22 a^3+22 a^4+8 a^5+a^6+(5 b^2+66 a b^2+132 a^2 b^2+80 a^3 b^2+15 a^4 b^2) d+(22 b^4+40 a b^4+15 a^2 b^4) d^2+b^6 d^3;
irrationalPart[a_,b_,d_]:=6 b+10 a b+66 a^2 b+88 a^3 b+40 a^4 b+6 a^5 b+(22 b^3+88 a b^3+80 a^2 b^3+20 a^3 b^3) d+(8 b^5+6 a b^5) d^2;


(* ::Text:: *)
(*Also, c is given in terms of x and y as follows.*)


g[x_]:=8x^6+74x^5+271x^4+452x^3+325x^2+110x+64;
P0[x_]:=-x^6-10x^5-46x^4-104x^3-95x^2-24x-9;
P1[x_]:=x^3+6x^2+3x-9;
c[x_,y_]:=FullSimplify[g[x]/(2(P0[x]-P1[x]y))];


(* ::Section:: *)
(*Search*)


(* Define max heights to enumerate to for x = p1/q1 + p2/q2 sqrt(d),
where the max height of d is defined as dMaxHeight,
and for a given d, the max height of p1, p2, q1, and q2 is defined as pqMaxHeight.

This cell can and should be customized.*)
dMaxHeight=100;
pqMaxHeight=10;


(* Test if a + b sqrt(d) is a square in Q(sqrt(d)). *)
isSquareInQsqrtd[a_,b_,d_]:=Block[{x,norm},
	norm=a^2-b^2 d;
	If[!Element[Sqrt[norm],Rationals],
		Return[False];
	];
	Return[!IrreduciblePolynomialQ[x^2-a-b Sqrt[d],Extension->Sqrt[d]]];
];

(* Enumerate x = p1/q1 + p2/q2 sqrt(d). *)
startTime=AbsoluteTime[];
lastStatusUpdateTime=startTime;
For[d=-dMaxHeight,d<=dMaxHeight,d++,
    (* only proceed with the search for squarefree d not equal to 1 *)
	If[d==0||d==1||!SquareFreeQ[d],Continue[]];

	For[p1=-pqMaxHeight,p1<=pqMaxHeight,p1++,
		For[q1=1,q1<=pqMaxHeight,q1++,
			If[!CoprimeQ[p1,q1],Continue[]];
			For[p2=-pqMaxHeight,p2<=pqMaxHeight,p2++,
				If[p2==0,Continue[]]; (* skip rational x *)
				For[q2=1,q2<=pqMaxHeight,q2++,
					If[!CoprimeQ[p2,q2],Continue[]];
					r1=p1/q1;
					r2=p2/q2;
					(* calculate the rational and irrational parts of f(x) *)
					fxRationalPart=rationalPart[r1,r2,d];
					fxIrrationalPart=irrationalPart[r1,r2,d];
					If[isSquareInQsqrtd[fxRationalPart,fxIrrationalPart,d],
						x=r1+r2 Sqrt[d];
						sqrtfx=FullSimplify[Sqrt[fxRationalPart+fxIrrationalPart Sqrt[d]]];
						Print["d = ",d,", x = ",x,", y = ",sqrtfx,", c = ",c[x,sqrtfx]];
						Print["d = ",d,", x = ",x,", y = ",-sqrtfx,", c = ",c[x,-sqrtfx]];
					];
				];
			];
		];
	];

	(* try to provide status update every minute *)
	If[AbsoluteTime[]-lastStatusUpdateTime>=60,
		Print["// ", Floor[AbsoluteTime[]-startTime]," seconds elapsed; ",
              "current d: ",d,";"];
		lastStatusUpdateTime=AbsoluteTime[];
	];
];
Print["// Total wall clock time elapsed: ",AbsoluteTime[]-startTime," seconds"];


(* ::Section:: *)
(*Results*)


(* ::Text:: *)
(*For dMaxHeight=100, pqMaxHeight=10, we have the following:*)


(* ::Print:: *)
(*SequenceForm["d = ", -87, ", x = ", Rational[-1, 2] + Complex[0, Rational[-1, 2]] Rational[29, 3]^Rational[1, 2], ", y = ", Rational[1, 9] (66 + Complex[0, -5] 87^Rational[1, 2]), ", c = ", Rational[1, 86528] (12767 + Complex[0, 13371] 87^Rational[1, 2])]*)


(* ::Print:: *)
(*SequenceForm["d = ", -87, ", x = ", Rational[-1, 2] + Complex[0, Rational[-1, 2]] Rational[29, 3]^Rational[1, 2], ", y = ", Rational[1, 9] (-66 + Complex[0, 5] 87^Rational[1, 2]), ", c = ", Rational[-4, 3]]*)


(* ::Print:: *)
(*SequenceForm["d = ", -87, ", x = ", Rational[-1, 2] + Complex[0, Rational[1, 2]] Rational[29, 3]^Rational[1, 2], ", y = ", Rational[1, 9] (66 + Complex[0, 5] 87^Rational[1, 2]), ", c = ", Rational[1, 86528] (12767 + Complex[0, -13371] 87^Rational[1, 2])]*)


(* ::Print:: *)
(*SequenceForm["d = ", -87, ", x = ", Rational[-1, 2] + Complex[0, Rational[1, 2]] Rational[29, 3]^Rational[1, 2], ", y = ", Rational[1, 9] (-66 + Complex[0, -5] 87^Rational[1, 2]), ", c = ", Rational[-4, 3]]*)


(* ::Print:: *)
(*SequenceForm["d = ", 33, ", x = ", -2 - Rational[11, 3]^Rational[1, 2], ", y = ", Rational[1, 9] (51 + 10 33^Rational[1, 2]), ", c = ", -2]*)


(* ::Print:: *)
(*SequenceForm["d = ", 33, ", x = ", -2 - Rational[11, 3]^Rational[1, 2], ", y = ", Rational[1, 9] (-51 - 10 33^Rational[1, 2]), ", c = ", Rational[1, 384] (-6415 + 807 33^Rational[1, 2])]*)


(* ::Print:: *)
(*SequenceForm["d = ", 33, ", x = ", -2 + Rational[11, 3]^Rational[1, 2], ", y = ", Rational[1, 9] (-51 + 10 33^Rational[1, 2]), ", c = ", Rational[1, 384] (-6415 - 807 33^Rational[1, 2])]*)


(* ::Print:: *)
(*SequenceForm["d = ", 33, ", x = ", -2 + Rational[11, 3]^Rational[1, 2], ", y = ", Rational[1, 9] (51 - 10 33^Rational[1, 2]), ", c = ", -2]*)


(* ::Text:: *)
(*None of the rational c corresponds to quadratic periodic points of exact period 5.*)
