
(*This is a test for the bindings of the interpolation capabilities of d3*)

open D3m

let rainbow =
  Interval.color (CSS.HSL (0, 80, 50)) (CSS.HSL (359, 80, 50))

let widths = Interval.string "50px" "120px"

let make size =
  Array.init size (fun i -> (float_of_int i) /. (float_of_int size))

<<<<<<< HEAD
let chart = select (Selector.tag "body") >> append "div"
=======
let chart = select "body" >> append "div"
>>>>>>> ed4bad9d535d872fcb82c9c667f3e783a45aa8bb

let _ =
  chart
    >> subnodes "div"
    >> data (make 7)
    >> enter >> append "div"
<<<<<<< HEAD
    >> style "width" (fun v _ -> Some (widths v))
    >> style_cst "height" (Js.some (Js.string "10px"))
    >> style "background-color" (fun v _ -> Some (rainbow v))
=======
    >> style "width" (fun v _ -> widths v)
    >> style_cst "height" (Js.string "10px")
    >> style "background-color" (fun v _ -> rainbow v)
>>>>>>> ed4bad9d535d872fcb82c9c667f3e783a45aa8bb


