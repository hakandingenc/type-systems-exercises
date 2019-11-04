# Chapter 3 Exercises: λ-sub : subtyping with records

## Exercise 23

`(→ Int Int) <: (→ Int Real)`
`(→ Real Real) <: (→ Int Real)`
`(→ Real Int) <: (→ Int Real)`
`(→ Real Int) <: (→ Real Real)`
`(→ Real Int) <: (→ Int Int)`

## Exercise 24

##### Reflexivity

If `τ` is some type, then `τ <: τ`

**Proof.** By induction on the structure of `τ`:

- If `τ` is `nat`, the claim holds by the rule `[nat]`.
- If `τ` is `(τ₁ → τ₂)`, then the claim holds by the inductive hypotheses on `τ₁` and `τ₂` and the rule `[arr]`.
- If `τ` is `(Record [ℓ τ] ...)`, then we do induction on the number of the fields of `τ`. The base case is `(Record)` which holds by the rule `[rec-nil]`. The inductive step holds by the rule `rec-cons`, where `τₗ = τᵣ`.

##### Transitivity

If `τ₁, τ₂, τ₃` are types such that `τ₁ <: τ₂` and `τ₂ <: τ₃`, then `τ₁ <: τ₃`
**Proof.** By induction on the structure of `<:`:

- If the last inference rule in the proof `τ₁ <: τ₂` is `[nat]`, then the same must be true for `τ₂ <: τ₃`. Then `τ₁ <: τ₃` by the rule `[nat]`.
- If the last inference rule in the proof `τ₁ <: τ₂` is `[arr]`, then the same must be true for `τ₂ <: τ₃`. Then by induction on the both derivations, we conclude `τ₁ <: τ₃` from the rule `[arr]`.
- If the last inference rule in the proof `τ₁ <: τ₂` is `[rec-nil]`, then the same must be true for `τ₂ <: τ₃`. Then `τ₁ <: τ₃` by the rule `[rec-nil]`.
- If the last inference rule in the proof `τ₁ <: τ₂` is `[rec-cons]`, then the proof `τ₂ <: τ₃` can have `[rec-nil]` or `[rec-cons]`. If it is `[rec-nil]`, then `τ₁ <: τ₃` by the rule `[rec-nil]`. If it is `[rec-cons]`, ...
