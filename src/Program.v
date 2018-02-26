Require Import bbv.Word.
Require Import riscv.util.NameWithEq.
Require Import riscv.Utility.
Require Import Coq.ZArith.BinInt.

(* t will be instantiated with a signed type, u with an unsigned type.
   By default, all operations are on signed numbers. *)
Class Alu(t u: Set) := mkAlu {
  (* constants *)
  zero: t;
  one: t;

  (* arithmetic operations: *)
  add: t -> t -> t;
  sub: t -> t -> t;
  mul: t -> t -> t;
  div: t -> t -> t;
  rem: t -> t -> t;

  (* comparison operators: *)
  signed_less_than: t -> t -> bool;
  unsigned_less_than: u -> u -> bool;
  signed_eqb: t -> t -> bool;

  (* logical operations: *)
  shiftL: t -> Z -> t;
  signed_shiftR: t -> Z -> t; (* arithmetic shift *)
  unsigned_shiftR: u -> Z -> u; (* logic shift *)

  xor: t -> t -> t;
  or: t -> t -> t;
  and: t -> t -> t;

  (* conversion operations: *)
  signed: u -> t;
  unsigned: t -> u;
}.

Notation "a <|> b" := (or a b)  (at level 50, left associativity) : alu_scope.
Notation "a <&> b" := (and a b) (at level 40, left associativity) : alu_scope.
Notation "a + b"   := (add a b) (at level 50, left associativity) : alu_scope.
Notation "a - b"   := (sub a b) (at level 50, left associativity) : alu_scope.

Notation "a /= b" := (negb (signed_eqb a b))        (at level 70, no associativity) : alu_scope.
Notation "a == b" := (signed_eqb a b)               (at level 70, no associativity) : alu_scope.
Notation "a < b"  := (signed_less_than a b)         (at level 70, no associativity) : alu_scope.
Notation "a >= b" := (negb (signed_less_than a b))  (at level 70, no associativity) : alu_scope.

(* Even with different scopes for t and u, it's too tricky to deal with notation aliasing,
   because notation aliasing makes type class resolution less well. *)
Notation "a <u b"  := (unsigned_less_than a b)         (at level 70, no associativity) : alu_scope.
Notation "a >=u b" := (negb (unsigned_less_than a b))  (at level 70, no associativity) : alu_scope.


Section Shifts.

  Context {t u: Set}.
  Context {A: Alu t u}.
  Context {m: MachineWidth t}.
  Context {ic0: IntegralConversion Z t}.

  Definition slli(x: t)(shamt6: Z): t :=
    shiftL x (shiftBits (fromIntegral shamt6: t)).

  Definition srli(x: t)(shamt6: Z): u :=
    unsigned_shiftR ((unsigned x) : u) (shiftBits (fromIntegral shamt6 : t)).

  Definition srai(x: t)(shamt6: Z): t :=
    signed_shiftR x (shiftBits (fromIntegral shamt6 : t)).

  Definition sll(x y: t): t := shiftL x (shiftBits y).

  Definition srl(x y: t): u := unsigned_shiftR (unsigned x) (shiftBits y).

  Definition sra(x y: t): t := signed_shiftR x (shiftBits y).

End Shifts.

Section Riscv.

  Context {Name: NameWithEq}. (* register name *)
  Notation Register := (@name Name).

  Class RiscvState(M: Type -> Type){t u: Set}{A: Alu t u} := mkRiscvState {
    getRegister: Register -> M t;
    setRegister{s: Set}{c: IntegralConversion s t}: Register -> s -> M unit;

    loadByte: t -> M (word 8);
    loadHalf: t -> M (word 16);
    loadWord: t -> M (word 32);
    loadDouble: t -> M (word 64);

    storeByte: t -> (word 8) -> M unit;
    storeHalf: t -> (word 16) -> M unit;
    storeWord: t -> (word 32) -> M unit;
    storeDouble: t -> (word 64) -> M unit;

    getPC: M t;
    setPC: t -> M unit;

    step: M unit; (* updates PC *)
  }.

End Riscv.
