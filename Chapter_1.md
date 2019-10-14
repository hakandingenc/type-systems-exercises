# Chapter 1 Exercises: The let-zl language

## Exercise 1
```
e ::= ...
    | b
    | (and e e)
    | (or e e)
    | (not e)

b ::= true
    | false

v ::= ...
    | b

E ::= ...
    | (and E e)
    | (and v E)
    | (or E e)
    | (or v E)
    | (not E)

Additional reduction rules

E[(and b₁ b₂)] ⟶ E[b₁ ∧ b₂]
E[(or b₁ b₂)] ⟶ E[b₁ ∨ b₂]
E[(not b)] ⟶ E[¬b]
```
Note: The boolean metafunctions can be directly encoded into the reduction rules by having more rules.
## Exercise 2
Proof by induction on the structure of _v_:

Let _v_ be an arbitrary value. By the grammar, we have 3 cases:
1. Assume `v = z`. Then by definition `|v| = |z| = 0`.
2. Assume `v = nil`. Same as above.
3. Assume ` v = (cons v₁ v₂)`. Then by definition and the inductive hypothesis, `|v| = |(cons v₁ v₂)| = |v₁| + |v₂| = 0 + 0 = 0`. ∎

## Exercise 3
```
τ ::= ...
    | bool

-------------[bool]
Γ ⊢ b : bool

Γ ⊢ e₁ : bool
Γ ⊢ e₂ : bool
-------------------[and]
(and e₁ e₂) : bool

Γ ⊢ e₁ : bool
Γ ⊢ e₂ : bool
------------------[or]
(or e₁ e₂) : bool

Γ ⊢ e : bool
-------------------[not]
Γ ⊢ (not e) : bool
```

## Exercise 4
```
τ ::= int
    | list τ

Modified typing rules:

-----------------[nil]
Γ ⊢ nil : list τ

Γ ⊢ e₁ : τ
Γ ⊢ e₂ : list τ
--------------------------[cons]
Γ ⊢ (cons e₁ e₂) : list τ

Γ ⊢ e : list τ
----------------[car]
Γ ⊢ (car e) : τ

Γ ⊢ e : list τ
---------------------[cdr]
Γ ⊢ (cdr e) : list τ
```

## Exercise 5
##### Inversion lemma:

If `Γ ⊢ e : τ` then,
* ...
* If the term is a boolean `b` then `τ = bool`.
* If the term is `(and e₁ e₂)` then `τ = bool` and `Γ ⊢ e₁ : bool` and `Γ ⊢ e₂ : bool`.
* If the term is `(or e₁ e₂)` then same as above.
* If the term is `(not e)` then `τ = bool` and `Γ ⊢ e : bool`.

##### Replacement lemma:

If `• ⊢ E[e₁] : τ`, then there exists some type `τₑ` such that `• ⊢ e₁ : τₑ`. Furthermore, for any other term `e₂` such that `• ⊢ e₂ : τₑ`, it is the case that `• ⊢ E[e₂] : τ`.

**Proof.** By induction on the structure of `E`:
* ...
* If `E` is `(and E₁ e₂₂)`, then the only typing rule that applies is `[and]`, so by the inversion lemma `τ = bool`, and both `E₁[e₁]` and `e₂₂` have type `bool`. Applying the induction hypothesis on `E₁[e₁]`, we get that `e₁` has some type `τₑ`. Now letting `e₂` be any term of type `τₑ`, we get by the induction hypothesis that `E₁[e₂]` is of type `bool`, from which we conclude `E[e₂] = (and E₁ e₂₂)[e₂] = (and E₁[e₂] e₂₂)` by the typing rule `[and]`.
* If `E` is `(and v E)`, `(or E e)`, or `(or v E)`, we have the same proof as above.
* If `E` is `(not E₁)`, then we have the same proof as above except without the term `e₂₂`. ∎

##### Substitution lemma:
If `Γ, x:τₓ ⊢ e : τ` and `Γ ⊢ v : τₓ` then `Γ ⊢ e[x:=v] : τ`.

**Proof.** By induction on the typing derivation for `e`; by cases on the conclusion:
* ...
* `Γ, x:τₓ ⊢ b : bool`: Then `b[x:=v]` is `b`, and `Γ ⊢ b : bool`
* `Γ, x:τₓ ⊢ (and e₁ e₂) : bool`: Then we know that `Γ, x:τₓ ⊢ e₁ : bool` and `Γ, x:τₓ ⊢ e₂ : bool`. We get by the induction hypothesis that `Γ ⊢ e₁[x:=v] : bool` and `Γ ⊢ e₂[x:=v] : bool`. We are done by the rule `[and]` since `(and e₁[x:=v] e₂[x:=v]) = (and e₁ e₂)[x:=v]`
* The case for `or` is the same and the case for `not` is the same with only one subexpression.

#### Preservation lemma:
If `• ⊢ e₁ : τ` and `e₁ ⟶ e₂` then `• ⊢ e₂ : τ`.

**Proof.** By cases on the reduction relation:
* ...
* `E[e₁] ⟶ E[e₂]` where `e₁` is one of `(and e₁₁ e₁₂)`, `(or e₁₁ e₁₂)`, or `(not e₁₁)` so that `e₂` is the result of the appropriate metafunction: By the replacement lemma, `e₁` has some type, and by the inversion lemma that type must be `bool`. The result of the metafunction is also a boolean with type `bool`. Then by the replacement lemma, `• ⊢ E[e₂] : bool`. ∎

##### Canonical forms lemma:
If `v` has type `τ`, then:
* If `τ` is `int`, then `v` is an integer literal `z`.
* If `τ` is `bool`, then `v` is a boolean literal `b`.
* If `τ` is `list`, then either `v = nil` or `v = (cons v₁ v₂)` where `v₁` has type `int` and `v₂` has type `list`.

**Proof.** By induction on the typing derivation of `• ⊢ v : τ`:
* ...
* `• ⊢ b : bool`: Then `v` is a boolean literal.
* Other expressions that are of type `bool` do not admit value judgment. ∎

##### Context replacement lemma:
If `e₁ ⟶ e₂`, then `E[e₁] ⟶ E[e₂]`. If `e₁ ⟶ WRONG` then `E[e₁] ⟶ WRONG`.

**Proof.**
Same as without booleans.

#### Progress lemma:
If `• ⊢ e : τ` then term `e` either reduces or is a value.

**Proof.** By induction on the typing derivation; by cases on the conclusion:
* ...
* `• ⊢ (and e₁ e₂) : bool`: By inversion `• ⊢ e₁ : bool` and `• ⊢ e₂ : bool`. Then by the induction hypothesis, `e₁` either reduces or is a value, and same for `e₂`. Consider the following exhaustive cases analysis:
    * If `e₁ ⟶ e₁₁`, then `(and e₁ e₂) ⟶ (and e₁₁ e₂)` by context replacement.
    * If `e₁ ⟶ WRONG`, then `(and e₁ e₂) ⟶ WRONG` by context replacement.
    * If `e₁` is a value, and:
        * `e₂ ⟶ e₂₂`, then `(and e₁ e₂) ⟶ (and e₁ e₂₂)` by context replacement.
        * `e₂ ⟶ WRONG`, then `(and e₁ e₂) ⟶ WRONG` by context replacement.
        * `e₂` is a value, then by canonical forms both `e₁` and `e₂` are boolean literals so `(and e₁ e₂) ⟶ e₁ ∧ e₂`
* `• ⊢ (or e₁ e₂) : bool`: same as above.
* `• ⊢ (not e) : bool`: The same case analysis above on only `e` gives the desired result. ∎
