
(*This is a test for the bindings of the interpolation capabilities of d3*)

open D3m

let rainbow =
  Interval.color (CSS.HSL (0, 80, 50)) (CSS.HSL (359, 80, 50))

let widths = Interval.string "50px" "120px"

let make size =
  Array.init size (fun i -> (float_of_int i) /. (float_of_int size))

let chart = select "body" >> append "div"

let _ =
  chart
    >> subnodes "div"
    >> data (make 7)
    >> enter >> append "div"
    >> style "width" (fun v _ -> widths v)
    >> style_cst "height" (Js.string "10px")
    >> style "background-color" (fun v _ -> rainbow v)


