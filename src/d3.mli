
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


class type with_select =
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

end

and selection =
object


  (**SELECTION**)
  inherit with_select

  (**DATA**)

  method data :
    'a Js.js_array Js.t
    -> selection Js.t Js.meth

  (**CHAIN**)

  method enter : selection Js.t Js.meth

  method append :
    Js.js_string Js.t
    -> selection Js.t Js.meth

  method call :
    (Dom.node Js.t Js.js_array Js.t -> unit) Js.callback
    -> selection Js.meth

  method each :
    ('data Js.t -> int -> unit) Js.callback
    -> selection Js.t Js.meth

  method attr :
    Js.js_string Js.t
    -> Js.js_string Js.t
    -> selection Js.t Js.meth
  method attr_remove :
    Js.js_string Js.t
    -> Js.js_string Js.t Js.opt
    -> selection Js.t Js.meth
  method attr_dyn :
    Js.js_string Js.t
    -> ('data -> int -> Js.js_string Js.t) Js.callback
    -> selection Js.t Js.meth

  method style :
    Js.js_string Js.t
    -> Js.js_string Js.t
    -> selection Js.t Js.meth
  method style_remove :
    Js.js_string Js.t
    -> Js.js_string Js.t Js.opt
    -> selection Js.t Js.meth
  method style_dyn :
    Js.js_string Js.t
    -> ('data -> int -> Js.js_string Js.t) Js.callback
    -> selection Js.t Js.meth

  method property :
    Js.js_string Js.t
    -> Js.js_string Js.t
    -> selection Js.t Js.meth
  method property_remove :
    Js.js_string Js.t
    -> Js.js_string Js.t Js.opt
    -> selection Js.t Js.meth
  method property_dyn :
    Js.js_string Js.t
    -> ('a -> int -> Js.js_string Js.t) Js.callback
    -> selection Js.t Js.meth

  method text        :
    Js.js_string Js.t
    -> selection Js.t Js.meth
  method text_remove :
    'a Js.opt
    -> selection Js.t Js.meth
  method text_dyn    :
    ('a -> int -> Js.js_string Js.t) Js.callback
    -> selection Js.t Js.meth
  method html        :
    Js.js_string Js.t
    -> selection Js.t Js.meth
  method html_remove :
    'a Js.opt
    -> selection Js.t Js.meth
  method html_dyn    :
    (Dom.node Js.t -> Js.js_string Js.t) Js.callback
    -> selection Js.t Js.meth

  method on : (#Dom_html.event as 'a) Js.t
    -> (Dom_html.eventTarget, 'a) Dom_html.event_listener Js.t
    -> selection Js.t


    (**UNDOCUMMENTED**)

(* TODO: find doc (read source?) and complete
  method filter
  method classed
  method insert
  method sort
  method remove
*)

  (**OTHER**)

  method empty :
    bool Js.t Js.meth

  method node :
    Dom.node Js.t Js.meth

  method attr_get :
    Js.js_string Js.t -> Js.js_string Js.t Js.meth

  method style_get :
    Js.js_string Js.t Js.meth
  (*TODO: priority*)

  method property_get :
    Js.js_string Js.t
    -> Js.js_string Js.t Js.meth

  method text_get    :
    Js.js_string Js.t Js.meth
  method html_get    :
    Js.js_string Js.t Js.meth

  (*TODO idem
  method transition
  *)


end

class type transition =
object
end

class type d3 =
object

  inherit with_select
(*   method transition : transition Js.t Js.meth *)

end




val d3 : d3 Js.t


