(* CHURCH ENCODINGS USING GADT *)

type nat = Nat : (('a -> 'a) -> 'a -> 'a) -> nat
type bool = Bool : ('a  -> ('a -> 'a)) -> bool
type ('t1, 't2) cpair = CPair : (('t1 -> 't2 -> 'a) -> 'a) -> ('t1, 't2)   cpair

let c0 = Nat (fun f x -> x)
let c1 = Nat (fun f x -> f x)

let comp g f y = g (f y)

(* THE FOLLOWING WORKS *)
let succ (Nat n)
    = Nat (fun f -> comp f (n f))
(* BUT THIS DOESN'T *)
(*
let succ (Nat n)
    = Nat (fun (f : 'a -> 'a) -> comp f (n f))
*)

(* THE FOLLOWING DOES'T WORK AT ALL *)
(*
let add (Nat n) (Nat m)
    = (fun f -> comp (n f) (m f))
let mult (Nat n) (Nat m)
    = Nat (comp n m)
*)

(* THIS DOESN'T WORK EITHER *)
(*
let add (Nat n) (Nat m)
    = (fun (f : 'a -> 'a) -> comp (n f) (m f))
*)


(* CHURCH ENCODINGS USING FIRST-CLASS MODULES *)

module type CNat = sig val apply : ('a -> 'a) -> 'a -> 'a end
type cnat = (module CNat)

(* WHAT IS THE DIFFERENCE BETWEEN CNat and CNat2 DEFINED BELOW? *)
module type CNat2 = sig
    type 'a t
    val apply : ('a -> 'a) -> 'a -> 'a
end

(* THE FOLLOWING DOES NOT WORK *)
(*
let mCN f
    = (module struct let apply = f end : CNat)
*)

(* NEITHER DOES THIS *)
(*
let mCN (f : (('a -> 'a) -> 'a -> 'a))
    = (module struct let apply = f end : CNat)
*)

(* WHAT IN THE WORLD? *)
(*
let mCN (f : 'a. 'a -> 'a -> 'a -> 'a)
    = (module struct let apply = f end : CNat)
*)

let c0 = (module struct let apply = (fun f x -> x) end : CNat)
let c1 = (module struct let apply = (fun f x -> f x) end : CNat)

(* THE FOLLOWING TWO FUNCTIONS WORK *)
let succ (n : cnat) : cnat =
    let module N = (val n : CNat) in
    (module struct let apply =
        (fun f -> comp f (N.apply f))
    end : CNat)

let add (n : cnat) (m : cnat) : cnat =
    let module N = (val n : CNat) in
    let module M = (val m : CNat) in
    (module struct let apply =
        (fun f -> comp (N.apply f) (M.apply f))
        end : CNat)

(* BUT THIS DOESN'T *)
(*
let mult (n : cnat) (m : cnat) : cnat =
    let module N = (val n : CNat) in
    let module M = (val m : CNat) in
    (module struct let apply =
        comp N.apply M.apply
        end : CNat)
*)

(* WHEREAS THIS DOES *)
let mult (n : cnat) (m : cnat) : cnat =
    let module N = (val n : CNat) in
    let module M = (val m : CNat) in
    (module struct let apply =
        (fun f -> N.apply (M.apply f))
        end : CNat)

let exp (x : cnat) (y : cnat) : cnat =
    let module Y = (val y : CNat) in
    Y.apply (mult x) c1

(* UNIT TESTING *)

let nat_to_int (n : cnat) =
    let module N = (val n : CNat) in
    N.apply (fun x -> x + 1) 0
let rec int_to_Nat (n : int)
    = (if n = 0
        then c0
        else succ (int_to_Nat (n - 1)))

let fton = nat_to_int
let ntof = int_to_Nat

let test () =
    assert (nat_to_int (int_to_Nat 0) = 0);
    assert (nat_to_int (int_to_Nat 1) = 1);
    assert (nat_to_int (int_to_Nat 2) = 2);

    assert (fton (add (ntof 0) (ntof 0)) = 0);
    assert (fton (add (ntof 1) (ntof 2)) = 3);
    assert (fton (add (ntof 1) (ntof 2)) = 3);

    assert (fton (mult (ntof 0) (ntof 0)) = 0);
    assert (fton (mult (ntof 0) (ntof 1)) = 0);
    assert (fton (mult (ntof 2) (ntof 0)) = 0);
    assert (fton (mult (ntof 1) (ntof 1)) = 1);
    assert (fton (mult (ntof 2) (ntof 1)) = 2);
    assert (fton (mult (ntof 1) (ntof 3)) = 3);
    assert (fton (mult (ntof 4) (ntof 5)) = 20);

    assert (fton (exp (ntof 0) (ntof 0)) = 1); (* !!! *)
    assert (fton (exp (ntof 0) (ntof 1)) = 0);
    assert (fton (exp (ntof 2) (ntof 0)) = 1);
    assert (fton (exp (ntof 1) (ntof 1)) = 1);
    assert (fton (exp (ntof 2) (ntof 1)) = 2);
    assert (fton (exp (ntof 1) (ntof 3)) = 1);
    assert (fton (exp (ntof 2) (ntof 3)) = 8);
    assert (fton (exp (ntof 3) (ntof 2)) = 9);
    assert (fton (exp (ntof 4) (ntof 5)) = 1024)

let _ = test()
