
include "logic/equality.ma".
(* Inclusion of: GRP541-1.p *)
(* -------------------------------------------------------------------------- *)
(*  File     : GRP541-1 : TPTP v3.1.1. Released v2.6.0. *)
(*  Domain   : Group Theory (Abelian) *)
(*  Problem  : Axiom for Abelian group theory, in division and identity, part 1 *)
(*  Version  : [McC93] (equality) axioms. *)
(*  English  :  *)
(*  Refs     : [McC93] McCune (1993), Single Axioms for Groups and Abelian Gr *)
(*  Source   : [TPTP] *)
(*  Names    :  *)
(*  Status   : Unsatisfiable *)
(*  Rating   : 0.00 v2.6.0 *)
(*  Syntax   : Number of clauses     :    5 (   0 non-Horn;   5 unit;   1 RR) *)
(*             Number of atoms       :    5 (   5 equality) *)
(*             Maximal clause size   :    1 (   1 average) *)
(*             Number of predicates  :    1 (   0 propositional; 2-2 arity) *)
(*             Number of functors    :    6 (   3 constant; 0-2 arity) *)
(*             Number of variables   :    7 (   0 singleton) *)
(*             Maximal term depth    :    6 (   2 average) *)
(*  Comments : A UEQ part of GRP093-1 *)
(* -------------------------------------------------------------------------- *)
theorem prove_these_axioms_1:
 \forall Univ:Set.
\forall a1:Univ.
\forall b1:Univ.
\forall divide:\forall _:Univ.\forall _:Univ.Univ.
\forall identity:Univ.
\forall inverse:\forall _:Univ.Univ.
\forall multiply:\forall _:Univ.\forall _:Univ.Univ.
\forall H0:\forall A:Univ.eq Univ identity (divide A A).
\forall H1:\forall A:Univ.eq Univ (inverse A) (divide identity A).
\forall H2:\forall A:Univ.\forall B:Univ.eq Univ (multiply A B) (divide A (divide identity B)).
\forall H3:\forall A:Univ.\forall B:Univ.\forall C:Univ.eq Univ (divide (divide identity (divide (divide (divide A B) C) A)) C) B.eq Univ (multiply (inverse a1) a1) (multiply (inverse b1) b1)
.
intros.
autobatch paramodulation timeout=100;
try assumption.
print proofterm.
qed.
(* -------------------------------------------------------------------------- *)
