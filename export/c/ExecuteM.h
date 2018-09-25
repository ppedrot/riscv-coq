// This C file was autogenerated from Coq
#include <stdbool.h>
#include <stdint.h>

void executeM(RiscvState s, InstructionM inst) {
    switch (inst.kind) {
        case K_Mul:
            t x = getRegister(rs1);
            t y = getRegister(rs2);
            setRegister(rd, mul(h0, x, y));
            break;
        case K_Mulh:
            t x = getRegister(rs1);
            t y = getRegister(rs2);
            setRegister(rd, highBits(h0, mul(regToZ_signed(h0, x), regToZ_signed(h0, y))));
            break;
        case K_Mulhsu:
            t x = getRegister(rs1);
            t y = getRegister(rs2);
            setRegister(rd, highBits(h0, mul(regToZ_signed(h0, x), regToZ_unsigned(h0, y))));
            break;
        case K_Mulhu:
            t x = getRegister(rs1);
            t y = getRegister(rs2);
            setRegister(rd, highBits(h0, mul(regToZ_unsigned(h0, x), regToZ_unsigned(h0, y))));
            break;
        case K_Div:
            t x = getRegister(rs1);
            t y = getRegister(rs2);
            t q = ((reg_eqb(h0, x, minSigned(h0)) && reg_eqb(h0, y, negate(h0, coq_ZToReg(h0, 0b1))))
                ? x
                : ((reg_eqb(h0, y, coq_ZToReg(h0, 0b0)))
                    ? negate(h0, coq_ZToReg(h0, 0b1))
                    : div(h0, x, y)));
            setRegister(rd, q);
            break;
        case K_Divu:
            t x = getRegister(rs1);
            t y = getRegister(rs2);
            t q = ((reg_eqb(h0, y, coq_ZToReg(h0, 0b0)))
                ? maxUnsigned(h0)
                : divu(h0, x, y));
            setRegister(rd, q);
            break;
        case K_Rem:
            t x = getRegister(rs1);
            t y = getRegister(rs2);
            t r = ((reg_eqb(h0, x, minSigned(h0)) && reg_eqb(h0, y, negate(h0, coq_ZToReg(h0, 0b1))))
                ? coq_ZToReg(h0, 0b0)
                : ((reg_eqb(h0, y, coq_ZToReg(h0, 0b0)))
                    ? x
                    : rem(h0, x, y)));
            setRegister(rd, r);
            break;
        case K_Remu:
            t x = getRegister(rs1);
            t y = getRegister(rs2);
            t r = ((reg_eqb(h0, y, coq_ZToReg(h0, 0b0)))
                ? x
                : remu(h0, x, y));
            setRegister(rd, r);
            break;
    }
}
