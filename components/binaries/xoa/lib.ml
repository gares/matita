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

module F   = Filename

module R   = Helm_registry

let template = "matita.ma.templ"

let myself = F.basename Sys.argv.(0)

let get_preamble conf =
   R.load_from conf;
   let rt_base_dir = R.get_string "matita.rt_base_dir" in
   F.concat rt_base_dir template

let copy_preamble preamble och =
   let ich = open_in preamble in
   let rec read () =
      Printf.fprintf och "%s\n" (input_line ich); read ()
   in
   try read () with End_of_file -> close_in ich

let print_comment och =
   let stars = String.make (30 - String.length myself) '*' in
   Printf.fprintf och "(* This file was generated by %s: do not edit %s*)\n\n" myself stars

let open_out preamble name =
   let path = [
      R.get_string "matita.rt_base_dir"; 
      R.get_string "xoa.output_dir"; 
      name
   ] in
   let name = List.fold_left F.concat "" path in 
   let och = open_out (name ^ ".ma") in
   copy_preamble preamble och; print_comment och;
   och

let out_include och s =
   Printf.fprintf och "include \"%s\".\n\n" s