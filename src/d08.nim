import std/[sequtils, strutils, math, sugar, algorithm, tables]

type Point = object
    id: int64
    a: int64
    b: int64
    c: int64

method distance(p1: Point, p2: Point): int64 {.base.} =
    let x = abs(p1.a - p2.a)
    let y = abs(p1.b - p2.b)
    let z = abs(p1.c - p2.c)
    x*x + y*y + z*z

type Edge = object
    u: int64
    v: int64
    w: int64

type UF = ref object
    parent: seq[int64]

proc NewUF(n: int64): UF =
    var parent = newSeq[int64](n)
    for i in 0..<n:
        parent[i] = i
    UF(parent: parent)

proc find(uf: UF, x: int64): int64 =
    if uf.parent[x] != x:
        uf.parent[x] = find(uf, uf.parent[x])
    uf.parent[x]

proc union(uf: UF, x: int64, y: int64) =
    let px = find(uf, x)
    let py = find(uf, y)
    if px != py:
        uf.parent[px] = py

proc isConnected(uf: UF): bool =
    toSeq(0..uf.parent.len-1)
        .all(proc (i: int): bool =
            find(uf, i.int64) == find(uf, 0)
        )

proc solution*(filename: string, connections: int64): int64 =
    let ps = toSeq(lines(filename))
        .map((s: string) => s.split(","))
        .map((ss: seq[string]) => ss.map((s: string) => parseInt(s)))
        .map((xyz: seq[int]) => Point(a: xyz[0], b: xyz[1], c: xyz[2]))

    let points = ps.zip(toSeq(0..ps.len-1))
        .map(proc (t: (Point, int)): Point {.closure.} = Point(id: t[1], a: t[0].a, b: t[0].b, c: t[0].c))

    let edges = points.
        map(proc(p1: Point): seq[Edge] =
            points.map(proc(p2: Point): Edge =
                Edge(u: p1.id, v: p2.id, w: distance(p1, p2))
            )
            .filter((e: Edge) => e.u < e.v)
        )
        .concat()
        .sortedByIt(it.w)

    var uf = NewUF(ps.len)

    edges[0..<connections]
        .apply(proc (e: Edge) =
            union(uf, e.u, e.v)
        )

    var counts = initCountTable[int]()

    toSeq(0..ps.len-1)
        .apply(proc (i: int) =
            let j = find(uf, i)
            counts.inc(j)
        )

    toSeq(counts.pairs)
        .sortedByIt(-it[1])[0..<3]
        .map((t: (int, int)) => t[1])
        .foldl(a * b)

proc solution2*(filename: string): int64 =
    let ps = toSeq(lines(filename))
        .map((s: string) => s.split(","))
        .map((ss: seq[string]) => ss.map((s: string) => parseInt(s)))
        .map((xyz: seq[int]) => Point(a: xyz[0], b: xyz[1], c: xyz[2]))

    let points = ps.zip(toSeq(0..ps.len-1))
        .map(proc (t: (Point, int)): Point {.closure.} = Point(id: t[1], a: t[0].a, b: t[0].b, c: t[0].c))

    let edges = points.
        map(proc(p1: Point): seq[Edge] =
            points.map(proc(p2: Point): Edge =
                Edge(u: p1.id, v: p2.id, w: distance(p1, p2))
            )
            .filter((e: Edge) => e.u < e.v)
        )
        .concat()
        .sortedByIt(it.w)

    var uf = NewUF(ps.len)

    for e in edges:
        union(uf, e.u, e.v)

        if isConnected(uf):
            return points[e.u].a * points[e.v].a

    -1