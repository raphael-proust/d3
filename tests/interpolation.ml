
(*This is a test for the bindings of the interpolation capabilities of d3*)

let rainbow =
  D3.d3##interpolateHsl(Js.string "hsl(0,80,50)", Js.string "hsl(359,80,50)")

let make size =
  Array.init size (fun i -> (float_of_int i) /. (float_of_int size))

open D3m

let chart = select "body" >> append "div"

let _ =
  chart
    >> subnodes "div"
    >> data (make 7)
    >> enter >> append "div"
    >> style_cst "width" (Js.string "50px")
    >> style_cst "height" (Js.string "10px")
    >> style "background-color" (fun v _ -> rainbow v)


