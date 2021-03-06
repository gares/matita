include "logic/equality.ma".

(* Inclusion of: COL058-2.p *)

(* -------------------------------------------------------------------------- *)

(*  File     : COL058-2 : TPTP v3.7.0. Released v1.0.0. *)

(*  Domain   : Combinatory Logic *)

(*  Problem  : If there's a lark, then there's an egocentric bird. *)

(*  Version  : Especial. *)

(*             Theorem formulation : The egocentric bird is provided and  *)

(*             checked. *)

(*  English  : Suppose we are given a forest that contains a lark, and  *)

(*             we are not given any other information. Prove that at least  *)

(*             one bird in the forest must be egocentric. *)

(*  Refs     : [Smu85] Smullyan (1978), To Mock a Mocking Bird and Other Logi *)

(*           : [GO86]  Glickfield & Overbeek (1986), A Foray into Combinatory *)

(*  Source   : [GO86] *)

(*  Names    : - [GO86] *)

(*  Status   : Unsatisfiable *)

(*  Rating   : 0.00 v2.2.1, 0.11 v2.2.0, 0.14 v2.1.0, 0.00 v2.0.0 *)

(*  Syntax   : Number of clauses     :    2 (   0 non-Horn;   2 unit;   1 RR) *)

(*             Number of atoms       :    2 (   2 equality) *)

(*             Maximal clause size   :    1 (   1 average) *)

(*             Number of predicates  :    1 (   0 propositional; 2-2 arity) *)

(*             Number of functors    :    2 (   1 constant; 0-2 arity) *)

(*             Number of variables   :    2 (   0 singleton) *)

(*             Maximal term depth    :    7 (   5 average) *)

(*  Comments :  *)

(* -------------------------------------------------------------------------- *)

(* ---- There exists a lark  *)

(* ---- Hypothesis: This bird is egocentric  *)
ntheorem prove_the_bird_exists:
 (∀Univ:Type.∀X1:Univ.∀X2:Univ.
∀lark:Univ.
∀response:∀_:Univ.∀_:Univ.Univ.
∀H0:∀X1:Univ.∀X2:Univ.eq Univ (response (response lark X1) X2) (response X1 (response X2 X2)).eq Univ (response (response (response lark (response (response lark (response lark lark)) (response lark (response lark lark)))) (response lark (response lark lark))) (response (response lark (response (response lark (response lark lark)) (response lark (response lark lark)))) (response lark (response lark lark)))) (response (response lark (response (response lark (response lark lark)) (response lark (response lark lark)))) (response lark (response lark lark))))
.
#Univ ##.
#X1 ##.
#X2 ##.
#lark ##.
#response ##.
#H0 ##.
nauto by H0 ##;
ntry (nassumption) ##;
nqed.

(* -------------------------------------------------------------------------- *)
