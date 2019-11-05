# Chapter 2 Exercises: The simply-typed lambda calculus λ-st

## Exercise 8

    τ ::= ...
        | (* τ τ)

    e ::= ...
        | (e , e)
        | (pr₁ e)
        | (pr₂ e)

    v ::= ...
        | (v , v)

    E ::= ...
        | (E , e)
        | (v , E)
        | (pr₁ E)
        | (pr₂ E)

    Additional reduction rules:

    E[(pr₁ (v₁ , v₂))] ⟶ E[v₁]
    E[(pr₂ (v₁ , v₂))] ⟶ E[v₂]

    Additional typing rules:

    Γ ⊢ e₁ : τ₁
    Γ ⊢ e₂ : τ₂
    --------------------------[,]
    Γ ⊢ (e₁ , e₂) : (* τ₁ τ₂)

    Γ ⊢ e : (* τ₁ τ₂)
    ------------------[pr₁]
    Γ ⊢ (pr₁ e) : τ₁

    Γ ⊢ e : (* τ₁ τ₂)
    ------------------[pr₂]
    Γ ⊢ (pr₂ e) : τ₂

## Exercise 9

    τ ::= ...
        | (+ τ τ)

    e ::= ...
        | (inl e)
        | (inr e)
        | (match e [x e] [x e])

    v ::= ...
        | (inl v)
        | (inr v)

    E ::= ...
        | (inl E)
        | (inr E)
        | (match E [x e] [x e])

    Additional reduction rules:

    E[(match (inl v) [x e₁] [y e₂])] ⟶ E[e₁[x:=v]]
    E[(match (inr v) [x e₁] [y e₂])] ⟶ E[e₂[y:=v]]

    Additional typing rules:

    Γ ⊢ e : τ
    -----------------------[inl]
    Γ ⊢ (inl e) : (+ τ τ′)

    Γ ⊢ e : τ
    -----------------------[inr]
    Γ ⊢ (inr e) : (+ τ′ τ)

    Γ       ⊢ e  : (+ τ₁ τ₂)
    Γ, x:τ₁ ⊢ e₁ : τ
    Γ, y:τ₂ ⊢ e₂ : τ
    --------------------------------[match]
    Γ ⊢ (match e [x e₁] [y e₂]) : τ

## Exercise 11

`mult = (λ n nat (λ m nat (rec n [0] [x y (add m y)])))`

## Exercise 12

`fac = (λ n nat (rec n [1] [x y (mult (succ x) y)]))`

## Exercise 13

`/2 = (λ n nat (rec n [0] [x y (sub x y)]))`
`sub = ...`

## Exercise 19

`add = (fix r (→ nat nat nat) (λ n nat (λ m nat (if0 n m [x (s (r x))]))))`
