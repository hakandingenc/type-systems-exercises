# Chapter 3 Exercises: λ-sub : subtyping with records

## Exercise 23

`(→ Int Int) <: (→ Int Real)`
`(→ Real Real) <: (→ Int Real)`
`(→ Real Int) <: (→ Int Real)`
`(→ Real Int) <: (→ Real Real)`
`(→ Real Int) <: (→ Int Int)`

## Exercise 24

Induction on the structure of `τ`. Base case is `nat`. Inductive step involves applying the inductive hypothesis to the domain and codomain of an `→` type for both reflexivity and transitivity.
