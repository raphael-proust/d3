

(*This is based on the Bar chart tutorial at
http://mbostock.github.com/d3/tutorial/bar-1.html
*)

let chart =
  D3.d3
    ##select(Js.string "body")
    ##append(Js.string "div")
    ##attr(Js.string "class", Js.string "chart")

let data =
  Js.array [|10; 3; 42; 100; 1|]

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
