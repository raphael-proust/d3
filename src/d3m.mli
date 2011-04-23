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


(**The type of a selection with bound data of type ['a].*)
type 'a t

(**A binder changes the data bound to a selection.*)
type ('a, 'b) binder = 'a t -> 'b t

(**A chain act on the seelction but not on the data.*)
type 'a chain = ('a, 'a) binder


(**Note that [(>>)]'s type is also equal to ['a selection -> 'a chain -> 'a
  selection].*)
val (>>) : 'a t -> ('a, 'b) binder -> 'b t


(**The type of a setter. A setter is used to set the the value of an attribute,
  a property or similar things.*)
type ('a, 'value) setter =
  (**Do not set, simply remove the attribute, property, whatever.*)
  | Remove
  (**Set the property, content, whatever to the given value.*)
  | Constant of 'value
  (**For each element in the selection, use associated data to
    evaluates the new value for the text content, attribute, whatever.*)
  | Dynamic of ('a -> int -> 'value)


val select     : string -> Js.Unsafe.any Js.opt t
val select_all : string -> Js.Unsafe.any Js.opt t

val selection_of_node  : Dom.node Js.t       -> Js.Unsafe.any Js.opt t
val selection_of_nodes : Dom.node Js.t array -> Js.Unsafe.any Js.opt t

(**Binders.*)

val data : 'a array -> ('b, 'a) binder


(**Selection expanders and filters. *)

val subnodes : string -> 'a chain
val append : string -> 'a chain

val enter : 'a chain


(**Setters*)

val set_attr : string -> ('a, 'value) setter -> 'a chain

val attr_rm  : string -> 'a chain
val attr_cst : string -> 'a -> 'b chain
val attr     : string -> ('a -> int -> 'b) -> 'a chain


val set_style : string -> ('a, 'value) setter -> 'a chain

val style_rm  : string -> 'a chain
val style_cst : string -> 'a -> 'b chain
val style     : string -> ('a -> int -> 'b) -> 'a chain


val set_text : ('a, string) setter -> 'a chain

val text_rm  : 'a chain
val text_cst : string -> 'b chain
val text     : ('a -> int -> string) -> 'a chain


module Interval :
sig

  type 'a t = float -> 'a

  val obj       : 'a Js.t           -> 'a Js.t           -> 'a Js.t t
  val string    : string            -> string            -> Js.js_string Js.t t
  val js_string : Js.js_string Js.t -> Js.js_string Js.t -> Js.js_string Js.t t
  val int       : int               -> int               -> int t
  val float     : float             -> float             -> float t

end

