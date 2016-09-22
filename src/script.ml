#! /usr/bin/env ocamlscript

(*
 * This program is free software: you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public License
 * as published by the Free Software Foundation, either version 3 of
 * the License, or (at your option) any later version.
 *)
		
let _ =
  let filename = Sys.argv.(1) in
  let f = open_in filename in
  let new_file = ref [] in
  let add s =
    new_file := s :: !new_file in
  try
    while true do
      let s = input_line f in
      match s with
      | " * This program is free software: you can redistribute it and/or" ->
	 add " * This software is free software; you can redistribute it and/or"
      | " * modify it under the terms of the GNU Lesser General Public License" ->
	 add " * modify it under the terms of the GNU Lesser General Public License"
      | " * as published by the Free Software Foundation, either version 3 of" ->
	 add " * version 2.1, with the special exception on linking described in file"
      | " * the License, or (at your option) any later version." ->
	 add " * LICENSE."
      | _ ->
	 add s
    done
  with End_of_file ->
    close_in f;
    let f = open_out filename in
    let rec rev_loop = function
      | x::q -> (rev_loop q; Printf.fprintf f "%s\n" x)
      | [] -> () in
    rev_loop !new_file;
    close_out f
