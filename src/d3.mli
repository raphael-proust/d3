
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


(** This module does not provide type safety. It merely makes it possible to
  call the methods of the d3 and selection object. If you are looking for High
  level bindings, try the D3m module. *)


(**The class of objects having select methods*)
class type with_select =
object

  (**Selects a node associated to the given string. The argument can be a css
    class or a tag (["div"], ["p"], etc.).*)
  method select :
    Js.js_string Js.t
    -> selection Js.t Js.meth

  (**Selects the given node. Usefull for converting nodes to selections.*)
  method select_node :
    Dom.element Js.t
    -> selection Js.t Js.meth

  (**Selects all the nodes associated to the given string (either class or tag).
  *)
  method selectAll :
    Js.js_string Js.t
    -> selection Js.t Js.meth

  (**Selects all nodes in the given array. This is usefull to convert node
   arrays into selections.*)
  method selectAll_nodes :
    Dom.element Js.t Js.js_array Js.t
    -> selection Js.t Js.meth

end

(**A selection*)
and selection =
object


  (*SELECTION*)
  (**When used on a [selection] all the select methods apply to the subnodes
    (nodes that are deeper in the Dom tree) of each element of the selection.*)
  inherit with_select



  (*DATA*)

  (**Not that after using this method the data associated to the selection has
    type ['data]. This is not reflected in the [selection] type*)
  method data :
    'data Js.js_array Js.t
    -> selection Js.t Js.meth



  (*CHAIN*)

  (**The next set of method allow for method chaining*)

  (**TODO: undocummented in the d3 library. Qxxording to comments found in the
    examples, the enter method populates the selection with placeholder nodes,
    one for each data associated to the selection. For example (ommiting the JS
    conversion function for clarity), one may use
    [s##selectAll("div")##data([|1; 2|])##enter()] to obtain a selection of two
    div nodes.
  *)
  method enter : selection Js.t Js.meth

  (**Add a subnode to each node of the selection. The new nodes are created
    according to the tag given as argument. The selection then contains the
    appended nodes.*)
  method append :
    Js.js_string Js.t
    -> selection Js.t Js.meth

  (**Make a function call on the selection content.*)
  method call :
    (Dom.node Js.t Js.js_array Js.t -> unit) Js.callback
    -> selection Js.meth

  (**Make a call passing additional arguments to the function. This is not
    necessary as it is possible to wrap a preapplied function to give as
    argument.*)
  method call_moreArgs1 :
    (Dom.node Js.t Js.js_array Js.t -> 'a -> unit) Js.callback
    -> 'a
    -> selection Js.meth
  method call_moreArgs2 :
    (Dom.node Js.t Js.js_array Js.t -> 'a -> 'b -> unit) Js.callback
    -> 'a
    -> 'b
    -> selection Js.meth
  method call_moreArgs3 :
    (Dom.node Js.t Js.js_array Js.t -> 'a -> 'b -> 'c -> unit) Js.callback
    -> 'a
    -> 'b
    -> 'c
    -> selection Js.meth

  (**Make a function call on each associated datum of the selection. The given
    function is called with a datum and its index.*)
  method each :
    ('data Js.t -> int -> unit) Js.callback
    -> selection Js.t Js.meth

  (**[attr(a,v)] sets the value of HTML attribute [a] to [v] for every node in
    the selection. The type of [v] depends on the attributes [a] that is to be
    changed. Type safety is here broken again.*)
  method attr :
    Js.js_string Js.t
    -> 'a
    -> selection Js.t Js.meth

  (**To remove an attribute from all the nodes in the selection, give [Js.null]
    as a second argument to this method.*)
  method attr_remove :
    Js.js_string Js.t
    -> 'a Js.opt
    -> selection Js.t Js.meth

  (**[attr_dyn(a, f)] sets the attributes [a] on node n to the result of the
    evaluation of [f(d,i)] where d is the datum associated to n and [i] its
    index. The type safety remark of method [attr] applies too.*)
  method attr_dyn :
    Js.js_string Js.t
    -> ('data -> int -> 'a) Js.callback
    -> selection Js.t Js.meth

  (**Same as [attr] but with CSS style attribute*)
  method style :
    Js.js_string Js.t
    -> 'a
    -> selection Js.t Js.meth
  method style_remove :
    Js.js_string Js.t
    -> 'a Js.opt
    -> selection Js.t Js.meth
  method style_dyn :
    Js.js_string Js.t
    -> ('data -> int -> 'a) Js.callback
    -> selection Js.t Js.meth
  (*TODO: priority*)

  (**Same as [attr] and [style] but for JS property.*)
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

  (**Set the text content of all the nodes in the selection.*)
  method text        :
    Js.js_string Js.t
    -> selection Js.t Js.meth

  (**Remove all the text content of the selection by giving [Js.null] to this
    method.*)
  method text_remove :
    'a Js.opt
    -> selection Js.t Js.meth

  (**Sets the text content of every node in the selection by evaluation the
    given function in a fashion similar to [attr_dyn]'s.*)
  method text_dyn    :
    ('a -> int -> Js.js_string Js.t) Js.callback
    -> selection Js.t Js.meth

    (**Same as [text] but for html*)
  method html        :
    Js.js_string Js.t
    -> selection Js.t Js.meth
  method html_remove :
    'a Js.opt
    -> selection Js.t Js.meth
  method html_dyn    :
    (Dom.node Js.t -> Js.js_string Js.t) Js.callback
    -> selection Js.t Js.meth

  (**Set an event handler on each node in the selection. The first argument is
   * the event type, the second is the event handler.*)
  method on :
    Js.js_string Js.t
    -> (Dom_html.eventTarget, 'a) Dom_html.event_listener Js.t
    -> selection Js.t

  (**Unbind event handlers by passing [Js.null] as a second argument.*)
  method on_remove :
    Js.js_string Js.t
    -> 'a Js.opt
    -> selection Js.t



  (*UNDOCUMMENTED*)

(* TODO: find doc (read source?) and complete
  method filter
  method classed
  method insert
  method sort
  method remove
*)

  (*OTHER*)

  (**[empty()] is true if the selection is empty.*)
  method empty :
    bool Js.t Js.meth

  (**return the first node of the selection.*)
  method node :
    Dom.node Js.t Js.meth

  (**Gets the attribute value for the first node in the selection.*)
  method attr_get :
    Js.js_string Js.t
    -> 'a Js.meth

  method style_get :
    'a Js.meth

  method property_get :
    Js.js_string Js.t
    -> 'a Js.meth

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

  (**Do selection on the whole page.*)
  inherit with_select

(*   method transition : transition Js.t Js.meth *)

end



val d3 : d3 Js.t


