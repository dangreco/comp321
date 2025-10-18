R, G, B = map(int, input().split())

if R > G and R > B:
    print("raudur")
elif G > R and G > B:
    print("graenn")
elif B > R and B > G:
    print("blar")
elif R == G and R > B:
    print("gulur")
elif R == B and R > G:
    print("fjolubleikur")
elif G == B and G > R:
    print("blagraenn")
elif R == G == B == 0:
    print("svartur")
elif R == G == B == 255:
    print("hvitur")
elif R == G == B:
    print("grar")
else:
    print("othekkt")
