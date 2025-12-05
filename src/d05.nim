import std/[sequtils, strutils, math, sugar, algorithm]

type Range = object
    a: int
    b: int

proc solution*(filename: string, skipProducts = false): int64 =
    var rangeLines: seq[string]
    var productLines: seq[string]

    var readRanges: bool = true
    toSeq(lines(filename))
        .apply(proc(s : string) =
            if s.len == 0:
                readRanges = false
            elif readRanges:
                rangeLines.add(s)
            else:
                productLines.add(s)
        )

    let ranges = rangeLines.
        map(proc(s : string): Range =
            let parts = s.split('-', maxsplit=1)
            let a = parseInt(parts[0])
            let b = parseInt(parts[1])
            Range(a: a, b: b)
        )

    if not skipProducts:
        let products = productLines.map((s: string) => parseInt(s))

        return products.map(proc(id: int): bool =
            ranges
                .any(proc(rng: Range): bool =
                    id >= rng.a and id <= rng.b
                )
        ).count(true)

    ranges
        .sortedByIt((it.a, it.b))
        .foldl(
            if a.len == 0:
                @[b]
            else:
                let last = a[^1]
                if last.b + 1 >= b.a:
                    a[0..^2] & @[Range(a: last.a, b: max(last.b, b.b))]
                else:
                    a & @[b]
            ,
            newSeq[Range]()
        )
        .map((it: Range) => it.b - it.a + 1)
        .sum()