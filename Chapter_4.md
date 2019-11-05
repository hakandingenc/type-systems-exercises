# Chapter 4 Exercises: The polymorphic lambda calculus λ-2

Note that we write `eₐ` to denote `(Ap e a)`. We use commas to denote nested `Ap`s.
We also write `(ap f x ...)` to denote curried application of `f` to `x ...`.

## Exercise 26

`comp = (∧ a (∧ b (∧ c (λ g (→ b c) (λ f (→ a b) (λ y a (ap g (ap f y))))))))`
`succ = (λ n Nat (∧ a (λ f (→ a a) (ap compₐ,ₐ,ₐ f (ap nₐ f)))))`

## Exercise 27

`add = (λ n Nat (λ m Nat (∧ a (λ f (→ a a) (ap compₐ,ₐ,ₐ (ap mₐ f) (ap nₐ f)))))`
`mult = (λ n Nat (λ m Nat (∧ a (ap compₐ,ₐ,ₐ mₐ nₐ)))`
`mult2 = (λ n Nat (λ m Nat (ap (ap (Ap y Nat) (add x)) c0))`
`exp = (λ x Nat (λ y Nat (ap (ap (Ap y Nat) (mult x)) c1)))`

## Exercise 28

See Exercise 32.

## Exercise 29

`not = (λ b Bool (∧ a (λ x a (λ y a (ap bₐ y x)))))`
`and = (λ u Bool (λ v Bool (∧ a (λ x a (λ y a (ap uₐ (ap vₐ x y) y))))))`
`or  = (λ u Bool (λ v Bool (∧ a (λ x a (λ y a (ap uₐ x (ap vₐ x y)))))))`

## Exercise 30

`zero? = (λ n Nat (∧ a (λ x a (λ y a (ap (ap nₐ (λ dummy a y)) x)))))`

## Exercise 31

`fst = (∧ τ₁ (∧ τ₂ (λ p (* τ₁ τ₂) ((ap (Ap p τ₁) (λ x τ₁ (λ y τ₂ x))))))`
`snd = (∧ τ₁ (∧ τ₂ (λ p (* τ₁ τ₂) ((ap (Ap p τ₂) (λ x τ₁ (λ y τ₂ y))))))`

## Exercise 32

    pred =

    (λ n Nat
        ((Ap fst Nat Nat)
         (ap
          (Ap n (* Nat Nat))
          (λ p (* Nat Nat)
            (pair ((Ap snd Nat Nat) p)
                  (succ ((Ap snd Nat Nat) p))))
          (pair 0 0))))
