import std/[sequtils, strutils, math, sugar, algorithm]

proc solution*(filename: string, isFun: bool = false): int64 =
    var splits: int64

    var mx = toSeq(lines(filename))
        .map(proc (s: string): seq[char] = @s)

    let m = mx.len
    let n = mx[0].len

    var ans: int64 = 0

    toSeq(1..m-1)
        .apply(proc (r: int) =
            toSeq(0..n-1)
                .apply(proc (c: int) =
                    if mx[r - 1][c] != '|' and mx[r - 1][c] != 'S':
                        return
                    if mx[r][c] == '.':
                        mx[r][c] = '|'
                        return
                    if mx[r][c] != '^':
                        return
                    ans += 1
                    if c > 0:
                        mx[r][c - 1] = '|'
                    if c < n - 1:
                        mx[r][c + 1] = '|'
                )
        )

    if not isFun:
        return ans

    var mx2 = mx
        .map(proc(row: seq[char]): seq[int64] =
            row.map(proc(ch: char): int64 =
                if ch == '^':
                    return -1
                return 0
            )
        )

    toSeq(0..n-1)
        .apply(proc (c: int) =
            if mx[^1][c] == '|':
                mx2[^1][c] = 1
        )

    toSeq(countdown(m-2, 0))
        .apply(proc (r: int) =
            toSeq(0..n-1)
                .apply(proc (c: int) =
                    if mx[r][c] != '|' and mx[r][c] != 'S':
                        return
                    if mx2[r+1][c] != -1:
                        mx2[r][c] += mx2[r+1][c]
                        return

                    if c > 0:
                        mx2[r][c] += mx2[r+1][c-1]
                    if c < n-1:
                        mx2[r][c] += mx2[r+1][c+1]
                )
        )

    mx2[0].sum()
