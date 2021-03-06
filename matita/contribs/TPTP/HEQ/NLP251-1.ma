set "baseuri" "cic:/matita/TPTP/NLP251-1".
include "logic/equality.ma".

(* Inclusion of: NLP251-1.p *)

(* -------------------------------------------------------------------------- *)

(*  File     : NLP251-1 : TPTP v3.2.0. Released v2.4.0. *)

(*  Domain   : Natural Language Processing *)

(*  Problem  : Vincent believes that every man smokes, problem 32 *)

(*  Version  : [Bos00b] axioms. *)

(*  English  : Eliminating non-informative interpretations in the statement *)

(*             "Vincent believes that every man smokes. Jules is a man.  *)

(*             Vincent believes that jules smokes." *)

(*  Refs     : [Bos00a] Bos (2000), DORIS: Discourse Oriented Representation a *)

(*             [Bos00b] Bos (2000), Applied Theorem Proving - Natural Language *)

(*  Source   : [TPTP] *)

(*  Names    :  *)

(*  Status   : Unsatisfiable *)

(*  Rating   : 0.00 v3.1.0, 0.11 v2.7.0, 0.00 v2.5.0, 0.40 v2.4.0 *)

(*  Syntax   : Number of clauses     :   95 (   0 non-Horn;  18 unit;  92 RR) *)

(*             Number of atoms       :  292 (   3 equality) *)

(*             Maximal clause size   :   41 (   3 average) *)

(*             Number of predicates  :   37 (   0 propositional; 1-4 arity) *)

(*             Number of functors    :   10 (   8 constant; 0-1 arity) *)

(*             Number of variables   :  227 (   8 singleton) *)

(*             Maximal term depth    :    2 (   1 average) *)

(*  Comments : Created from NLP251+1.p using FLOTTER *)

(* -------------------------------------------------------------------------- *)
theorem clause95:
 ∀Univ:Set.∀U:Univ.∀V:Univ.∀W:Univ.∀X:Univ.∀X1:Univ.∀X10:Univ.∀X2:Univ.∀X3:Univ.∀X4:Univ.∀X5:Univ.∀X6:Univ.∀X7:Univ.∀X8:Univ.∀X9:Univ.∀Y:Univ.∀Z:Univ.∀abstraction:∀_:Univ.∀_:Univ.Prop.∀accessible_world:∀_:Univ.∀_:Univ.Prop.∀actual_world:∀_:Univ.Prop.∀agent:∀_:Univ.∀_:Univ.∀_:Univ.Prop.∀animate:∀_:Univ.∀_:Univ.Prop.∀be:∀_:Univ.∀_:Univ.∀_:Univ.∀_:Univ.Prop.∀entity:∀_:Univ.∀_:Univ.Prop.∀event:∀_:Univ.∀_:Univ.Prop.∀eventuality:∀_:Univ.∀_:Univ.Prop.∀existent:∀_:Univ.∀_:Univ.Prop.∀forename:∀_:Univ.∀_:Univ.Prop.∀general:∀_:Univ.∀_:Univ.Prop.∀human:∀_:Univ.∀_:Univ.Prop.∀human_person:∀_:Univ.∀_:Univ.Prop.∀impartial:∀_:Univ.∀_:Univ.Prop.∀jules_forename:∀_:Univ.∀_:Univ.Prop.∀living:∀_:Univ.∀_:Univ.Prop.∀male:∀_:Univ.∀_:Univ.Prop.∀man:∀_:Univ.∀_:Univ.Prop.∀nonexistent:∀_:Univ.∀_:Univ.Prop.∀nonhuman:∀_:Univ.∀_:Univ.Prop.∀of:∀_:Univ.∀_:Univ.∀_:Univ.Prop.∀organism:∀_:Univ.∀_:Univ.Prop.∀present:∀_:Univ.∀_:Univ.Prop.∀proposition:∀_:Univ.∀_:Univ.Prop.∀relation:∀_:Univ.∀_:Univ.Prop.∀relname:∀_:Univ.∀_:Univ.Prop.∀singleton:∀_:Univ.∀_:Univ.Prop.∀skc10:Univ.∀skc11:Univ.∀skc12:Univ.∀skc13:Univ.∀skc14:Univ.∀skc15:Univ.∀skc8:Univ.∀skc9:Univ.∀skf2:∀_:Univ.Univ.∀skf4:∀_:Univ.Univ.∀smoke:∀_:Univ.∀_:Univ.Prop.∀specific:∀_:Univ.∀_:Univ.Prop.∀state:∀_:Univ.∀_:Univ.Prop.∀theme:∀_:Univ.∀_:Univ.∀_:Univ.Prop.∀thing:∀_:Univ.∀_:Univ.Prop.∀think_believe_consider:∀_:Univ.∀_:Univ.Prop.∀unisex:∀_:Univ.∀_:Univ.Prop.∀vincent_forename:∀_:Univ.∀_:Univ.Prop.∀H0:∀U:Univ.∀V:Univ.∀W:Univ.∀X:Univ.∀X1:Univ.∀X2:Univ.∀X3:Univ.∀X4:Univ.∀X5:Univ.∀X6:Univ.∀X7:Univ.∀X8:Univ.∀X9:Univ.∀Y:Univ.∀Z:Univ.∀_:actual_world U.∀_:think_believe_consider U X8.∀_:present U X8.∀_:event U X8.∀_:theme U X8 X3.∀_:of U X7 X9.∀_:man U X9.∀_:agent U X8 X9.∀_:forename U X7.∀_:vincent_forename U X7.∀_:of U X4 X6.∀_:man U X6.∀_:event X3 X5.∀_:agent X3 X5 X6.∀_:present X3 X5.∀_:smoke X3 X5.∀_:forename U X4.∀_:jules_forename U X4.∀_:proposition U X3.∀_:accessible_world U X3.∀_:of U X2 X1.∀_:jules_forename U X2.∀_:forename U X2.∀_:be U Z X1 X1.∀_:man U X1.∀_:state U Z.∀_:of U X Y.∀_:man U Y.∀_:agent U W Y.∀_:forename U X.∀_:vincent_forename U X.∀_:theme U W V.∀_:event U W.∀_:present U W.∀_:think_believe_consider U W.∀_:accessible_world U V.∀_:proposition U V.man V (skf4 V).∀H1:∀U:Univ.∀_:man skc12 U.agent skc12 (skf2 U) U.∀H2:∀U:Univ.∀V:Univ.∀_:man skc12 U.event skc12 (skf2 V).∀H3:∀U:Univ.∀V:Univ.∀_:man skc12 U.present skc12 (skf2 V).∀H4:∀U:Univ.∀V:Univ.∀_:man skc12 U.smoke skc12 (skf2 V).∀H5:be skc8 skc9 skc10 skc10.∀H6:of skc8 skc11 skc10.∀H7:theme skc8 skc13 skc12.∀H8:agent skc8 skc13 skc15.∀H9:of skc8 skc14 skc15.∀H10:proposition skc8 skc12.∀H11:accessible_world skc8 skc12.∀H12:state skc8 skc9.∀H13:man skc8 skc10.∀H14:forename skc8 skc11.∀H15:jules_forename skc8 skc11.∀H16:think_believe_consider skc8 skc13.∀H17:present skc8 skc13.∀H18:event skc8 skc13.∀H19:vincent_forename skc8 skc14.∀H20:forename skc8 skc14.∀H21:man skc8 skc15.∀H22:actual_world skc8.∀H23:∀U:Univ.∀V:Univ.∀W:Univ.∀X:Univ.∀Y:Univ.∀Z:Univ.∀_:agent U X Z.∀_:agent U Y Z.∀_:theme U Y W.∀_:think_believe_consider U Y.∀_:think_believe_consider U X.∀_:theme U X V.∀_:proposition U W.∀_:proposition U V.eq Univ V W.∀H24:∀U:Univ.∀V:Univ.∀W:Univ.∀X:Univ.∀_:entity U X.∀_:of U V X.∀_:forename U W.∀_:of U W X.∀_:forename U V.eq Univ W V.∀H25:∀U:Univ.∀V:Univ.∀W:Univ.∀X:Univ.∀Y:Univ.∀_:be U W X Y.∀_:accessible_world U V.be V W X Y.∀H26:∀U:Univ.∀V:Univ.∀W:Univ.∀X:Univ.∀_:of U W X.∀_:accessible_world U V.of V W X.∀H27:∀U:Univ.∀V:Univ.∀W:Univ.∀X:Univ.∀_:theme U W X.∀_:accessible_world U V.theme V W X.∀H28:∀U:Univ.∀V:Univ.∀W:Univ.∀X:Univ.∀_:agent U W X.∀_:accessible_world U V.agent V W X.∀H29:∀U:Univ.∀V:Univ.∀W:Univ.∀_:jules_forename U W.∀_:accessible_world U V.jules_forename V W.∀H30:∀U:Univ.∀V:Univ.∀W:Univ.∀_:vincent_forename U W.∀_:accessible_world U V.vincent_forename V W.∀H31:∀U:Univ.∀V:Univ.∀W:Univ.∀_:relname U W.∀_:accessible_world U V.relname V W.∀H32:∀U:Univ.∀V:Univ.∀W:Univ.∀_:forename U W.∀_:accessible_world U V.forename V W.∀H33:∀U:Univ.∀V:Univ.∀W:Univ.∀_:male U W.∀_:accessible_world U V.male V W.∀H34:∀U:Univ.∀V:Univ.∀W:Univ.∀_:animate U W.∀_:accessible_world U V.animate V W.∀H35:∀U:Univ.∀V:Univ.∀W:Univ.∀_:human U W.∀_:accessible_world U V.human V W.∀H36:∀U:Univ.∀V:Univ.∀W:Univ.∀_:living U W.∀_:accessible_world U V.living V W.∀H37:∀U:Univ.∀V:Univ.∀W:Univ.∀_:impartial U W.∀_:accessible_world U V.impartial V W.∀H38:∀U:Univ.∀V:Univ.∀W:Univ.∀_:existent U W.∀_:accessible_world U V.existent V W.∀H39:∀U:Univ.∀V:Univ.∀W:Univ.∀_:entity U W.∀_:accessible_world U V.entity V W.∀H40:∀U:Univ.∀V:Univ.∀W:Univ.∀_:organism U W.∀_:accessible_world U V.organism V W.∀H41:∀U:Univ.∀V:Univ.∀W:Univ.∀_:human_person U W.∀_:accessible_world U V.human_person V W.∀H42:∀U:Univ.∀V:Univ.∀W:Univ.∀_:man U W.∀_:accessible_world U V.man V W.∀H43:∀U:Univ.∀V:Univ.∀W:Univ.∀_:state U W.∀_:accessible_world U V.state V W.∀H44:∀U:Univ.∀V:Univ.∀W:Univ.∀_:general U W.∀_:accessible_world U V.general V W.∀H45:∀U:Univ.∀V:Univ.∀W:Univ.∀_:nonhuman U W.∀_:accessible_world U V.nonhuman V W.∀H46:∀U:Univ.∀V:Univ.∀W:Univ.∀_:abstraction U W.∀_:accessible_world U V.abstraction V W.∀H47:∀U:Univ.∀V:Univ.∀W:Univ.∀_:relation U W.∀_:accessible_world U V.relation V W.∀H48:∀U:Univ.∀V:Univ.∀W:Univ.∀_:proposition U W.∀_:accessible_world U V.proposition V W.∀H49:∀U:Univ.∀V:Univ.∀W:Univ.∀_:think_believe_consider U W.∀_:accessible_world U V.think_believe_consider V W.∀H50:∀U:Univ.∀V:Univ.∀W:Univ.∀_:present U W.∀_:accessible_world U V.present V W.∀H51:∀U:Univ.∀V:Univ.∀W:Univ.∀_:unisex U W.∀_:accessible_world U V.unisex V W.∀H52:∀U:Univ.∀V:Univ.∀W:Univ.∀_:nonexistent U W.∀_:accessible_world U V.nonexistent V W.∀H53:∀U:Univ.∀V:Univ.∀W:Univ.∀_:specific U W.∀_:accessible_world U V.specific V W.∀H54:∀U:Univ.∀V:Univ.∀W:Univ.∀_:singleton U W.∀_:accessible_world U V.singleton V W.∀H55:∀U:Univ.∀V:Univ.∀W:Univ.∀_:thing U W.∀_:accessible_world U V.thing V W.∀H56:∀U:Univ.∀V:Univ.∀W:Univ.∀_:eventuality U W.∀_:accessible_world U V.eventuality V W.∀H57:∀U:Univ.∀V:Univ.∀W:Univ.∀_:event U W.∀_:accessible_world U V.event V W.∀H58:∀U:Univ.∀V:Univ.∀W:Univ.∀_:smoke U W.∀_:accessible_world U V.smoke V W.∀H59:∀U:Univ.∀V:Univ.∀W:Univ.∀X:Univ.∀_:be U V W X.eq Univ W X.∀H60:∀U:Univ.∀V:Univ.∀_:existent U V.nonexistent U V.∀H61:∀U:Univ.∀V:Univ.∀_:nonhuman U V.human U V.∀H62:∀U:Univ.∀V:Univ.∀_:specific U V.general U V.∀H63:∀U:Univ.∀V:Univ.∀_:unisex U V.male U V.∀H64:∀U:Univ.∀V:Univ.∀_:jules_forename U V.forename U V.∀H65:∀U:Univ.∀V:Univ.∀_:vincent_forename U V.forename U V.∀H66:∀U:Univ.∀V:Univ.∀_:relname U V.relation U V.∀H67:∀U:Univ.∀V:Univ.∀_:forename U V.relname U V.∀H68:∀U:Univ.∀V:Univ.∀_:man U V.male U V.∀H69:∀U:Univ.∀V:Univ.∀_:human_person U V.animate U V.∀H70:∀U:Univ.∀V:Univ.∀_:human_person U V.human U V.∀H71:∀U:Univ.∀V:Univ.∀_:organism U V.living U V.∀H72:∀U:Univ.∀V:Univ.∀_:organism U V.impartial U V.∀H73:∀U:Univ.∀V:Univ.∀_:entity U V.existent U V.∀H74:∀U:Univ.∀V:Univ.∀_:entity U V.specific U V.∀H75:∀U:Univ.∀V:Univ.∀_:entity U V.thing U V.∀H76:∀U:Univ.∀V:Univ.∀_:organism U V.entity U V.∀H77:∀U:Univ.∀V:Univ.∀_:human_person U V.organism U V.∀H78:∀U:Univ.∀V:Univ.∀_:man U V.human_person U V.∀H79:∀U:Univ.∀V:Univ.∀_:state U V.event U V.∀H80:∀U:Univ.∀V:Univ.∀_:state U V.eventuality U V.∀H81:∀U:Univ.∀V:Univ.∀_:abstraction U V.unisex U V.∀H82:∀U:Univ.∀V:Univ.∀_:abstraction U V.general U V.∀H83:∀U:Univ.∀V:Univ.∀_:abstraction U V.nonhuman U V.∀H84:∀U:Univ.∀V:Univ.∀_:abstraction U V.thing U V.∀H85:∀U:Univ.∀V:Univ.∀_:relation U V.abstraction U V.∀H86:∀U:Univ.∀V:Univ.∀_:proposition U V.relation U V.∀H87:∀U:Univ.∀V:Univ.∀_:eventuality U V.unisex U V.∀H88:∀U:Univ.∀V:Univ.∀_:eventuality U V.nonexistent U V.∀H89:∀U:Univ.∀V:Univ.∀_:eventuality U V.specific U V.∀H90:∀U:Univ.∀V:Univ.∀_:thing U V.singleton U V.∀H91:∀U:Univ.∀V:Univ.∀_:eventuality U V.thing U V.∀H92:∀U:Univ.∀V:Univ.∀_:event U V.eventuality U V.∀H93:∀U:Univ.∀V:Univ.∀_:smoke U V.event U V.∃U:Univ.∃V:Univ.∃W:Univ.∃X:Univ.∃X1:Univ.∃X10:Univ.∃X2:Univ.∃X3:Univ.∃X4:Univ.∃X5:Univ.∃X6:Univ.∃X7:Univ.∃X8:Univ.∃X9:Univ.∃Y:Univ.∃Z:Univ.And (actual_world U) (And (think_believe_consider U X9) (And (present U X9) (And (event U X9) (And (theme U X9 X4) (And (of U X8 X10) (And (man U X10) (And (agent U X9 X10) (And (forename U X8) (And (vincent_forename U X8) (And (of U X5 X7) (And (man U X7) (And (event X4 X6) (And (agent X4 X6 X7) (And (present X4 X6) (And (smoke X4 X6) (And (forename U X5) (And (jules_forename U X5) (And (proposition U X4) (And (accessible_world U X4) (And (of U X3 X2) (And (jules_forename U X3) (And (forename U X3) (And (be U X1 X2 X2) (And (man U X2) (And (state U X1) (And (of U Y Z) (And (man U Z) (And (agent U X Z) (And (forename U Y) (And (vincent_forename U Y) (And (theme U X V) (And (event U X) (And (present U X) (And (think_believe_consider U X) (And (event V W) (And (agent V W (skf4 V)) (And (present V W) (And (smoke V W) (And (accessible_world U V) (proposition U V))))))))))))))))))))))))))))))))))))))))
.
intros.
exists[
2:
exists[
2:
exists[
2:
exists[
2:
exists[
2:
exists[
2:
exists[
2:
exists[
2:
exists[
2:
exists[
2:
exists[
2:
exists[
2:
exists[
2:
exists[
2:
exists[
2:
exists[
2:
autobatch depth=5 width=5 size=20 timeout=10;
try assumption.
|
skip]
|
skip]
|
skip]
|
skip]
|
skip]
|
skip]
|
skip]
|
skip]
|
skip]
|
skip]
|
skip]
|
skip]
|
skip]
|
skip]
|
skip]
|
skip]
print proofterm.
qed.

(* -------------------------------------------------------------------------- *)
