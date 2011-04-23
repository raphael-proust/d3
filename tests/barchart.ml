
(*This is based on the Bar chart tutorial at
http://mbostock.github.com/d3/tutorial/bar-1.html
*)

open D3m

let mydata = [|4; 8; 15; 16; 23; 42|]

let chart =
  select "body"
    >> append "div"
    >> attr_cst "class" (Js.string "chart")

let _ =
  chart
    >> subnodes "div"
    >> data mydata
    >> enter >> append "div"
    >> style "width" (fun v _ -> Js.string (string_of_int (10 * v) ^ "px"))
    >> text (fun v _ -> string_of_int v)


