type 'a Nat = (('a -> 'a) -> ('a -> 'a))
type 'a Bool = ('a -> ('a -> 'a))
(* type 'a Pair = ('t1 -> 't2 -> 'a) -> 'a This does not work !!! *)

val c0:'a Nat = fn f:('a -> 'a) => fn x:'a => x
val c1:'a Nat = fn f:('a -> 'a) => fn x:'a => f x

fun comp
     (g : ('b -> 'c))
     (f : ('a -> 'b))
     (y : 'a)
     = g (f y)

fun succ
     (n : 'a Nat)
     = (fn f:('a -> 'a) => comp f (n f))
     : 'a Nat
fun add (n : 'a Nat) (m : 'a Nat)
    = (fn f : ('a -> 'a) => comp (n f) (m f))
    : 'a Nat
fun mult (n : 'a Nat) (m : 'a Nat)
    = comp n m
    : 'a Nat
fun exp (x : 'a Nat) (y : ('a Nat) Nat)
    = (y (mult x) c1)
    : 'a Nat


fun is_zero (n : 'a Nat)
    = (fn x:'a => fn y:'a => (n (fn dummy => y) x))
    : 'a Bool

fun Nat_to_int (n: int Nat) = n (fn x => x + 1) 0
fun int_to_Nat (n : int)
    = (if n = 0
        then c0
        else succ (int_to_Nat (n - 1))) : 'a Nat



fun Bool_to_bool (b : bool Bool)
    = (b true false)

val fton = Nat_to_int
val ntof = int_to_Nat
val Btob = Bool_to_bool


(* Temporary testing via booleans *)
val t0 = Nat_to_int (int_to_Nat 0) = 0
val t1 = Nat_to_int (int_to_Nat 1) = 1
val t2 = Nat_to_int (int_to_Nat 2) = 2

val p00 = fton (add (ntof 0) (ntof 0)) = 0
val p12 = fton (add (ntof 1) (ntof 2)) = 3
val p21 = fton (add (ntof 1) (ntof 2)) = 3

val m00 = fton (mult (ntof 0) (ntof 0)) = 0
val m01 = fton (mult (ntof 0) (ntof 1)) = 0
val m20 = fton (mult (ntof 2) (ntof 0)) = 0
val m11 = fton (mult (ntof 1) (ntof 1)) = 1
val m21 = fton (mult (ntof 2) (ntof 1)) = 2
val m13 = fton (mult (ntof 1) (ntof 3)) = 3
val m45 = fton (mult (ntof 4) (ntof 5)) = 20

val e00 = fton (exp (ntof 0) (ntof 0)) = 1 (* !!! *)
val e01 = fton (exp (ntof 0) (ntof 1)) = 0
val e20 = fton (exp (ntof 2) (ntof 0)) = 1
val e11 = fton (exp (ntof 1) (ntof 1)) = 1
val e21 = fton (exp (ntof 2) (ntof 1)) = 2
val e13 = fton (exp (ntof 1) (ntof 3)) = 1
val e23 = fton (exp (ntof 2) (ntof 3)) = 8
val e32 = fton (exp (ntof 3) (ntof 2)) = 9
val e45 = fton (exp (ntof 4) (ntof 5)) = 1024

val z0 = Btob (is_zero (ntof 0)) = true
val z1 = Btob (is_zero (ntof 1)) = false
val z2 = Btob (is_zero (ntof 2)) = false
val z3 = Btob (is_zero (ntof 3)) = false
