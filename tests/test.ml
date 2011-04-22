

(*This is based on the Bar chart tutorial at
http://mbostock.github.com/d3/tutorial/bar-1.html
*)

(*
let data = Js.array [|4; 8; 15; 16; 23; 42|]

let chart =
  D3.d3
    ##select(Js.string "body")
    ##append(Js.string "div")
    ##attr(Js.string "class", Js.string "chart")

let _ =
  chart
    ##selectAll(Js.string "div")
    ##data(data)
    ##enter()##append(Js.string "div")
    ##style_dyn(Js.string "width",
                Js.wrap_callback
                  (fun i _ -> Js.string (string_of_int (10 * i) ^ "px"))
               )
    ##text_dyn(Js.wrap_callback (fun i _ -> Js.string (string_of_int i)))
*)

open D3m

let data = [|4; 8; 15; 16; 23; 42|]

let chart =
  select "body"
    >> append "div"
    >> set_attr "class" (Constant (Js.string "chart"))

let _ =
  chart
    >> subnodes "div"
    >> D3m.data data
    >> enter >> append "div"
    >> set_style "width"
      (Dynamic (fun v _ -> Js.string (string_of_int (10 * v) ^ "px")))
    >> set_text (Dynamic (fun v _ -> string_of_int v))


