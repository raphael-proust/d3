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


class type selection =
object

  method select :
    Js.js_string Js.t
    -> selection Js.t Js.meth
  method select_node :
    Dom.element Js.t
    -> selection Js.t Js.meth

  method selectAll :
    Js.js_string Js.t
    -> selection Js.t Js.meth
  method selectAll_nodes :
    Dom.element Js.t Js.js_array Js.t
    -> selection Js.t Js.meth


(* TODO: find doc (read source?) and complete
  method filter
  method classed
  method insert
  method sort
*)

  method enter : selection Js.t Js.meth

  (*use this data*)
  method data :
    'a Js.js_array Js.t
    -> selection Js.t Js.meth

  (*true if the selection is empty*)
  method empty :
    bool Js.t Js.meth

  (*return the first node of the selection
   *behavior is unspecified if the selection is empty
   *)
  method node :
    Dom.node Js.t Js.meth

  (*append the element associated to the argument to each element of the
   *selection. If the argument is "p" it appends a paragraph.
   *)
  method append :
    Js.js_string Js.t
    -> selection Js.t Js.meth

  (*TODO: find doc
  method remove
   *)

  (*Call the parameter function on the whole selection presented as an array*)
  method call :
    (Dom.node Js.t Js.js_array Js.t -> unit) Js.callback
    -> selection Js.meth

  (*Iterate the paramter function over the elements of the selection*)
  method each :
    ('data Js.t -> int -> unit) Js.callback
    -> selection Js.t Js.meth

  (*set attribute for each element of the selection*)
  method attr :
    Js.js_string Js.t -> Js.js_string Js.t -> selection Js.t Js.meth
  method attr_get :
    Js.js_string Js.t -> Js.js_string Js.t Js.meth
  method attr_remove :
    Js.js_string Js.t -> 'a Js.opt -> selection Js.t Js.meth
  method attr_dyn :
    Js.js_string Js.t
    -> ('a -> int -> Js.js_string Js.t) Js.callback
    -> selection Js.t Js.meth

  (*set style attribute for each element of the selection*)
  method style :
    Js.js_string Js.t
    -> Js.js_string Js.t
    -> selection Js.t Js.meth
  method style_get :
    Js.js_string Js.t
    -> Js.js_string Js.t Js.meth
  method style_remove :
    Js.js_string Js.t
    -> 'a Js.opt
    -> selection Js.t Js.meth
  method style_dyn :
    Js.js_string Js.t
    -> ('a -> int -> Js.js_string Js.t) Js.callback
    -> selection Js.t Js.meth
  (*TODO: priority*)

  (*set property for each element of the selection*)
  method property :
    Js.js_string Js.t
    -> Js.js_string Js.t
    -> selection Js.t Js.meth
  method property_get :
    Js.js_string Js.t
    -> Js.js_string Js.t Js.meth
  method property_remove :
    Js.js_string Js.t
    -> 'a Js.opt
    -> selection Js.t Js.meth
  method property_dyn :
    Js.js_string Js.t
    -> ('a -> int -> Js.js_string Js.t) Js.callback
    -> selection Js.t Js.meth

  (*set the content of all the selected nodes*)
  method text        :
    Js.js_string Js.t
    -> selection Js.t Js.meth
  method text_get    :
    Js.js_string Js.t Js.meth
  method text_remove :
    'a Js.opt
    -> selection Js.t Js.meth
  method text_dyn    :
    ('a -> int -> Js.js_string Js.t) Js.callback
    -> selection Js.t Js.meth
  method html        :
    Js.js_string Js.t
    -> selection Js.t Js.meth
  method html_get    :
    Js.js_string Js.t Js.meth
  method html_remove :
    'a Js.opt
    -> selection Js.t Js.meth
  method html_dyn    :
    (Dom.node Js.t -> Js.js_string Js.t) Js.callback
    -> selection Js.t Js.meth

  (*events*)
  method on : (#Dom_html.event as 'a) Js.t
    -> (Dom_html.eventTarget, 'a) Dom_html.event_listener Js.t
    -> selection Js.t

    (*TODO idem
  method transition
  *)


end

class type transition =
object
end

class type d3 =
object

  method select :
    Js.js_string Js.t
    -> selection Js.t Js.meth
  method select_node :
    Dom.element Js.t
    -> selection Js.t Js.meth

  method selectAll :
    Js.js_string Js.t
    -> selection Js.t Js.meth
  method selectAll_nodes :
    Dom.element Js.t Js.js_array Js.t
    -> selection Js.t Js.meth

(*   method transition : transition Js.t Js.meth *)

end


val d3 : d3 Js.t


