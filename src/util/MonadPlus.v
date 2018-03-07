Require Import riscv.util.Monad.

(* Monad which also supports failure (mzero) and choice (mplus), typically used to chose
   the first successful one *)
Class MonadPlus(M: Type -> Type){MM: Monad M} := mkMonadPlus {
  mzero: forall {A}, M A;
  mplus: forall {A}, M A -> M A -> M A;

  mzero_left: forall {A} (f: A -> M A), Bind mzero f = mzero;
  mzero_right: forall {A B} (v: M A), Bind v (fun (_: A) => @mzero B) = @mzero B;
  mplus_assoc: forall {A} (m1 m2 m3: M A), mplus m1 (mplus m2 m3) = mplus (mplus m1 m2) m3;
}.
