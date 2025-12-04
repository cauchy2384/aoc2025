import std/[sequtils, math, sugar]

proc solution*(filename: string, remove: bool = false): int64 =
    var mx = toSeq(lines(filename))
        .filter((s: string) => s.len != 0)
        .map((s: string) => @s)
        .map(proc (chs: seq[char]): seq[int] =
            chs.map(proc (c: char): int =
                if c == '.':
                    return 0
                return 1
            )
        )

    let m = mx.len
    let n = mx[0].len
    let at = proc(i: int, j: int): int =
        if i < 0 or i >= m or j < 0 or j >= n:
            return 0
        return mx[i][j]

    let count = proc(r: int, c: int): int =
        toSeq(-1..1)
            .map(proc (dr: int): int =
                toSeq(-1..1)
                    .map(proc (dc: int): int =
                        if dr == 0 and dc == 0:
                            return 0
                        return at(r+dr, c+dc)
                    )
                    .sum()
                )
            .sum()

    let rolls = proc(): seq[array[2, int]] =
        var ans: seq[array[2, int]] = @[]
        toSeq(0..m-1)
            .apply(proc (r: int) =
                toSeq(0..n-1)
                    .apply(proc (c: int) =
                        if at(r, c) == 1 and count(r, c) < 4:
                            ans.add([r, c])
                    )
                )
        ans

    if not remove:
        return rolls().len

    var ans = 0

    while true:
        let papers = rolls()
        if papers.len == 0:
            break

        ans += papers.len

        papers.apply(proc (p: array[2, int]) =
            let r = p[0]
            let c = p[1]
            mx[r][c] = 0
        )

    return ans