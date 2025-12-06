import std/[sequtils, strutils, math, sugar, algorithm]

proc solution*(filename: string, isFun: bool = false): int64 =
    if not isFun:
        let mx = toSeq(lines(filename))
            .map((s: string) => s.split())
            .map((ss: seq[string]) => ss.filter((s: string) => s.len > 0))
            .reversed

        let n = mx[0].len

        var ans = mx[1].map((s: string) => parseInt(s))

        for i in 2..mx.len-1:
            for j in 0..n-1:
                if mx[0][j] == "+":
                    ans[j] = ans[j] + parseInt(mx[i][j])
                else:
                    ans[j] = ans[j] * parseInt(mx[i][j])

        return ans.sum()

    let mx = toSeq(lines(filename))

    let n = mx[0].len
    let m = mx.len

    let vals = toSeq(0..n-1)
        .map(proc (c: int): seq[char] =
            toSeq(0..m-2)
                .map(proc (r: int): char = mx[r][c])
        )
        .map(proc (sq: seq[char]): string = sq.join(""))
        .map(proc(s: string): string = s.strip)
        .join(",")
        .split(",,")
        .map(proc(s: string): seq[string] = s.split(","))
        .map(proc(sq: seq[string]): seq[int64] =
            sq.map(proc(s: string): int64 = parseInt(s))
        )

    let ops = toSeq(mx[m-1].items)
        .filterIt(it != ' ')

    toSeq(0..ops.len-1)
        .map(proc(i: int): int64 =
            if ops[i] == '+':
                return vals[i].sum()
            else:
                return vals[i].foldl(a * b)
        )
        .sum()
