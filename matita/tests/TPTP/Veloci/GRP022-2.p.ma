
include "logic/equality.ma".
(* Inclusion of: GRP022-2.p *)
(* -------------------------------------------------------------------------- *)
(*  File     : GRP022-2 : TPTP v3.1.1. Released v1.0.0. *)
(*  Domain   : Group Theory *)
(*  Problem  : Inverse is an involution *)
(*  Version  : [MOW76] (equality) axioms : Augmented. *)
(*  English  :  *)
(*  Refs     : [MOW76] McCharen et al. (1976), Problems and Experiments for a *)
(*           : [LO85]  Lusk & Overbeek (1985), Reasoning about Equality *)
(*  Source   : [TPTP] *)
(*  Names    : Established lemma [MOW76] *)
(*           : Problem 2 [LO85] *)
(*  Status   : Unsatisfiable *)
(*  Rating   : 0.00 v2.0.0 *)
(*  Syntax   : Number of clauses     :    6 (   0 non-Horn;   6 unit;   1 RR) *)
(*             Number of atoms       :    6 (   6 equality) *)
(*             Maximal clause size   :    1 (   1 average) *)
(*             Number of predicates  :    1 (   0 propositional; 2-2 arity) *)
(*             Number of functors    :    4 (   2 constant; 0-2 arity) *)
(*             Number of variables   :    7 (   0 singleton) *)
(*             Maximal term depth    :    3 (   2 average) *)
(*  Comments :  *)
(* -------------------------------------------------------------------------- *)
(* ----Include equality group theory axioms  *)
(* Inclusion of: Axioms/GRP004-0.ax *)
(* -------------------------------------------------------------------------- *)
(*  File     : GRP004-0 : TPTP v3.1.1. Released v1.0.0. *)
(*  Domain   : Group Theory *)
(*  Axioms   : Group theory (equality) axioms *)
(*  Version  : [MOW76] (equality) axioms :  *)
(*             Reduced > Complete. *)
(*  English  :  *)
(*  Refs     : [MOW76] McCharen et al. (1976), Problems and Experiments for a *)
(*           : [Wos88] Wos (1988), Automated Reasoning - 33 Basic Research Pr *)
(*  Source   : [ANL] *)
(*  Names    :  *)
(*  Status   :  *)
(*  Syntax   : Number of clauses    :    3 (   0 non-Horn;   3 unit;   0 RR) *)
(*             Number of literals   :    3 (   3 equality) *)
(*             Maximal clause size  :    1 (   1 average) *)
(*             Number of predicates :    1 (   0 propositional; 2-2 arity) *)
(*             Number of functors   :    3 (   1 constant; 0-2 arity) *)
(*             Number of variables  :    5 (   0 singleton) *)
(*             Maximal term depth   :    3 (   2 average) *)
(*  Comments : [MOW76] also contains redundant right_identity and *)
(*             right_inverse axioms. *)
(*           : These axioms are also used in [Wos88] p.186, also with *)
(*             right_identity and right_inverse. *)
(* -------------------------------------------------------------------------- *)
(* ----For any x and y in the group x*y is also in the group. No clause  *)
(* ----is needed here since this is an instance of reflexivity  *)
(* ----There exists an identity element  *)
(* ----For any x in the group, there exists an element y such that x*y = y*x  *)
(* ----= identity. *)
(* ----The operation '*' is associative  *)
(* -------------------------------------------------------------------------- *)
(* -------------------------------------------------------------------------- *)
(* ----Redundant two axioms *)
theorem prove_inverse_of_inverse_is_original:
 \forall Univ:Set.
\forall a:Univ.
\forall identity:Univ.
\forall inverse:\forall _:Univ.Univ.
\forall multiply:\forall _:Univ.\forall _:Univ.Univ.
\forall H0:\forall X:Univ.eq Univ (multiply X (inverse X)) identity.
\forall H1:\forall X:Univ.eq Univ (multiply X identity) X.
\forall H2:\forall X:Univ.\forall Y:Univ.\forall Z:Univ.eq Univ (multiply (multiply X Y) Z) (multiply X (multiply Y Z)).
\forall H3:\forall X:Univ.eq Univ (multiply (inverse X) X) identity.
\forall H4:\forall X:Univ.eq Univ (multiply identity X) X.eq Univ (inverse (inverse a)) a
.
intros.
autobatch paramodulation timeout=100;
try assumption.
print proofterm.
qed.
(* -------------------------------------------------------------------------- *)
