
include "logic/equality.ma".
(* Inclusion of: BOO009-4.p *)
(* -------------------------------------------------------------------------- *)
(*  File     : BOO009-4 : TPTP v3.1.1. Released v1.1.0. *)
(*  Domain   : Boolean Algebra *)
(*  Problem  : Multiplication absorption (X * (X + Y) = X) *)
(*  Version  : [Ver94] (equality) axioms. *)
(*  English  :  *)
(*  Refs     : [Ver94] Veroff (1994), Problem Set *)
(*  Source   : [Ver94] *)
(*  Names    : TC [Ver94] *)
(*  Status   : Unsatisfiable *)
(*  Rating   : 0.00 v2.2.1, 0.22 v2.2.0, 0.29 v2.1.0, 0.38 v2.0.0 *)
(*  Syntax   : Number of clauses     :    9 (   0 non-Horn;   9 unit;   1 RR) *)
(*             Number of atoms       :    9 (   9 equality) *)
(*             Maximal clause size   :    1 (   1 average) *)
(*             Number of predicates  :    1 (   0 propositional; 2-2 arity) *)
(*             Number of functors    :    7 (   4 constant; 0-2 arity) *)
(*             Number of variables   :   14 (   0 singleton) *)
(*             Maximal term depth    :    3 (   2 average) *)
(*  Comments :  *)
(* -------------------------------------------------------------------------- *)
(* ----Include boolean algebra axioms for equality formulation  *)
(* Inclusion of: Axioms/BOO004-0.ax *)
(* -------------------------------------------------------------------------- *)
(*  File     : BOO004-0 : TPTP v3.1.1. Released v1.0.0. *)
(*  Domain   : Boolean Algebra *)
(*  Axioms   : Boolean algebra (equality) axioms *)
(*  Version  : [Ver94] (equality) axioms. *)
(*  English  :  *)
(*  Refs     : [Ver94] Veroff (1994), Problem Set *)
(*  Source   : [Ver94] *)
(*  Names    :  *)
(*  Status   :  *)
(*  Syntax   : Number of clauses    :    8 (   0 non-Horn;   8 unit;   0 RR) *)
(*             Number of literals   :    8 (   8 equality) *)
(*             Maximal clause size  :    1 (   1 average) *)
(*             Number of predicates :    1 (   0 propositional; 2-2 arity) *)
(*             Number of functors   :    5 (   2 constant; 0-2 arity) *)
(*             Number of variables  :   14 (   0 singleton) *)
(*             Maximal term depth   :    3 (   2 average) *)
(*  Comments :  *)
(* -------------------------------------------------------------------------- *)
(* -------------------------------------------------------------------------- *)
(* -------------------------------------------------------------------------- *)
theorem prove_operation:
 \forall Univ:Set.
\forall a:Univ.
\forall add:\forall _:Univ.\forall _:Univ.Univ.
\forall additive_identity:Univ.
\forall b:Univ.
\forall inverse:\forall _:Univ.Univ.
\forall multiplicative_identity:Univ.
\forall multiply:\forall _:Univ.\forall _:Univ.Univ.
\forall H0:\forall X:Univ.eq Univ (multiply X (inverse X)) additive_identity.
\forall H1:\forall X:Univ.eq Univ (add X (inverse X)) multiplicative_identity.
\forall H2:\forall X:Univ.eq Univ (multiply X multiplicative_identity) X.
\forall H3:\forall X:Univ.eq Univ (add X additive_identity) X.
\forall H4:\forall X:Univ.\forall Y:Univ.\forall Z:Univ.eq Univ (multiply X (add Y Z)) (add (multiply X Y) (multiply X Z)).
\forall H5:\forall X:Univ.\forall Y:Univ.\forall Z:Univ.eq Univ (add X (multiply Y Z)) (multiply (add X Y) (add X Z)).
\forall H6:\forall X:Univ.\forall Y:Univ.eq Univ (multiply X Y) (multiply Y X).
\forall H7:\forall X:Univ.\forall Y:Univ.eq Univ (add X Y) (add Y X).eq Univ (multiply a (add a b)) a
.
intros.
autobatch paramodulation timeout=100;
try assumption.
print proofterm.
qed.
(* -------------------------------------------------------------------------- *)
