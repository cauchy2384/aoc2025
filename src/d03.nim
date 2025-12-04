import std/[sequtils, strutils, math, sugar]

proc maxJoltage(s: string, digits: int): int64 =
    var stack: seq[char] = @[]
    let toRemove = s.len - digits
    var removed = 0

    for c in s:
        while stack.len > 0 and removed < toRemove and stack[^1] < c:
            discard stack.pop()
            inc removed

        stack.add(c)

    while stack.len > digits:
        discard stack.pop()

    result = parseInt(stack.join(""))

proc solution*(filename: string, digits: int = 2): int64 =
    toSeq(lines(filename))
        .filter((s: string) => s.len != 0)
        .map((s: string) => maxJoltage(s, digits))
        .sum()
