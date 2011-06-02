
(*This is based on the Bar chart tutorial at
http://mbostock.github.com/d3/tutorial/bar-1.html
*)



let data = [|4; 8; 15; 16; 23; 42|]


let chart =
  D3.d3
    ##select(Js.string "body")
    ##append(Js.string "div")
    ##attr(Js.string "class", Js.some (Js.string "chart"))

let x =
  D3.d3
    ##scale
    ##linear()
    ##domain(Js.array [|0.; 42.|])
    ##range(Js.array [|Js.string "0px"; Js.string "420px"|])

let _ =
  chart
    ##selectAll(Js.string "div")
    ##data(Js.array data)
    ##enter()##append(Js.string "div")
    ##style_dyn(Js.string "width", D3.Scale.to_fun x)
    ##text_dyn(Js.wrap_callback (fun v _ -> Js.some (Js.string (string_of_int v))))

