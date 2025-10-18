N = int(input())
L = input()[0:N]
m = {"]": "[", "}": "{", ")": "("}


def go():
    stk: list[str] = []
    for i, c in enumerate(L):
        if c == " ":
            continue
        if c in "{([":
            stk.append(c)
        if c in "})]":
            if not stk:
                print(f"{c} {i}")
                return
            x = stk.pop()
            if not x == m[c]:
                print(f"{c} {i}")
                return
    print("ok so far")


go()
