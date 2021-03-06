#!/usr/bin/python3.1

def chipsize(wat):
    if wat < 40:
        res = "small register"
    elif wat < 50:
        res = "1005 or larger"
    elif wat < 80:
        res = "1608 or larger"
    elif wat < 100:
        res = "2012 or larger"
    elif wat < 200:
        res = "3216 or larger"
    elif wat < 400:
        res = "5025 or larger"
    elif wat < 800:
        res = "6432 or larger"
    else:
        res = "large register"
    return res

print("     R1   PH(Vf)")
print("VCC--W--+-|>|-+--GND")
print("        |     |")
print("        +--W--+")
print("           R2")
print()

print("Input voltage VCC[V]",end=":")
vcc = float(input())
#print("VCC is ", vcc, "[V]")

print("Input voltage Vf[V]",end=":")
vf = float(input())
#print("Vf is ", vf, "[V]")

print("Input current Iph[mA]",end=":")
iph = float(input()) / 1000
#print("Iph is ", iph, "[A]")

print("Input current Ir2[mA]",end=":")
ir2 = float(input()) / 1000
#print("Ir2 is ", ir2, "[A]")

r1 = (vcc-vf) / (iph+ir2)
r2 = vf / ir2
w1 = (vcc-vf) * (iph+ir2) * 1000
w2 = vf * ir2 * 1000

print("Registance \033[32mR1\033[0m is \033[32m{0:.3f}[ohm]\033[0m".format(r1))
print("   Wattage is \033[32m{0:.3f}[mW]\033[0m".format(w1))
print("   Recomend\033[32m", chipsize(w1),"\033[0m")
print("Registance \033[33mR2\033[0m is \033[33m{0:.3f}[ohm]\033[0m".format(r2))
print("   Wattage is \033[33m{0:.3f}[mW]\033[0m".format(w2))
print("   Recomend\033[33m", chipsize(w2),"\033[0m")
