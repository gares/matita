
include "logic/equality.ma".
(* Inclusion of: COL010-1.p *)
(* -------------------------------------------------------------------------- *)
(*  File     : COL010-1 : TPTP v3.1.1. Released v1.0.0. *)
(*  Domain   : Combinatory Logic *)
(*  Problem  : Weak fixed point for B and S2 *)
(*  Version  : [WM88] (equality) axioms. *)
(*  English  : The weak fixed point property holds for the set P consisting  *)
(*             of the combinators B and S2, where ((Bx)y)z = x(yz),  *)
(*             ((S2x)y)z = (xz)(yy). *)
(*  Refs     : [Smu85] Smullyan (1978), To Mock a Mocking Bird and Other Logi *)
(*           : [MW87]  McCune & Wos (1987), A Case Study in Automated Theorem *)
(*           : [WM88]  Wos & McCune (1988), Challenge Problems Focusing on Eq *)
(*           : [MW88]  McCune & Wos (1988), Some Fixed Point Problems in Comb *)
(*  Source   : [MW88] *)
(*  Names    : - [MW88] *)
(*  Status   : Unsatisfiable *)
(*  Rating   : 0.07 v3.1.0, 0.11 v2.7.0, 0.00 v2.0.0 *)
(*  Syntax   : Number of clauses     :    3 (   0 non-Horn;   3 unit;   1 RR) *)
(*             Number of atoms       :    3 (   3 equality) *)
(*             Maximal clause size   :    1 (   1 average) *)
(*             Number of predicates  :    1 (   0 propositional; 2-2 arity) *)
(*             Number of functors    :    4 (   3 constant; 0-2 arity) *)
(*             Number of variables   :    7 (   0 singleton) *)
(*             Maximal term depth    :    4 (   3 average) *)
(*  Comments :  *)
(* -------------------------------------------------------------------------- *)
theorem prove_fixed_point:
 \forall Univ:Set.
\forall apply:\forall _:Univ.\forall _:Univ.Univ.
\forall b:Univ.
\forall combinator:Univ.
\forall s2:Univ.
\forall H0:\forall X:Univ.\forall Y:Univ.\forall Z:Univ.eq Univ (apply (apply (apply s2 X) Y) Z) (apply (apply X Z) (apply Y Y)).
\forall H1:\forall X:Univ.\forall Y:Univ.\forall Z:Univ.eq Univ (apply (apply (apply b X) Y) Z) (apply X (apply Y Z)).\exist Y:Univ.eq Univ Y (apply combinator Y)
.
intros.
exists[
2:
autobatch paramodulation timeout=100;
try assumption.
|
skip]
print proofterm.
qed.
(* -------------------------------------------------------------------------- *)
