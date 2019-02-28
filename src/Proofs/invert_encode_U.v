Require Import Coq.ZArith.BinInt.
Require Import riscv.Encode.
Require Import riscv.Utility.ZBitOps.
Require Import riscv.Utility.prove_Zeq_bitwise.

Lemma invert_encode_U: forall {opcode rd imm20},
  verify_U opcode rd imm20 ->
  forall inst,
  encode_U opcode rd imm20 = inst ->
  opcode = bitSlice inst 0 7 /\
  rd = bitSlice inst 7 12 /\
  imm20 = signExtend 32 (Z.shiftl (bitSlice inst 12 32) 12).
Proof. intros. unfold encode_U, verify_U in *. prove_Zeq_bitwise. Qed.
