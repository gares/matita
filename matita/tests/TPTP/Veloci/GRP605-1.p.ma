
include "logic/equality.ma".
(* Inclusion of: GRP605-1.p *)
(* -------------------------------------------------------------------------- *)
(*  File     : GRP605-1 : TPTP v3.1.1. Released v2.6.0. *)
(*  Domain   : Group Theory (Abelian) *)
(*  Problem  : Axiom for Abelian group theory, in double div and inv, part 1 *)
(*  Version  : [McC93] (equality) axioms. *)
(*  English  :  *)
(*  Refs     : [McC93] McCune (1993), Single Axioms for Groups and Abelian Gr *)
(*  Source   : [TPTP] *)
(*  Names    :  *)
(*  Status   : Unsatisfiable *)
(*  Rating   : 0.00 v2.6.0 *)
(*  Syntax   : Number of clauses     :    3 (   0 non-Horn;   3 unit;   1 RR) *)
(*             Number of atoms       :    3 (   3 equality) *)
(*             Maximal clause size   :    1 (   1 average) *)
(*             Number of predicates  :    1 (   0 propositional; 2-2 arity) *)
(*             Number of functors    :    5 (   2 constant; 0-2 arity) *)
(*             Number of variables   :    5 (   0 singleton) *)
(*             Maximal term depth    :    7 (   3 average) *)
(*  Comments : A UEQ part of GRP109-1 *)
(* -------------------------------------------------------------------------- *)
theorem prove_these_axioms_1:
 \forall Univ:Set.
\forall a1:Univ.
\forall b1:Univ.
\forall double_divide:\forall _:Univ.\forall _:Univ.Univ.
\forall inverse:\forall _:Univ.Univ.
\forall multiply:\forall _:Univ.\forall _:Univ.Univ.
\forall H0:\forall A:Univ.\forall B:Univ.eq Univ (multiply A B) (inverse (double_divide B A)).
\forall H1:\forall A:Univ.\forall B:Univ.\forall C:Univ.eq Univ (double_divide (inverse (double_divide A (inverse (double_divide (inverse B) (double_divide A C))))) C) B.eq Univ (multiply (inverse a1) a1) (multiply (inverse b1) b1)
.
intros.
autobatch paramodulation timeout=100;
try assumption.
print proofterm.
qed.
(* -------------------------------------------------------------------------- *)
