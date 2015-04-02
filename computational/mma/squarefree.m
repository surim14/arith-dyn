(* ::Package:: *)

SquarefreePart[n_Integer]:=Times@@Power@@@({#[[1]],Mod[#[[2]],2]}&/@FactorInteger[n]);


(*
Recall from Subsection 5.3 of the report that we are trying to calculate
    # Subscript[D, H] \[Intersection] Subscript[R, H']
    # SF \[Intersection] Subscript[R, H']
(See the report for relevant definitions.)

H is the max height H to enumerate p and q to.
Hp defines the range Subscript[R, H']=[-Hp,Hp] that we are interested in.

This cell can and should be customized.
*)
H=1000;
Hp=100000;


(* SF \[Intersection] Subscript[R, H'] *)
totalSquareFreeCount=0;
For[i=-Hp,i<=Hp,i++,
	If[SquareFreeQ[i],totalSquareFreeCount++]
];

(* Subscript[D, H] \[Intersection] Subscript[R, H'] *)
(* Enumerate p and q.
Note that by symmetry of (p^4-q^4)(p^2+2pq-q^2) it suffices to enumerate nonnegative p and q. *)
list={}; (* This list records elements of D_H intersection R_H'.*)
startTime=AbsoluteTime[];
lastStatusUpdateTime=startTime;
For [p=0,p<=H,p++,
	For[q=0,q<=H,q++,
		d=SquarefreePart[(p^4-q^4)(p^2+2p q-q^2)];
		If[d!=0&&Abs[d]<=Hp,AppendTo[list,d]];
	];
	list=DeleteDuplicates[list];
	(* status update every minute *)
	If[AbsoluteTime[]-lastStatusUpdateTime>=60,
		Print["// ", Floor[AbsoluteTime[]-startTime]," seconds elapsed; ",
			  "current p: ",p,";"];
		lastStatusUpdateTime=AbsoluteTime[];
	];
];
Print["# \!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ",Length[list],"; # SF \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ",totalSquareFreeCount,";"];
Print["\!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ",Sort[list]];
Print["// Total wall clock time elapsed: ",AbsoluteTime[]-startTime," seconds"];


(* ::Section:: *)
(*Results*)


(* ::Subsection::Closed:: *)
(*H = 100, H' = 100: 8/122*)


(* ::Print:: *)
(*SequenceForm["# \!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", 8, "; # SF \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", 122, ";"]*)


(* ::Print:: *)
(*SequenceForm["\!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", {-15, 1, 10, 15, 41, 51, 70, 93}]*)


(* ::Subsection::Closed:: *)
(*H = 100, H' = 1000: 19/1216*)


(* ::Print:: *)
(*SequenceForm["# \!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", 19, "; # SF \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", 1216, ";"]*)


(* ::Print:: *)
(*SequenceForm["\!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", {-671, -455, -290, -119, -15, 1, 10, 15, 41, 51, 70, 93, 105, 205, 217, 391, 546, 609, 679}]*)


(* ::Subsection::Closed:: *)
(*H = 100, H' = 10000: 52/12166*)


(* ::Print:: *)
(*SequenceForm["# \!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", 52, "; # SF \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", 12166, ";"]*)


(* ::Print:: *)
(*SequenceForm["\!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", {-8030, -8022, -7990, -7462, -6970, -6110, -5106, -3966, -3927, -3066, -2405, -1326, -1271, -671, -455, -290, -119, -15, 1, 10, 15, 41, 51, 70, 93, 105, 205, 217, 391, 546, 609, 679, 1105, 1326, 1378, 1785, 1830, 2370, 3145, 3289, 3585, 3705, 4505, 4522, 4745, 4945, 5565, 5865, 5890, 6355, 8169, 9334}]*)


(* ::Subsection::Closed:: *)
(*H = 100, H' = 100000: 130/121588*)


(* ::Print:: *)
(*SequenceForm["# \!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", 130, "; # SF \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", 121588, ";"]*)


(* ::Print:: *)
(*SequenceForm["\!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", CompressedData["*)
(*1:eJwVz0tIFFAUxvH/HdKwYqSkhxSOI1K5aEKiRS2Kigpx5UgPoaBxN0EZEQO1*)
(*SjcxvYMQJsuwRZGE1aZAiEjoYWWQrgySKVokJCRU0Ot+fS1+cLicc+530p1d*)
(*2cMB6LFdJ6JqB6Lq7kRtuxu15X5U9kXU+Ouo4lhUvhxV+B6VrpderZdaNkul*)
(*dqnqpDTTJ626JjU/ltIjUtsbadhKb6UbZWnQXtq7j9KzT1LDZyn5Rer5Kt22*)
(*ym9S3w9p/Jf3/ZZyf6UNUZqyoqRZ+59znlVbk62zHbbf8jZmk3bKjQ0JyNkt*)
(*a5sDmQrotJ+VsHIubK2ClgXut5CE41ZaCINWXOSZGni0GKaXQGIpTCxznYJC*)
(*I9SthhH7YEczEO2Mw0xbYZP/2u6crXDJiu1+2wNPDrjOQfdBGD0EtV3Qccy5*)
(*z7o+B7323E6fh6kLznPRM5ed/yqs7Xfu6/B+CDbe8x0PPDMMraMw5KN7J2C2*)
(*7P4ZaP4DaQLZRKB/fiBdHXi6PFCxInAlFUjVB5KNgYc7A5O7Azf3BjL7Ah35*)
(*wMCRwJruwD8wIsVk*)
(*"]]*)


(* ::Subsection::Closed:: *)
(*H = 1000, H' = 100: 8/122*)


(* ::Print:: *)
(*SequenceForm["# \!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", 8, "; # SF \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", 122, ";"]*)


(* ::Print:: *)
(*SequenceForm["\!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", {-15, 1, 10, 15, 41, 51, 70, 93}]*)


(* ::Subsection::Closed:: *)
(*H = 1000, H' = 1000: 19/1216*)


(* ::Print:: *)
(*SequenceForm["# \!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", 19, "; # SF \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", 1216, ";"]*)


(* ::Print:: *)
(*SequenceForm["\!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", {-671, -455, -290, -119, -15, 1, 10, 15, 41, 51, 70, 93, 105, 205, 217, 391, 546, 609, 679}]*)


(* ::Subsection::Closed:: *)
(*H = 1000, H' = 10000: 54/12166*)


(* ::Print:: *)
(*SequenceForm["# \!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", 54, "; # SF \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", 12166, ";"]*)


(* ::Print:: *)
(*SequenceForm["\!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", {-8030, -8022, -7990, -7462, -6970, -6110, -5106, -3966, -3927, -3255, -3066, -2405, -2030, -1326, -1271, -671, -455, -290, -119, -15, 1, 10, 15, 41, 51, 70, 93, 105, 205, 217, 391, 546, 609, 679, 1105, 1326, 1378, 1785, 1830, 2370, 3145, 3289, 3585, 3705, 4505, 4522, 4745, 4945, 5565, 5865, 5890, 6355, 8169, 9334}]*)


(* ::Subsection::Closed:: *)
(*H = 1000, H' = 100000: 139/121588*)


(* ::Print:: *)
(*SequenceForm["# \!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", 139, "; # SF \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", 121588, ";"]*)


(* ::Print:: *)
(*SequenceForm["\!\(\*SubscriptBox[\(D\), \(H\)]\) \[Intersection] \!\(\*SubscriptBox[\(R\), \(H'\)]\) = ", CompressedData["*)
(*1:eJwVz0lIFVAYxfH/faVhhZLRIIX6RBoWvZBoUYuiosJcqTQIBerOoIyIB7bK*)
(*WsTLRgjBLMOIIgkroiIhJKHBSiFdGSQWBQkJSQPZcE+nxQ8+Lt+599xkfWPV*)
(*/gC02PbDUQWdUYU3ozbditpwJ2rwbtSxe1FVz6OGXkVlBqIaxqLS36OSxdLL*)
(*1VL5eqmtWso5Ik20S0svSduuSmW9UrJPqhyUeqzttXRlTOqyF/bmvfT0g1Ty*)
(*Scr9LB39It2w8q9S9jep/YeU/1Ma+uW7f0t1f6U1URq1jKRJ+999puXZcltl*)
(*W2yPNdiAjdhxL5YkoM6uW+V0SGVBvU1lw5IZsDEHymd730IuNFnbHOiyTL4z*)
(*c+HRPBifD4kFMLzQcxGkS6FwGfTZOzuYgmgtLjNu6XV+a7N7VsA5y1T7bCc8*)
(*rvVcB817oX8fFDRCzSH3Pun5FLTaMztxGkbPuM9ZZ867/0VY2eHel+FtN6y9*)
(*7X/cd6YHHvZCRT90++OtwzA55r2Pzk1A2R9IEqhKBDpmBZJ5gWn5gSeLAlmL*)
(*AxeKAkXFgdzSwIOtgZEdgWu7AqndgZqGQOeBwFRTYEVz4B9C/tot*)
(*"]]*)
