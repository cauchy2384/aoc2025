import std/[strutils, sequtils, math, sugar, options]

proc check(s: string, p: int): bool =
    if s.len mod p > 0: return false

    let sz = s.len div p

    toSeq(1..p-1)
        .allIt(s[0..sz-1] == s[sz*it..sz*(it+1)-1])

proc isInvalidID(id: int64, strict: bool): bool =
    let s = $id

    if not strict:
        return check(s, 2)

    toSeq(2..s.len)
        .anyIt(check(s, it))

proc solution*(filename: string, strict: bool): int64 =
    toSeq(lines(filename))
        .filter((s: string) => s.len != 0)
        .map(proc (s: string): int64 =
            s.split(',')
                .map((s: string) => s.split('-', maxsplit=1))
                .map(proc (s: seq[string]): (int64, int64) = (parseInt(s[0]), parseInt(s[1])))
                .map(proc (t: (int64, int64)): int64 =
                    let (a, b) = t
                    toSeq(a..b)
                        .filter((id: int64) => isInvalidID(id, strict))
                        .sum()
                )
                .sum()
        )
        .sum()
