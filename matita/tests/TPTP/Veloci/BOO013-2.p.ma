
include "logic/equality.ma".
(* Inclusion of: BOO013-2.p *)
(* -------------------------------------------------------------------------- *)
(*  File     : BOO013-2 : TPTP v3.1.1. Bugfixed v1.2.1. *)
(*  Domain   : Boolean Algebra *)
(*  Problem  : The inverse of X is unique *)
(*  Version  : [ANL] (equality) axioms. *)
(*  English  :  *)
(*  Refs     :  *)
(*  Source   : [ANL] *)
(*  Names    : prob9.ver2.in [ANL] *)
(*  Status   : Unsatisfiable *)
(*  Rating   : 0.00 v2.2.1, 0.11 v2.2.0, 0.14 v2.1.0, 0.14 v2.0.0 *)
(*  Syntax   : Number of clauses     :   19 (   0 non-Horn;  19 unit;   5 RR) *)
(*             Number of atoms       :   19 (  19 equality) *)
(*             Maximal clause size   :    1 (   1 average) *)
(*             Number of predicates  :    1 (   0 propositional; 2-2 arity) *)
(*             Number of functors    :    8 (   5 constant; 0-2 arity) *)
(*             Number of variables   :   24 (   0 singleton) *)
(*             Maximal term depth    :    3 (   2 average) *)
(*  Comments :  *)
(*  Bugfixes : v1.2.1 - Clauses b_and_multiplicative_identity and *)
(*             c_and_multiplicative_identity fixed. *)
(* -------------------------------------------------------------------------- *)
(* ----Include boolean algebra axioms for equality formulation  *)
(* Inclusion of: Axioms/BOO003-0.ax *)
(* -------------------------------------------------------------------------- *)
(*  File     : BOO003-0 : TPTP v3.1.1. Released v1.0.0. *)
(*  Domain   : Boolean Algebra *)
(*  Axioms   : Boolean algebra (equality) axioms *)
(*  Version  : [ANL] (equality) axioms. *)
(*  English  :  *)
(*  Refs     :  *)
(*  Source   : [ANL] *)
(*  Names    :  *)
(*  Status   :  *)
(*  Syntax   : Number of clauses    :   14 (   0 non-Horn;  14 unit;   0 RR) *)
(*             Number of literals   :   14 (  14 equality) *)
(*             Maximal clause size  :    1 (   1 average) *)
(*             Number of predicates :    1 (   0 propositional; 2-2 arity) *)
(*             Number of functors   :    5 (   2 constant; 0-2 arity) *)
(*             Number of variables  :   24 (   0 singleton) *)
(*             Maximal term depth   :    3 (   2 average) *)
(*  Comments :  *)
(* -------------------------------------------------------------------------- *)
(* -------------------------------------------------------------------------- *)
(* -------------------------------------------------------------------------- *)
theorem prove_b_is_a:
 \forall Univ:Set.
\forall a:Univ.
\forall add:\forall _:Univ.\forall _:Univ.Univ.
\forall additive_identity:Univ.
\forall b:Univ.
\forall c:Univ.
\forall inverse:\forall _:Univ.Univ.
\forall multiplicative_identity:Univ.
\forall multiply:\forall _:Univ.\forall _:Univ.Univ.
\forall H0:eq Univ (multiply a c) additive_identity.
\forall H1:eq Univ (multiply a b) additive_identity.
\forall H2:eq Univ (add a c) multiplicative_identity.
\forall H3:eq Univ (add a b) multiplicative_identity.
\forall H4:\forall X:Univ.eq Univ (add additive_identity X) X.
\forall H5:\forall X:Univ.eq Univ (add X additive_identity) X.
\forall H6:\forall X:Univ.eq Univ (multiply multiplicative_identity X) X.
\forall H7:\forall X:Univ.eq Univ (multiply X multiplicative_identity) X.
\forall H8:\forall X:Univ.eq Univ (multiply (inverse X) X) additive_identity.
\forall H9:\forall X:Univ.eq Univ (multiply X (inverse X)) additive_identity.
\forall H10:\forall X:Univ.eq Univ (add (inverse X) X) multiplicative_identity.
\forall H11:\forall X:Univ.eq Univ (add X (inverse X)) multiplicative_identity.
\forall H12:\forall X:Univ.\forall Y:Univ.\forall Z:Univ.eq Univ (multiply X (add Y Z)) (add (multiply X Y) (multiply X Z)).
\forall H13:\forall X:Univ.\forall Y:Univ.\forall Z:Univ.eq Univ (multiply (add X Y) Z) (add (multiply X Z) (multiply Y Z)).
\forall H14:\forall X:Univ.\forall Y:Univ.\forall Z:Univ.eq Univ (add X (multiply Y Z)) (multiply (add X Y) (add X Z)).
\forall H15:\forall X:Univ.\forall Y:Univ.\forall Z:Univ.eq Univ (add (multiply X Y) Z) (multiply (add X Z) (add Y Z)).
\forall H16:\forall X:Univ.\forall Y:Univ.eq Univ (multiply X Y) (multiply Y X).
\forall H17:\forall X:Univ.\forall Y:Univ.eq Univ (add X Y) (add Y X).eq Univ b c
.
intros.
autobatch paramodulation timeout=100;
try assumption.
print proofterm.
qed.
(* -------------------------------------------------------------------------- *)
