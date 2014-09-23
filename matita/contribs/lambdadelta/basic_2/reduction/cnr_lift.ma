(**************************************************************************)
(*       ___                                                              *)
(*      ||M||                                                             *)
(*      ||A||       A project by Andrea Asperti                           *)
(*      ||T||                                                             *)
(*      ||I||       Developers:                                           *)
(*      ||T||         The HELM team.                                      *)
(*      ||A||         http://helm.cs.unibo.it                             *)
(*      \   /                                                             *)
(*       \ /        This file is distributed under the terms of the       *)
(*        v         GNU General Public License Version 2                  *)
(*                                                                        *)
(**************************************************************************)

include "basic_2/reduction/cpr_lift.ma".
include "basic_2/reduction/cnr.ma".

(* NORMAL TERMS FOR CONTEXT-SENSITIVE REDUCTION *****************************)

(* Advanced properties ******************************************************)

(* Basic_1: was: nf2_lref_abst *)
lemma cnr_lref_abst: ∀G,L,K,V,i. ⇩[i] L ≡ K. ⓛV → ⦃G, L⦄ ⊢ ➡ 𝐍⦃#i⦄.
#G #L #K #V #i #HLK #X #H
elim (cpr_inv_lref1 … H) -H // *
#K0 #V1 #V2 #HLK0 #_ #_
lapply (drop_mono … HLK … HLK0) -L #H destruct
qed.

(* Relocation properties ****************************************************)

(* Basic_1: was: nf2_lift *)
lemma cnr_lift: ∀G,L0,L,T,T0,s,d,e. ⦃G, L⦄ ⊢ ➡ 𝐍⦃T⦄ →
                ⇩[s, d, e] L0 ≡ L → ⇧[d, e] T ≡ T0 → ⦃G, L0⦄ ⊢ ➡ 𝐍⦃T0⦄.
#G #L0 #L #T #T0 #s #d #e #HLT #HL0 #HT0 #X #H
elim (cpr_inv_lift1 … H … HL0 … HT0) -L0 #T1 #HT10 #HT1
<(HLT … HT1) in HT0; -L #HT0
>(lift_mono … HT10 … HT0) -T1 -X //
qed.

(* Note: this was missing in basic_1 *)
lemma cnr_inv_lift: ∀G,L0,L,T,T0,s,d,e. ⦃G, L0⦄ ⊢ ➡ 𝐍⦃T0⦄ →
                    ⇩[s, d, e] L0 ≡ L → ⇧[d, e] T ≡ T0 → ⦃G, L⦄ ⊢ ➡ 𝐍⦃T⦄.
#G #L0 #L #T #T0 #s #d #e #HLT0 #HL0 #HT0 #X #H
elim (lift_total X d e) #X0 #HX0
lapply (cpr_lift … H … HL0 … HT0 … HX0) -L #HTX0
>(HLT0 … HTX0) in HX0; -L0 -X0 #H
>(lift_inj … H … HT0) -T0 -X -s -d -e //
qed-.
