
(*This is based on the Bar chart tutorial at
http://mbostock.github.com/d3/tutorial/bar-1.html
*)

open D3m

let mydata = [|4; 8; 15; 16; 23; 42|]

let chart =
<<<<<<< HEAD
  select (Selector.tag "body")
=======
  select "body"
>>>>>>> ed4bad9d535d872fcb82c9c667f3e783a45aa8bb
    >> append "div"
    >> attr_cst "class" (Js.string "chart")

let width_of_value v _ =
<<<<<<< HEAD
  Some (string_of_int (10 * v) ^ "px")
=======
  string_of_int (10 * v) ^ "px"
>>>>>>> ed4bad9d535d872fcb82c9c667f3e783a45aa8bb

let _ =
  chart
    >> subnodes "div"
    >> data mydata
    >> enter >> append "div"
    >> style "width" width_of_value
<<<<<<< HEAD
    >> text (fun v _ -> Some (string_of_int v))
=======
    >> text (fun v _ -> string_of_int v)
>>>>>>> ed4bad9d535d872fcb82c9c667f3e783a45aa8bb


