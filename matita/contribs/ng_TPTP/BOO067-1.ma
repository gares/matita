include "logic/equality.ma".

(* Inclusion of: BOO067-1.p *)

(* -------------------------------------------------------------------------- *)

(*  File     : BOO067-1 : TPTP v3.7.0. Released v2.6.0. *)

(*  Domain   : Boolean Algebra (Ternary) *)

(*  Problem  : Ternary Boolean Algebra Single axiom is complete, part 1 *)

(*  Version  : [MP96] (equality) axioms. *)

(*  English  :  *)

(*  Refs     : [McC98] McCune (1998), Email to G. Sutcliffe *)

(*           : [MP96]  McCune & Padmanabhan (1996), Automated Deduction in Eq *)

(*  Source   : [TPTP] *)

(*  Names    :  *)

(*  Status   : Unsatisfiable *)

(*  Rating   : 0.11 v3.4.0, 0.12 v3.3.0, 0.21 v3.1.0, 0.33 v2.7.0, 0.27 v2.6.0 *)

(*  Syntax   : Number of clauses     :    2 (   0 non-Horn;   2 unit;   1 RR) *)

(*             Number of atoms       :    2 (   2 equality) *)

(*             Maximal clause size   :    1 (   1 average) *)

(*             Number of predicates  :    1 (   0 propositional; 2-2 arity) *)

(*             Number of functors    :    7 (   5 constant; 0-3 arity) *)

(*             Number of variables   :    7 (   0 singleton) *)

(*             Maximal term depth    :    5 (   3 average) *)

(*  Comments : A UEQ part of BOO035-1  *)

(* -------------------------------------------------------------------------- *)
ntheorem prove_tba_axioms_1:
 (∀Univ:Type.∀A:Univ.∀B:Univ.∀C:Univ.∀D:Univ.∀E:Univ.∀F:Univ.∀G:Univ.
∀a:Univ.
∀b:Univ.
∀c:Univ.
∀d:Univ.
∀e:Univ.
∀inverse:∀_:Univ.Univ.
∀multiply:∀_:Univ.∀_:Univ.∀_:Univ.Univ.
∀H0:∀A:Univ.∀B:Univ.∀C:Univ.∀D:Univ.∀E:Univ.∀F:Univ.∀G:Univ.eq Univ (multiply (multiply A (inverse A) B) (inverse (multiply (multiply C D E) F (multiply C D G))) (multiply D (multiply G F E) C)) B.eq Univ (multiply (multiply d e a) b (multiply d e c)) (multiply d e (multiply a b c)))
.
#Univ ##.
#A ##.
#B ##.
#C ##.
#D ##.
#E ##.
#F ##.
#G ##.
#a ##.
#b ##.
#c ##.
#d ##.
#e ##.
#inverse ##.
#multiply ##.
#H0 ##.
nauto by H0 ##;
ntry (nassumption) ##;
nqed.

(* -------------------------------------------------------------------------- *)
