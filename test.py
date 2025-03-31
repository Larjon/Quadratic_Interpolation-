def fixed_to_float(val, bits_frac):
    if val & (1 << 31):
        val = val - (1 << 32)
    return val / (2 ** bits_frac)

x2 = 0x1ffff
a  = 0xff55010c 
b  = 0xe0072446
c  = 0x0155fde7

a_f = fixed_to_float(a, 28)
b_f = fixed_to_float(b, 28)
c_f = fixed_to_float(c, 28)
x2_f = x2 / (2 ** 28)
x2_sq = x2_f * x2_f
y = a_f + b_f * x2_f + c_f * x2_sq
print(y)