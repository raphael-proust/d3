(*
js_of_ocaml bindings for the d3 library
Copyright (C) 2011 Raphaël Proust

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, with linking exception;
either version 2.1 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*) 
(**This module provides a functional, type safe (when possible) interface to the
  d3 library. It is not complete (yet). *)


(*TODO: constants, inlining*)

(**The type of a selection with associated data of type ['data].*)
type 'a t = D3.selection Js.t
type ('a, 'b) binder = 'a t -> 'b t
type 'a chain = ('a, 'a) binder

(*selection -> chain -> selection*)
let (>>) (s : D3.selection Js.t) c = c s


type ('data, 'value) setter =
  | Remove
  | Constant of 'value
  | Dynamic of ('data -> int -> 'value)


let select tag          = D3.d3##select(Js.string tag)
let selection_of_node n = D3.d3##select_node(n)

let select_all tag        = D3.d3##selectAll(Js.string tag)
let selection_of_nodes ns = D3.d3##selectAll_nodes(Js.array ns)


(*string -> chain*)
let subnodes tag (s : D3.selection Js.t) = s##selectAll(Js.string tag)

let append tag (s : D3.selection Js.t) = s##append(Js.string tag)

(*TODO: make type safe (dependent types!)*)
let data d (s : D3.selection Js.t) = s##data(Js.array d)

let enter (s : D3.selection Js.t) = s##enter()

let set_attr name setter (s : D3.selection Js.t) =
  match setter with
  | Remove     -> s##attr_remove(Js.string name, Js.null)
  | Constant v -> s##attr(Js.string name, v)
  | Dynamic f  -> s##attr_dyn(Js.string name, Js.wrap_callback f)

let attr name f (s: D3.selection Js.t) =
  s##attr_dyn(Js.string name, Js.wrap_callback f)

let attr_cst name v (s: D3.selection Js.t) =
  s##attr(Js.string name, v)

let attr_rm name (s: D3.selection Js.t) =
  s##attr_remove(Js.string name, Js.null)


let set_style name setter (s : D3.selection Js.t) =
  match setter with
  | Remove     -> s##style_remove(Js.string name, Js.null)
  | Constant v -> s##style(Js.string name, v)
  | Dynamic f  -> s##style_dyn(Js.string name, Js.wrap_callback f)

let style name f (s: D3.selection Js.t) =
  s##style_dyn(Js.string name, Js.wrap_callback f)

let style_cst name v (s: D3.selection Js.t) =
  s##style(Js.string name, v)

let style_rm name (s: D3.selection Js.t) =
  s##style_remove(Js.string name, Js.null)


let set_text setter (s : D3.selection Js.t) =
  match setter with
  | Remove     -> s##text_remove(Js.null)
  | Constant v -> s##text(Js.string v)
  | Dynamic f  -> s##text_dyn(Js.wrap_callback (fun d i -> Js.string (f d i)))

let text f (s: D3.selection Js.t) =
  s##text_dyn(Js.wrap_callback (fun v i -> Js.string (f v i)))

let text_cst v (s: D3.selection Js.t) =
  s##text(Js.string v)

let text_rm (s: D3.selection Js.t) =
  s##text_remove(Js.null)





