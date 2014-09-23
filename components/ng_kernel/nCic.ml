(*
    ||M||  This file is part of HELM, an Hypertextual, Electronic        
    ||A||  Library of Mathematics, developed at the Computer Science     
    ||T||  Department, University of Bologna, Italy.                     
    ||I||                                                                
    ||T||  HELM is free software; you can redistribute it and/or         
    ||A||  modify it under the terms of the GNU General Public License   
    \   /  version 2 or (at your option) any later version.      
     \ /   This software is distributed as is, NO WARRANTY.     
      V_______________________________________________________________ *)

(* $Id: nCic.ml 11594 2011-10-18 09:40:12Z ricciott $ *)

(********************************* TERMS ************************************)

type univ_algebra = [ `Type | `Succ | `CProp ]

type universe = (univ_algebra * NUri.uri) list 
  (* Max of non-empty list of named universes, or their successor (when true) 
   * The empty list represents type0 *)

type sort = Prop | Type of universe

type implicit_annotation =
 [ `Closed | `Type | `Hole | `Tagged of string | `Term | `Typeof of int | `Vector ]


type lc_kind = Irl of int | Ctx of term list

and local_context = int * lc_kind             (* shift (0 -> no shift), 
                                                 subst (Irl n means id of
						 length n) *) 
and term =
 | Rel      of int                            (* DeBruijn index, 1 based    *)
 | Meta     of int * local_context
 | Appl     of term list                      (* arguments                  *)
 | Prod     of string * term * term           (* binder, source, target     *)
 | Lambda   of string * term * term           (* binder, source, target     *)
 | LetIn    of string * term * term * term    (* binder, type, term, body   *)
(* Cast \def degenerate LetIn *)
 | Const    of NReference.reference           (* ref has (indtype|constr)no *)
 | Sort     of sort                           (* sort                       *)
 | Implicit of implicit_annotation            (* ...                        *)
 | Match    of NReference.reference *         (* ind. reference,            *)
    term * term *                             (*  outtype, ind. term        *)
    term list                                 (*  patterns                  *)


(********************************* TYPING ***********************************)

type context_entry =                       (* A declaration or definition *)
 | Decl of term                            (* type *)
 | Def  of term * term                     (* body, type *)

type hypothesis = string * context_entry   (* name, entry *)

type context = hypothesis list

type meta_attr = 
  [ `Name of string 
  | `IsTerm | `IsType | `IsSort 
  | `InScope | `OutScope of int]

type meta_attrs = meta_attr list

type conjecture =  meta_attrs * context * term

type metasenv = (int * conjecture) list

type subst_entry = meta_attrs * context * term * term (* name,ctx,bo,ty *)

type substitution = (int * subst_entry) list


(******************************** OBJECTS **********************************)

type relevance = bool list (* relevance of arguments for conversion *)

                    (* relevance, name, recno, ty, bo *)
type inductiveFun = relevance * string * int * term * term 
  (* if coinductive, the int has no meaning and must be set to -1 *)

type constructor = relevance * string * term  (* id, type *)

type inductiveType = 
 relevance * string * term * constructor list    
 (* relevance, typename, arity, constructors *)

type def_flavour = (* presentational *)
  [ `Axiom | `Definition | `Fact | `Lemma | `Theorem | `Corollary | `Example ]

type def_pragma = (* pragmatic of the object *)
  [ `Coercion of int
  | `Elim of sort       (* elimination principle; universe is not relevant *)
  | `Projection         (* record projection *)
  | `InversionPrinciple (* inversion principle *)
  | `DiscriminationPrinciple (* discrimination principle *)
  | `Variant 
  | `Local 
  | `Regular ]            (* Local = hidden technicality *)
 
type ind_pragma = (* pragmatic of the object *)
  [ `Record of (string * bool * int) list | `Regular ]
  (* inductive type that encodes a record; the arguments are the record 
   * fields names and if they are coercions and then the coercion arity *)

type generated = [ `Generated | `Provided ]

type c_attr = generated * def_flavour * def_pragma
type f_attr = generated * def_flavour * def_pragma
type i_attr = generated * ind_pragma

 (* invariant: metasenv and substitution have disjoint domains *)
type obj_kind =
 | Constant  of relevance * string * term option * term * c_attr
 | Fixpoint  of bool * inductiveFun list * f_attr
                (* true -> fix, funcs, arrts *)
 | Inductive of bool * int * inductiveType list * i_attr
                (* true -> inductive, leftno, types *)

 (* the int must be 0 if the object has no body *)
type obj = NUri.uri * int * metasenv * substitution * obj_kind

(* pretty-printing *)
class virtual status =
 object
  method virtual ppterm: context:context -> subst:substitution ->
   metasenv:metasenv -> ?margin:int -> ?inside_fix:bool -> term -> string

  method virtual ppcontext: ?sep:string -> subst:substitution ->
   metasenv:metasenv -> context -> string 

  method virtual ppmetasenv: subst:substitution -> metasenv -> string

  method virtual ppsubst: metasenv:metasenv -> ?use_subst:bool -> substitution -> string

  method virtual ppobj: obj -> string
 end

(* pretty-printing: same as vstatus, but all methods are concrete         *)
(* used only to declare concrete instances of subclasses of vstatus class *)
class type cstatus =
 object
  inherit status

  method ppterm: context:context -> subst:substitution ->
   metasenv:metasenv -> ?margin:int -> ?inside_fix:bool -> term -> string

  method ppcontext: ?sep:string -> subst:substitution ->
   metasenv:metasenv -> context -> string 

  method ppmetasenv: subst:substitution -> metasenv -> string

  method ppsubst: metasenv:metasenv -> ?use_subst:bool -> substitution -> string

  method ppobj: obj -> string
 end
