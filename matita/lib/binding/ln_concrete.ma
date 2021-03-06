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

include "basics/lists/list.ma".
include "basics/deqsets.ma".
include "binding/names.ma".
include "binding/fp.ma".

definition alpha : Nset ≝ X. check alpha
notation "𝔸" non associative with precedence 90 for @{'alphabet}.
interpretation "set of names" 'alphabet = alpha.

inductive tp : Type[0] ≝ 
| top : tp
| arr : tp → tp → tp.
inductive pretm : Type[0] ≝ 
| var : nat → pretm
| par :  𝔸 → pretm
| abs : tp → pretm → pretm
| app : pretm → pretm → pretm.

let rec Nth T n (l:list T) on n ≝ 
  match l with 
  [ nil ⇒ None ?
  | cons hd tl ⇒ match n with
    [ O ⇒ Some ? hd
    | S n0 ⇒ Nth T n0 tl ] ].

let rec vclose_tm_aux u x k ≝ match u with
  [ var n ⇒ if (leb k n) then var (S n) else u
  | par x0 ⇒ if (x0 == x) then (var k) else u
  | app v1 v2 ⇒ app (vclose_tm_aux v1 x k) (vclose_tm_aux v2 x k)
  | abs s v ⇒ abs s (vclose_tm_aux v x (S k)) ].
definition vclose_tm ≝ λu,x.vclose_tm_aux u x O.  

definition vopen_var ≝ λn,x,k.match eqb n k with
 [ true ⇒ par x
 | false ⇒ match leb n k with
   [ true ⇒ var n
   | false ⇒ var (pred n) ] ].

let rec vopen_tm_aux u x k ≝ match u with
  [ var n ⇒ vopen_var n x k
  | par x0 ⇒ u
  | app v1 v2 ⇒ app (vopen_tm_aux v1 x k) (vopen_tm_aux v2 x k)
  | abs s v ⇒ abs s (vopen_tm_aux v x (S k)) ].
definition vopen_tm ≝ λu,x.vopen_tm_aux u x O.

let rec FV u ≝ match u with 
  [ par x ⇒ [x]
  | app v1 v2 ⇒ FV v1@FV v2
  | abs s v ⇒ FV v
  | _ ⇒ [ ] ].  

definition lam ≝ λx,s,u.abs s (vclose_tm u x).

let rec Pi_map_tm p u on u ≝ match u with
[ par x ⇒ par (p x)
| var _ ⇒ u
| app v1 v2 ⇒ app (Pi_map_tm p v1) (Pi_map_tm p v2)
| abs s v ⇒ abs s (Pi_map_tm p v) ].

interpretation "permutation of tm" 'middot p x = (Pi_map_tm p x).

notation "hvbox(u⌈x⌉)"
  with precedence 45
  for @{ 'open $u $x }.

(*
notation "hvbox(u⌈x⌉)"
  with precedence 45
  for @{ 'open $u $x }.
notation "❴ u ❵ x" non associative with precedence 90 for @{ 'open $u $x }.
*)
interpretation "ln term variable open" 'open u x = (vopen_tm u x).
notation < "hvbox(ν x break . u)"
 with precedence 20
for @{'nu $x $u }.
notation > "ν list1 x sep , . term 19 u" with precedence 20
  for ${ fold right @{$u} rec acc @{'nu $x $acc)} }.
interpretation "ln term variable close" 'nu x u = (vclose_tm u x).

let rec tm_height u ≝ match u with
[ app v1 v2 ⇒ S (max (tm_height v1) (tm_height v2))
| abs s v ⇒ S (tm_height v) 
| _ ⇒ O ].

theorem le_n_O_rect_Type0 : ∀n:nat. n ≤ O → ∀P: nat →Type[0]. P O → P n.
#n (cases n) // #a #abs cases (?:False) /2/ qed. 

theorem nat_rect_Type0_1 : ∀n:nat.∀P:nat → Type[0]. 
(∀m.(∀p. p < m → P p) → P m) → P n.
#n #P #H 
cut (∀q:nat. q ≤ n → P q) /2/
(elim n) 
 [#q #HleO (* applica male *) 
    @(le_n_O_rect_Type0 ? HleO)
    @H #p #ltpO cases (?:False) /2/ (* 3 *)
 |#p #Hind #q #HleS 
    @H #a #lta @Hind @le_S_S_to_le /2/
 ]
qed.

lemma leb_false_to_lt : ∀n,m. leb n m = false → m < n.
#n elim n
[ #m normalize #H destruct(H)
| #n0 #IH * // #m normalize #H @le_S_S @IH // ]
qed.

lemma nominal_eta_aux : ∀x,u.x ∉ FV u → ∀k.vclose_tm_aux (vopen_tm_aux u x k) x k = u.
#x #u elim u
[ #n #_ #k normalize cases (decidable_eq_nat n k) #Hnk
  [ >Hnk >eqb_n_n whd in ⊢ (??%?); >(\b ?) //
  | >(not_eq_to_eqb_false … Hnk) normalize cases (true_or_false (leb n k)) #Hleb
    [ >Hleb normalize >(?:leb k n = false) //
      @lt_to_leb_false @not_eq_to_le_to_lt /2/
    | >Hleb normalize >(?:leb k (pred n) = true) normalize
      [ cases (leb_false_to_lt … Hleb) //
      | @le_to_leb_true cases (leb_false_to_lt … Hleb) normalize /2/ ] ] ]
| #y normalize in ⊢ (%→?→?); #Hy whd in ⊢ (?→??%?); >(\bf ?) // @(not_to_not … Hy) //
| #s #v #IH normalize #Hv #k >IH // @Hv
| #v1 #v2 #IH1 #IH2 normalize #Hv1v2 #k 
  >IH1 [ >IH2 // | @(not_to_not … Hv1v2) @in_list_to_in_list_append_l ]
  @(not_to_not … Hv1v2) @in_list_to_in_list_append_r ]
qed.

corollary nominal_eta : ∀x,u.x ∉ FV u → (νx.u⌈x⌉) = u.
#x #u #Hu @nominal_eta_aux //
qed.

lemma eq_height_vopen_aux : ∀v,x,k.tm_height (vopen_tm_aux v x k) = tm_height v.
#v #x elim v
[ #n #k normalize cases (eqb n k) // cases (leb n k) //
| #u #k %
| #s #u #IH #k normalize >IH %
| #u1 #u2 #IH1 #IH2 #k normalize >IH1 >IH2 % ]
qed.

corollary eq_height_vopen : ∀v,x.tm_height (v⌈x⌉) = tm_height v.
#v #x @eq_height_vopen_aux
qed.

theorem pretm_ind_plus_aux : 
 ∀P:pretm → Type[0].
   (∀x:𝔸.P (par x)) → 
   (∀n:ℕ.P (var n)) → 
   (∀v1,v2. P v1 → P v2 → P (app v1 v2)) → 
   ∀C:list 𝔸.
   (∀x,s,v.x ∉ FV v → x ∉ C → P (v⌈x⌉) → P (lam x s (v⌈x⌉))) →
 ∀n,u.tm_height u ≤ n → P u.
#P #Hpar #Hvar #Happ #C #Hlam #n change with ((λn.?) n); @(nat_rect_Type0_1 n ??)
#m cases m
[ #_ * /2/
  [ normalize #s #v #Hfalse cases (?:False) cases (not_le_Sn_O (tm_height v)) /2/
  | #v1 #v2 whd in ⊢ (?%?→?); #Hfalse cases (?:False) cases (not_le_Sn_O (S (max ??))) /2/ ] ]
-m #m #IH * /2/
[ #s #v whd in ⊢ (?%?→?); #Hv
  lapply (p_fresh … (C@FV v)) letin y ≝ (N_fresh … (C@FV v)) #Hy
  >(?:abs s v = lam y s (v⌈y⌉))
  [| whd in ⊢ (???%); >nominal_eta // @(not_to_not … Hy) @in_list_to_in_list_append_r ] 
  @Hlam
  [ @(not_to_not … Hy) @in_list_to_in_list_append_r
  | @(not_to_not … Hy) @in_list_to_in_list_append_l ]
  @IH [| @Hv | >eq_height_vopen % ]
| #v1 #v2 whd in ⊢ (?%?→?); #Hv @Happ
  [ @IH [| @Hv | // ] | @IH [| @Hv | // ] ] ]
qed.

corollary pretm_ind_plus :
 ∀P:pretm → Type[0].
   (∀x:𝔸.P (par x)) → 
   (∀n:ℕ.P (var n)) → 
   (∀v1,v2. P v1 → P v2 → P (app v1 v2)) → 
   ∀C:list 𝔸.
   (∀x,s,v.x ∉ FV v → x ∉ C → P (v⌈x⌉) → P (lam x s (v⌈x⌉))) →
 ∀u.P u.
#P #Hpar #Hvar #Happ #C #Hlam #u @pretm_ind_plus_aux /2/
qed.

(* maps a permutation to a list of terms *)
definition Pi_map_list : (𝔸 → 𝔸) → list 𝔸 → list 𝔸 ≝ map 𝔸 𝔸 .

(* interpretation "permutation of name list" 'middot p x = (Pi_map_list p x).*)

(*
inductive tm : pretm → Prop ≝ 
| tm_par : ∀x:𝔸.tm (par x)
| tm_app : ∀u,v.tm u → tm v → tm (app u v)
| tm_lam : ∀x,s,u.tm u → tm (lam x s u).

inductive ctx_aux : nat → pretm → Prop ≝ 
| ctx_var : ∀n,k.n < k → ctx_aux k (var n)
| ctx_par : ∀x,k.ctx_aux k (par x)
| ctx_app : ∀u,v,k.ctx_aux k u → ctx_aux k v → ctx_aux k (app u v)
(* è sostituibile da ctx_lam ? *)
| ctx_abs : ∀s,u.ctx_aux (S k) u → ctx_aux k (abs s u).
*)

inductive tm_or_ctx (k:nat) : pretm → Type[0] ≝ 
| toc_var : ∀n.n < k → tm_or_ctx k (var n)
| toc_par : ∀x.tm_or_ctx k (par x)
| toc_app : ∀u,v.tm_or_ctx k u → tm_or_ctx k v → tm_or_ctx k (app u v)
| toc_lam : ∀x,s,u.tm_or_ctx k u → tm_or_ctx k (lam x s u).

definition tm ≝ λt.tm_or_ctx O t.
definition ctx ≝ λt.tm_or_ctx 1 t.

record TM : Type[0] ≝ {
  pretm_of_TM :> pretm;
  tm_of_TM : tm pretm_of_TM
}.

record CTX : Type[0] ≝ {
  pretm_of_CTX :> pretm;
  ctx_of_CTX : ctx pretm_of_CTX
}.

inductive tm2 : pretm → Type[0] ≝ 
| tm_par : ∀x.tm2 (par x)
| tm_app : ∀u,v.tm2 u → tm2 v → tm2 (app u v)
| tm_lam : ∀x,s,u.x ∉ FV u → (∀y.y ∉ FV u → tm2 (u⌈y⌉)) → tm2 (lam x s (u⌈x⌉)).

(*
inductive tm' : pretm → Prop ≝ 
| tm_par : ∀x.tm' (par x)
| tm_app : ∀u,v.tm' u → tm' v → tm' (app u v)
| tm_lam : ∀x,s,u,C.x ∉ FV u → x ∉ C → (∀y.y ∉ FV u → tm' (❴u❵y)) → tm' (lam x s (❴u❵x)).
*)

axiom swap_inj : ∀N.∀z1,z2,x,y.swap N z1 z2 x = swap N z1 z2 y → x = y.

lemma pi_vclose_tm : 
  ∀z1,z2,x,u.swap 𝔸 z1 z2·(νx.u) = (ν swap ? z1 z2 x.swap 𝔸 z1 z2 · u).
#z1 #z2 #x #u
change with (vclose_tm_aux ???) in match (vclose_tm ??);
change with (vclose_tm_aux ???) in ⊢ (???%); lapply O elim u
[3:whd in ⊢ (?→?→(?→ ??%%)→?→??%%); //
|4:whd in ⊢ (?→?→(?→??%%)→(?→??%%)→?→??%%); //
| #n #k whd in ⊢ (??(??%)%); cases (leb k n) normalize %
| #x0 #k cases (true_or_false (x0==z1)) #H1 >H1 whd in ⊢ (??%%);
  [ cases (true_or_false (x0==x)) #H2 >H2 whd in ⊢ (??(??%)%);
    [ <(\P H2) >H1 whd in ⊢ (??(??%)%); >(\b ?) // >(\b ?) //
    | >H2 whd in match (swap ????); >H1
      whd in match (if false then var k else ?);
      whd in match (if true then z2 else ?); >(\bf ?)
      [ >(\P H1) >swap_left %
      | <(swap_inv ? z1 z2 z2) in ⊢ (?(??%?)); % #H3
        lapply (swap_inj … H3) >swap_right #H4 <H4 in H2; >H1 #H destruct (H) ]
    ]
  | >(?:(swap ? z1 z2 x0 == swap ? z1 z2 x) = (x0 == x))
    [| cases (true_or_false (x0==x)) #H2 >H2
      [ >(\P H2) @(\b ?) %
      | @(\bf ?) % #H >(swap_inj … H) in H2; >(\b ?) // #H0 destruct (H0) ] ]
    cases (true_or_false (x0==x)) #H2 >H2 whd in ⊢ (??(??%)%); 
    [ <(\P H2) >H1 >(\b (refl ??)) %
    | >H1 >H2 % ]
    ]
  ]
qed.

lemma pi_vopen_tm : 
  ∀z1,z2,x,u.swap 𝔸 z1 z2·(u⌈x⌉) = (swap 𝔸 z1 z2 · u⌈swap 𝔸 z1 z2 x⌉).
#z1 #z2 #x #u
change with (vopen_tm_aux ???) in match (vopen_tm ??);
change with (vopen_tm_aux ???) in ⊢ (???%); lapply O elim u //
[2: #s #v whd in ⊢ ((?→??%%)→?→??%%); //
|3: #v1 #v2 whd in ⊢ ((?→??%%)→(?→??%%)→?→??%%); /2/ ]
#n #k whd in ⊢ (??(??%)%); cases (true_or_false (eqb n k)) #H1 >H1 //
cases (true_or_false (leb n k)) #H2 >H2 normalize //
qed.

lemma pi_lam : 
  ∀z1,z2,x,s,u.swap 𝔸 z1 z2 · lam x s u = lam (swap 𝔸 z1 z2 x) s (swap 𝔸 z1 z2 · u).
#z1 #z2 #x #s #u whd in ⊢ (???%); <(pi_vclose_tm …) %
qed.

lemma eqv_FV : ∀z1,z2,u.FV (swap 𝔸 z1 z2 · u) = Pi_map_list (swap 𝔸 z1 z2) (FV u).
#z1 #z2 #u elim u //
[ #s #v #H @H
| #v1 #v2 whd in ⊢ (??%%→??%%→??%%); #H1 #H2 >H1 >H2
  whd in ⊢ (???(????%)); /2/ ]
qed.

lemma swap_inv_tm : ∀z1,z2,u.swap 𝔸 z1 z2 · (swap 𝔸 z1 z2 · u) = u.
#z1 #z2 #u elim u 
[1: #n %
|3: #s #v whd in ⊢ (?→??%%); //
|4: #v1 #v2 #Hv1 #Hv2 whd in ⊢ (??%%); // ]
#x whd in ⊢ (??%?); >swap_inv %
qed.

lemma eqv_in_list : ∀x,l,z1,z2.x ∈ l → swap 𝔸 z1 z2 x ∈ Pi_map_list (swap 𝔸 z1 z2) l.
#x #l #z1 #z2 #Hin elim Hin
[ #x0 #l0 %
| #x1 #x2 #l0 #Hin #IH %2 @IH ]
qed.

lemma eqv_tm2 : ∀u.tm2 u → ∀z1,z2.tm2 ((swap ? z1 z2)·u).
#u #Hu #z1 #z2 letin p ≝ (swap ? z1 z2) elim Hu /2/
#x #s #v #Hx #Hv #IH >pi_lam >pi_vopen_tm %3
[ @(not_to_not … Hx) -Hx #Hx
  <(swap_inv ? z1 z2 x) <(swap_inv_tm z1 z2 v) >eqv_FV @eqv_in_list //
| #y #Hy <(swap_inv ? z1 z2 y)
  <pi_vopen_tm @IH @(not_to_not … Hy) -Hy #Hy <(swap_inv ? z1 z2 y)
  >eqv_FV @eqv_in_list //
]
qed.

lemma vclose_vopen_aux : ∀x,u,k.vopen_tm_aux (vclose_tm_aux u x k) x k = u.
#x #u elim u [1,3,4:normalize //]
[ #n #k cases (true_or_false (leb k n)) #H >H whd in ⊢ (??%?);
  [ cases (true_or_false (eqb (S n) k)) #H1 >H1
    [ <(eqb_true_to_eq … H1) in H; #H lapply (leb_true_to_le … H) -H #H
      cases (le_to_not_lt … H) -H #H cases (H ?) %
    | whd in ⊢ (??%?); >lt_to_leb_false // @le_S_S /2/ ]
  | cases (true_or_false (eqb n k)) #H1 >H1 normalize
    [ >(eqb_true_to_eq … H1) in H; #H lapply (leb_false_to_not_le … H) -H
      * #H cases (H ?) %
    | >le_to_leb_true // @not_lt_to_le % #H2 >le_to_leb_true in H;
      [ #H destruct (H) | /2/ ]
    ]
  ]
| #x0 #k whd in ⊢ (??(?%??)?); cases (true_or_false (x0==x)) 
  #H1 >H1 normalize // >(\P H1) >eqb_n_n % ]
qed.      

lemma vclose_vopen : ∀x,u.((νx.u)⌈x⌉) = u. #x #u @vclose_vopen_aux
qed.

(*
theorem tm_to_tm : ∀t.tm' t → tm t.
#t #H elim H
*)

lemma in_list_singleton : ∀T.∀t1,t2:T.t1 ∈ [t2] → t1 = t2.
#T #t1 #t2 #H @(in_list_inv_ind ??? H) /2/
qed.

lemma fresh_vclose_tm_aux : ∀u,x,k.x ∉ FV (vclose_tm_aux u x k).
#u #x elim u //
[ #n #k normalize cases (leb k n) normalize //
| #x0 #k whd in ⊢ (?(???(?%))); cases (true_or_false (x0==x)) #H >H normalize //
  lapply (\Pf H) @not_to_not #Hin >(in_list_singleton ??? Hin) %
| #v1 #v2 #IH1 #IH2 #k normalize % #Hin cases (in_list_append_to_or_in_list ???? Hin) -Hin #Hin
  [ cases (IH1 k) -IH1 #IH1 @IH1 @Hin | cases (IH2 k) -IH2 #IH2 @IH2 @Hin ]
qed.

lemma fresh_vclose_tm : ∀u,x.x ∉ FV (νx.u). //
qed.

lemma fresh_swap_tm : ∀z1,z2,u.z1 ∉ FV u → z2 ∉ FV u → swap 𝔸 z1 z2 · u = u.
#z1 #z2 #u elim u
[2: normalize in ⊢ (?→%→%→?); #x #Hz1 #Hz2 whd in ⊢ (??%?); >swap_other //
  [ @(not_to_not … Hz2) | @(not_to_not … Hz1) ] //
|1: //
| #s #v #IH normalize #Hz1 #Hz2 >IH // [@Hz2|@Hz1]
| #v1 #v2 #IH1 #IH2 normalize #Hz1 #Hz2
  >IH1 [| @(not_to_not … Hz2) @in_list_to_in_list_append_l | @(not_to_not … Hz1) @in_list_to_in_list_append_l ]
  >IH2 // [@(not_to_not … Hz2) @in_list_to_in_list_append_r | @(not_to_not … Hz1) @in_list_to_in_list_append_r ]
]
qed.

theorem tm_to_tm2 : ∀u.tm u → tm2 u.
#t #Ht elim Ht
[ #n #Hn cases (not_le_Sn_O n) #Hfalse cases (Hfalse Hn)
| @tm_par
| #u #v #Hu #Hv @tm_app
| #x #s #u #Hu #IHu <(vclose_vopen x u) @tm_lam
  [ @fresh_vclose_tm
  | #y #Hy <(fresh_swap_tm x y (νx.u)) /2/ @fresh_vclose_tm ]
]
qed.

theorem tm2_to_tm : ∀u.tm2 u → tm u.
#u #pu elim pu /2/ #x #s #v #Hx #Hv #IH %4 @IH //
qed.

definition PAR ≝ λx.mk_TM (par x) ?. // qed.
definition APP ≝ λu,v:TM.mk_TM (app u v) ?./2/ qed.
definition LAM ≝ λx,s.λu:TM.mk_TM (lam x s u) ?./2/ qed.

axiom vopen_tm_down : ∀u,x,k.tm_or_ctx (S k) u → tm_or_ctx k (u⌈x⌉).
(* needs true_plus_false

#u #x #k #Hu elim Hu
[ #n #Hn normalize cases (true_or_false (eqb n O)) #H >H [%2]
  normalize >(?: leb n O = false) [|cases n in H; // >eqb_n_n #H destruct (H) ]
  normalize lapply Hn cases n in H; normalize [ #Hfalse destruct (Hfalse) ]
  #n0 #_ #Hn0 % @le_S_S_to_le //
| #x0 %2
| #v1 #v2 #Hv1 #Hv2 #IH1 #IH2 %3 //
| #x0 #s #v #Hv #IH normalize @daemon
]
qed.
*)

definition vopen_TM ≝ λu:CTX.λx.mk_TM (u⌈x⌉) (vopen_tm_down …). @ctx_of_CTX qed.

axiom vclose_tm_up : ∀u,x,k.tm_or_ctx k u → tm_or_ctx (S k) (νx.u).

definition vclose_TM ≝ λu:TM.λx.mk_CTX (νx.u) (vclose_tm_up …). @tm_of_TM qed.

interpretation "ln wf term variable open" 'open u x = (vopen_TM u x).
interpretation "ln wf term variable close" 'nu x u = (vclose_TM u x).

theorem tm_alpha : ∀x,y,s,u.x ∉ FV u → y ∉ FV u → lam x s (u⌈x⌉) = lam y s (u⌈y⌉).
#x #y #s #u #Hx #Hy whd in ⊢ (??%%); @eq_f >nominal_eta // >nominal_eta //
qed.

theorem TM_ind_plus : 
(* non si può dare il principio in modo dipendente (almeno utilizzando tm2)
   la "prova" purtroppo è in Type e non si può garantire che sia esattamente
   quella che ci aspetteremmo
 *)
 ∀P:pretm → Type[0].
   (∀x:𝔸.P (PAR x)) → 
   (∀v1,v2:TM.P v1 → P v2 → P (APP v1 v2)) → 
   ∀C:list 𝔸.
   (∀x,s.∀v:CTX.x ∉ FV v → x ∉ C → 
     (∀y.y ∉ FV v → P (v⌈y⌉)) → P (LAM x s (v⌈x⌉))) →
 ∀u:TM.P u.
#P #Hpar #Happ #C #Hlam * #u #pu elim (tm_to_tm2 u pu) //
[ #v1 #v2 #pv1 #pv2 #IH1 #IH2 @(Happ (mk_TM …) (mk_TM …)) /2/
| #x #s #v #Hx #pv #IH
  lapply (p_fresh … (C@FV v)) letin x0 ≝ (N_fresh … (C@FV v)) #Hx0
  >(?:lam x s (v⌈x⌉) = lam x0 s (v⌈x0⌉))
  [|@tm_alpha // @(not_to_not … Hx0) @in_list_to_in_list_append_r ]
  @(Hlam x0 s (mk_CTX v ?) ??)
  [ <(nominal_eta … Hx) @vclose_tm_up @tm2_to_tm @pv //
  | @(not_to_not … Hx0) @in_list_to_in_list_append_r
  | @(not_to_not … Hx0) @in_list_to_in_list_append_l
  | @IH ]
]
qed.

notation 
"hvbox('nominal' u 'return' out 'with' 
       [ 'xpar' ident x ⇒ f1 
       | 'xapp' ident v1 ident v2 ident recv1 ident recv2 ⇒ f2 
       | 'xlam' ❨ident y # C❩ ident s ident w ident py1 ident py2 ident recw ⇒ f3 ])"
with precedence 48 
for @{ TM_ind_plus $out (λ${ident x}:?.$f1)
       (λ${ident v1}:?.λ${ident v2}:?.λ${ident recv1}:?.λ${ident recv2}:?.$f2)
       $C (λ${ident y}:?.λ${ident s}:?.λ${ident w}:?.λ${ident py1}:?.λ${ident py2}:?.λ${ident recw}:?.$f3)
       $u }.
       
(* include "basics/jmeq.ma".*)

definition subst ≝ (λu:TM.λx,v.
  nominal u return (λ_.TM) with 
  [ xpar x0 ⇒ match x == x0 with [ true ⇒ v | false ⇒ u ]
  | xapp v1 v2 recv1 recv2 ⇒ APP recv1 recv2
  | xlam ❨y # x::FV v❩ s w py1 py2 recw ⇒ LAM y s (recw y py1) ]).

lemma fasfd : ∀s,v. pretm_of_TM (subst (LAM O s (PAR 1)) O v) = pretm_of_TM (LAM O s (PAR 1)).
#s #v normalize in ⊢ (??%?);


theorem tm2_ind_plus : 
(* non si può dare il principio in modo dipendente (almeno utilizzando tm2) *)
 ∀P:pretm → Type[0].
   (∀x:𝔸.P (par x)) → 
   (∀v1,v2.tm2 v1 → tm2 v2 → P v1 → P v2 → P (app v1 v2)) → 
   ∀C:list 𝔸.
   (∀x,s,v.x ∉ FV v → x ∉ C → (∀y.y ∉ FV v → tm2 (v⌈y⌉)) → 
     (∀y.y ∉ FV v → P (v⌈y⌉)) → P (lam x s (v⌈x⌉))) →
 ∀u.tm2 u → P u.
#P #Hpar #Happ #C #Hlam #u #pu elim pu /2/
#x #s #v #px #pv #IH 
lapply (p_fresh … (C@FV v)) letin y ≝ (N_fresh … (C@FV v)) #Hy
>(?:lam x s (v⌈x⌉) = lam y s (v⌈y⌉)) [| @tm_alpha // @(not_to_not … Hy) @in_list_to_in_list_append_r ]
@Hlam /2/ lapply Hy -Hy @not_to_not #Hy
[ @in_list_to_in_list_append_r @Hy | @in_list_to_in_list_append_l @Hy ]
qed.

definition check_tm ≝ 
  λu.pretm_ind_plus ? (λ_.true) (λ_.false) 
    (λv1,v2,r1,r2.r1 ∧ r2) [ ] (λx,s,v,pv1,pv2,rv.rv) u.

(*
lemma check_tm_complete : ∀u.tm u → check_tm u = true.
#u #pu @(tm2_ind_plus … [ ] … (tm_to_tm2 ? pu)) //
[ #v1 #v2 #pv1 #pv2 #IH1 #IH2
| #x #s #v #Hx1 #Hx2 #Hv #IH
*)

notation 
"hvbox('nominal' u 'return' out 'with' 
       [ 'xpar' ident x ⇒ f1 
       | 'xapp' ident v1 ident v2 ident pv1 ident pv2 ident recv1 ident recv2 ⇒ f2 
       | 'xlam' ❨ident y # C❩ ident s ident w ident py1 ident py2 ident pw ident recw ⇒ f3 ])"
with precedence 48 
for @{ tm2_ind_plus $out (λ${ident x}:?.$f1)
       (λ${ident v1}:?.λ${ident v2}:?.λ${ident pv1}:?.λ${ident pv2}:?.λ${ident recv1}:?.λ${ident recv2}:?.$f2)
       $C (λ${ident y}:?.λ${ident s}:?.λ${ident w}:?.λ${ident py1}:?.λ${ident py2}:?.λ${ident pw}:?.λ${ident recw}:?.$f3)
       ? (tm_to_tm2 ? $u) }.
(* notation 
"hvbox('nominal' u 'with' 
       [ 'xlam' ident x # C ident s ident w ⇒ f3 ])"
with precedence 48 
for @{ tm2_ind_plus ???
 $C (λ${ident x}:?.λ${ident s}:?.λ${ident w}:?.λ${ident py1}:?.λ${ident py2}:?.
     λ${ident pw}:?.λ${ident recw}:?.$f3) $u (tm_to_tm2 ??) }.
*)


definition subst ≝ (λu.λpu:tm u.λx,v.
  nominal pu return (λ_.pretm) with 
  [ xpar x0 ⇒ match x == x0 with [ true ⇒ v | false ⇒ u ]
  | xapp v1 v2 pv1 pv2 recv1 recv2 ⇒ app recv1 recv2
  | xlam ❨y # x::FV v❩ s w py1 py2 pw recw ⇒ lam y s (recw y py1) ]).
  
lemma fasfd : ∀x,s,u,p1,v. subst (lam x s u) p1 x v = lam x s u.
#x #s #u #p1 #v


definition subst ≝ λu.λpu:tm u.λx,y.
  tm2_ind_plus ?
  (* par x0 *)              (λx0.match x == x0 with [ true ⇒ v | false ⇒ u ])
  (* app v1 v2 *)           (λv1,v2,pv1,pv2,recv1,recv2.app recv1 recv2)
  (* lam y#(x::FV v) s w *) (x::FV v) (λy,s,w,py1,py2,pw,recw.lam y s (recw y py1)) 
  u (tm_to_tm2 … pu).
check subst
definition subst ≝ λu.λpu:tm u.λx,v.
  nominal u with 
  [ xlam y # (x::FV v) s w ^ ? ].

(*
notation > "Λ ident x. ident T [ident x] ↦ P"
  with precedence 48 for @{'foo (λ${ident x}.λ${ident T}.$P)}.

notation < "Λ ident x. ident T [ident x] ↦ P"
  with precedence 48 for @{'foo (λ${ident x}:$Q.λ${ident T}:$R.$P)}.
*)

(*
notation 
"hvbox('nominal' u 'with' 
       [ 'xpar' ident x ⇒ f1 
       | 'xapp' ident v1 ident v2  ⇒ f2
       | 'xlam' ident x # C s w ⇒ f3 ])"
with precedence 48 
for @{ tm2_ind_plus ? (λ${ident x}:$Tx.$f1) 
 (λ${ident v1}:$Tv1.λ${ident v2}:$Tv2.λ${ident pv1}:$Tpv1.λ${ident pv2}:$Tpv2.λ${ident recv1}:$Trv1.λ${ident recv2}:$Trv2.$f2)
 $C (λ${ident x}:$Tx.λ${ident s}:$Ts.λ${ident w}:$Tw.λ${ident py1}:$Tpy1.λ${ident py2}:$Tpy2.λ${ident pw}:$Tpw.λ${ident recw}:$Trw.$f3) $u (tm_to_tm2 ??) }.
*)

(*
notation 
"hvbox('nominal' u 'with' 
       [ 'xpar' ident x ^ f1 
       | 'xapp' ident v1 ident v2 ^ f2 ])"
(*       | 'xlam' ident x # C s w ^ f3 ]) *)
with precedence 48 
for @{ tm2_ind_plus ? (λ${ident x}:$Tx.$f1) 
 (λ${ident v1}:$Tv1.λ${ident v2}:$Tv2.λ${ident pv1}:$Tpv1.λ${ident pv2}:$Tpv2.λ${ident recv1}:$Trv1.λ${ident recv2}:$Trv2.$f2)
 $C (λ${ident x}:$Tx.λ${ident s}:$Ts.λ${ident w}:$Tw.λ${ident py1}:$Tpy1.λ${ident py2}:$Tpy2.λ${ident pw}:$Tpw.λ${ident recw}:$Trw.$f3) $u (tm_to_tm2 ??) }.
*)
notation 
"hvbox('nominal' u 'with' 
       [ 'xpar' ident x ^ f1 
       | 'xapp' ident v1 ident v2 ^ f2 ])"
with precedence 48 
for @{ tm2_ind_plus ? (λ${ident x}:?.$f1) 
 (λ${ident v1}:$Tv1.λ${ident v2}:$Tv2.λ${ident pv1}:$Tpv1.λ${ident pv2}:$Tpv2.λ${ident recv1}:$Trv1.λ${ident recv2}:$Trv2.$f2)
 $C (λ${ident x}:?.λ${ident s}:$Ts.λ${ident w}:$Tw.λ${ident py1}:$Tpy1.λ${ident py2}:$Tpy2.λ${ident pw}:$Tpw.λ${ident recw}:$Trw.$f3) $u (tm_to_tm2 ??) }.


definition subst ≝ λu.λpu:tm u.λx,v.
  nominal u with 
  [ xpar x0 ^ match x == x0 with [ true ⇒ v | false ⇒ u ]
  | xapp v1 v2 ^ ? ].
  | xlam y # (x::FV v) s w ^ ? ].
  
  
  (* par x0 *)              (λx0.match x == x0 with [ true ⇒ v | false ⇒ u ])
  (* app v1 v2 *)           (λv1,v2,pv1,pv2,recv1,recv2.app recv1 recv2)
  (* lam y#(x::FV v) s w *) (x::FV v) (λy,s,w,py1,py2,pw,recw.lam y s (recw y py1)) 
  u (tm_to_tm2 … pu).
 
 
*)
definition subst ≝ λu.λpu:tm u.λx,v.
  tm2_ind_plus ?
  (* par x0 *)              (λx0.match x == x0 with [ true ⇒ v | false ⇒ u ])
  (* app v1 v2 *)           (λv1,v2,pv1,pv2,recv1,recv2.app recv1 recv2)
  (* lam y#(x::FV v) s w *) (x::FV v) (λy,s,w,py1,py2,pw,recw.lam y s (recw y py1)) 
  u (tm_to_tm2 … pu).

check subst
 

axiom in_Env : 𝔸 × tp → Env → Prop.
notation "X ◃ G" non associative with precedence 45 for @{'lefttriangle $X $G}.
interpretation "Env membership" 'lefttriangle x l = (in_Env x l).



inductive judg : list tp → tm → tp → Prop ≝ 
| t_var : ∀g,n,t.Nth ? n g = Some ? t → judg g (var n) t
| t_app : ∀g,m,n,t,u.judg g m (arr t u) → judg g n t → judg g (app m n) u
| t_abs : ∀g,t,m,u.judg (t::g) m u → judg g (abs t m) (arr t u).

definition Env := list (𝔸 × tp).

axiom vclose_env : Env → list tp.
axiom vclose_tm : Env → tm → tm.
axiom Lam : 𝔸 → tp → tm → tm.
definition Judg ≝ λG,M,T.judg (vclose_env G) (vclose_tm G M) T.
definition dom ≝ λG:Env.map ?? (fst ??) G.

definition sctx ≝ 𝔸 × tm.
axiom swap_tm : 𝔸 → 𝔸 → tm → tm.
definition sctx_app : sctx → 𝔸 → tm ≝ λM0,Y.let 〈X,M〉 ≝ M0 in swap_tm X Y M.

axiom in_list : ∀A:Type[0].A → list A → Prop.
interpretation "list membership" 'mem x l = (in_list ? x l).
interpretation "list non-membership" 'notmem x l = (Not (in_list ? x l)).

axiom in_Env : 𝔸 × tp → Env → Prop.
notation "X ◃ G" non associative with precedence 45 for @{'lefttriangle $X $G}.
interpretation "Env membership" 'lefttriangle x l = (in_Env x l).

let rec FV M ≝ match M with 
  [ par X ⇒ [X]
  | app M1 M2 ⇒ FV M1@FV M2
  | abs T M0 ⇒ FV M0
  | _ ⇒ [ ] ].

(* axiom Lookup : 𝔸 → Env → option tp. *)

(* forma alto livello del judgment
   t_abs* : ∀G,T,X,M,U.
            (∀Y ∉ supp(M).Judg (〈Y,T〉::G) (M[Y]) U) → 
            Judg G (Lam X T (M[X])) (arr T U) *)

(* prima dimostrare, poi perfezionare gli assiomi, poi dimostrarli *)

axiom Judg_ind : ∀P:Env → tm → tp → Prop.
  (∀X,G,T.〈X,T〉 ◃ G → P G (par X) T) → 
  (∀G,M,N,T,U.
    Judg G M (arr T U) → Judg G N T → 
    P G M (arr T U) → P G N T → P G (app M N) U) → 
  (∀G,T1,T2,X,M1.
    (∀Y.Y ∉ (FV (Lam X T1 (sctx_app M1 X))) → Judg (〈Y,T1〉::G) (sctx_app M1 Y) T2) →
    (∀Y.Y ∉ (FV (Lam X T1 (sctx_app M1 X))) → P (〈Y,T1〉::G) (sctx_app M1 Y) T2) → 
    P G (Lam X T1 (sctx_app M1 X)) (arr T1 T2)) → 
  ∀G,M,T.Judg G M T → P G M T.

axiom t_par : ∀X,G,T.〈X,T〉 ◃ G → Judg G (par X) T.
axiom t_app2 : ∀G,M,N,T,U.Judg G M (arr T U) → Judg G N T → Judg G (app M N) U.
axiom t_Lam : ∀G,X,M,T,U.Judg (〈X,T〉::G) M U → Judg G (Lam X T M) (arr T U).

definition subenv ≝ λG1,G2.∀x.x ◃ G1 → x ◃ G2.
interpretation "subenv" 'subseteq G1 G2 = (subenv G1 G2).

axiom daemon : ∀P:Prop.P.

theorem weakening : ∀G1,G2,M,T.G1 ⊆ G2 → Judg G1 M T → Judg G2 M T.
#G1 #G2 #M #T #Hsub #HJ lapply Hsub lapply G2 -G2 change with (∀G2.?)
@(Judg_ind … HJ)
[ #X #G #T0 #Hin #G2 #Hsub @t_par @Hsub //
| #G #M0 #N #T0 #U #HM0 #HN #IH1 #IH2 #G2 #Hsub @t_app2
  [| @IH1 // | @IH2 // ]
| #G #T1 #T2 #X #M1 #HM1 #IH #G2 #Hsub @t_Lam @IH 
  [ (* trivial property of Lam *) @daemon 
  | (* trivial property of subenv *) @daemon ]
]
qed.

(* Serve un tipo Tm per i termini localmente chiusi e i suoi principi di induzione e
   ricorsione *)