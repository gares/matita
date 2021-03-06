
include "logic/equality.ma".
(* Inclusion of: GRP510-1.p *)
(* -------------------------------------------------------------------------- *)
(*  File     : GRP510-1 : TPTP v3.1.1. Released v2.6.0. *)
(*  Domain   : Group Theory (Abelian) *)
(*  Problem  : Axiom for Abelian group theory, in product and inverse, part 2 *)
(*  Version  : [McC93] (equality) axioms. *)
(*  English  :  *)
(*  Refs     : [LW92]  Lusk & Wos (1992), Benchmark Problems in Which Equalit *)
(*           : [McC93] McCune (1993), Single Axioms for Groups and Abelian Gr *)
(*  Source   : [TPTP] *)
(*  Names    :  *)
(*  Status   : Unsatisfiable *)
(*  Rating   : 0.00 v2.6.0 *)
(*  Syntax   : Number of clauses     :    2 (   0 non-Horn;   2 unit;   1 RR) *)
(*             Number of atoms       :    2 (   2 equality) *)
(*             Maximal clause size   :    1 (   1 average) *)
(*             Number of predicates  :    1 (   0 propositional; 2-2 arity) *)
(*             Number of functors    :    4 (   2 constant; 0-2 arity) *)
(*             Number of variables   :    3 (   0 singleton) *)
(*             Maximal term depth    :    4 (   2 average) *)
(*  Comments : A UEQ part of GRP085-1 *)
(* -------------------------------------------------------------------------- *)
theorem prove_these_axioms_2:
 \forall Univ:Set.
\forall a2:Univ.
\forall b2:Univ.
\forall inverse:\forall _:Univ.Univ.
\forall multiply:\forall _:Univ.\forall _:Univ.Univ.
\forall H0:\forall A:Univ.\forall B:Univ.\forall C:Univ.eq Univ (multiply (multiply (multiply A B) C) (inverse (multiply A C))) B.eq Univ (multiply (multiply (inverse b2) b2) a2) a2
.
intros.
autobatch paramodulation timeout=100;
try assumption.
print proofterm.
qed.
(* -------------------------------------------------------------------------- *)
