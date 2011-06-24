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


module Selector = struct

  (*TODO: type tags and attributes*)

  type t = Js.js_string Js.t

  let from_string s = Js.string s

  let tag s         = from_string s
  let class_ c      = from_string ("." ^ c)
  let identifier i  = from_string ("#" ^ i)
  let attribute a v = from_string ("[" ^ a ^ " = " ^ v ^ "]")
(*   let containment *)

  (*TODO: check precedence, parentheses and all*)
  let and_ s1 s2 = s1##concat(s2)
  let or_  s1 s2 = s1##concat_2(Js.string ", ", s2)

end



(**The type of a selection with associated data of type ['data].*)
type 'a t = D3.selection Js.t
type ('a, 'b) binder = 'a t -> 'b t
type 'a chain = ('a, 'a) binder

(*selection -> chain -> selection*)
let (>>) (s : D3.selection Js.t) c = c s
let d3 = D3.d3


(*TODO: move to appropriate location*)
let opt_of_option = function
  | Some x -> Js.some x
  | None -> Js.null


type ('data, 'value) setter =
  | Remove
  | Constant of 'value
  | Dynamic of ('data -> int -> 'value option)


let select selector     = d3##select(selector)
let selection_of_node n = d3##select_node(n)

let select_all selector   = d3##selectAll(selector)
let selection_of_nodes ns = d3##selectAll_nodes(Js.array ns)


(*string -> chain*)
let subnodes tag (s : D3.selection Js.t) = s##selectAll(Js.string tag)

let append tag (s : D3.selection Js.t) = s##append(Js.string tag)

(*TODO: make type safe (dependent types?)*)
let data d (s : D3.selection Js.t) = s##data(Js.array d)

let enter (s : D3.selection Js.t) = s##enter()

let set_attr name setter (s : D3.selection Js.t) =
  match setter with
  | Remove     -> s##attr(Js.string name, Js.null)
  | Constant v -> s##attr(Js.string name, Js.some v)
  | Dynamic f  ->
    s##attr_dyn(
      Js.string name,
      Js.wrap_callback (fun d i -> opt_of_option (f d i))
    )

let attr name f (s: D3.selection Js.t) =
  s##attr_dyn(
    Js.string name,
    Js.wrap_callback (fun d i -> opt_of_option (f d i))
  )

let attr_cst name v (s: D3.selection Js.t) =
  s##attr(Js.string name, Js.some v)

let attr_rm name (s: D3.selection Js.t) =
  s##attr(Js.string name, Js.null)


let set_style name setter (s : D3.selection Js.t) =
  match setter with
  | Remove     -> s##style(Js.string name, Js.null)
  | Constant v -> s##style(Js.string name, Js.some v)
  | Dynamic f  ->
    s##style_dyn(
      Js.string name,
      Js.wrap_callback (fun d i -> opt_of_option (f d i))
    )

let style name f (s: D3.selection Js.t) =
  s##style_dyn(
    Js.string name,
    Js.wrap_callback (fun d i -> opt_of_option (f d i))
  )

let style_cst name v (s: D3.selection Js.t) =
  s##style(Js.string name, Js.some v)

let style_rm name (s: D3.selection Js.t) =
  s##style(Js.string name, Js.null)


let set_text setter (s : D3.selection Js.t) =
  match setter with
  | Remove     -> s##text(Js.null)
  | Constant v -> s##text(Js.some (Js.string v))
  | Dynamic f  ->
    s##text_dyn(
      Js.wrap_callback (fun d i -> match f d i with
        | None -> Js.null
        | Some s -> Js.some (Js.string s)
      )
    )

let text f (s: D3.selection Js.t) =
  s##text_dyn(
    Js.wrap_callback (fun d i -> match f d i with
      | None -> Js.null
      | Some s -> Js.some (Js.string s)
    )
  )

let text_cst v (s: D3.selection Js.t) =
  s##text(Js.some (Js.string v))

let text_rm (s: D3.selection Js.t) =
  s##text(Js.null)


module Interval =
struct

  type 'a t = float -> 'a

  let obj       x y = d3##interpolateObject(x, y)
  let string    x y = d3##interpolateString(Js.string x, Js.string y)
  let js_string x y = d3##interpolateString(x, y)
  let int       x y = d3##interpolateRound(x, y)
  let float     x y = d3##interpolateNumber_float(x, y)

  let color     x y =
    let open CSS in
    match (x, y) with

    (*HSL*)
    | (HSL _, HSL _)   ->
        (d3##interpolateHsl(color x, color y) :> float -> Js.js_string Js.t)
    | (HSLA _, HSLA _) ->
        let x = (color x :> Js.js_string Js.t)
        and y = (color y :> Js.js_string Js.t)
        in
        d3##interpolateString(x, y)

    (*HSL can't be mixed with anything else*)
    | (HSL _, _) | (_, HSL _) ->
        failwith "D3m.color argument error"

    (*RGB*)
    | (RGB _, RGB _)   ->
        (d3##interpolateRgb(color x, color y) :> float -> Js.js_string Js.t)
    | (RGBA _, RGBA _) ->
        let x = (color x :> Js.js_string Js.t)
        and y = (color y :> Js.js_string Js.t)
        in
        d3##interpolateString(x, y)

    (*Alpha can't be mixed with non-alpha*)
    | (RGBA _, _) | (_, RGBA _) | (HSLA _, _) | (_, HSLA _) ->
        failwith "D3m.color argument error"

    (*All that is left is RGB and named colors (that can be mixed).*)
    | _ ->
        (d3##interpolateRgb(color x, color y) :> float -> Js.js_string Js.t)

end

module Scale =
struct

  type ('a, 'b) t = ('a -> int -> 'b Js.opt) Js.callback

  let linear ?(clamp = false) ~x0 ~x1 ~y0 ~y1 () =
    let f =
      d3
        ##scale
        ##linear()
        ##domain(Js.array [|x0; x1|])
        ##range(Js.array [|y0; y1|])
        ##clamp(Js.bool clamp)
    in
    D3.Scale.to_fun f
  let linear_int ?(clamp = false) ~x0 ~x1 ~y0 ~y1 () =
    let f =
      d3
        ##scale
        ##linear_int()
        ##domain(Js.array [|x0; x1|])
        ##range(Js.array [|y0; y1|])
        ##clamp(Js.bool clamp)
    in
    D3.Scale.to_fun f

  let power ?(clamp = false) ~x0 ~x1 ~y0 ~y1 ~e () =
    let f =
      d3
        ##scale
        ##pow()
        ##domain(Js.array [|x0; x1|])
        ##range(Js.array [|y0; y1|])
        ##exponent(e)
        ##clamp(Js.bool clamp)
    in
    D3.Scale.to_fun f

  let logarithmic ?(clamp = false) ~x0 ~x1 ~y0 ~y1 () =
    let f =
      d3
        ##scale
        ##log()
        ##domain(Js.array [|x0; x1|])
        ##range(Js.array [|y0; y1|])
        ##clamp(Js.bool clamp)
    in
    D3.Scale.to_fun f

  let discretize ~x0 ~x1 ~range () =
    let f =
      d3
        ##scale
        ##quantize()
        ##domain(Js.array [|x0; x1|])
        ##range(Js.array range)
    in
    D3.Scale.to_fun f

  let biject ~domain ~range () =
    let f =
      d3
        ##scale
        ##ordinal()
        ##domain(Js.array domain)
        ##range(Js.array range)
    in
    D3.Scale.to_fun f

end

