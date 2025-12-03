import std/[strutils, sequtils]

const CircleSize = 100

proc solution*(start: int64, filename: string): int64 =
    var position = start

    return toSeq(lines(filename))
        .map(proc (s: string): int64 =
            let num = parseInt(s[1..^1])
            if s[0] == 'L': -num else: num
        )
        .map(proc (offset: int64): int64 =
            position = (position + offset + CircleSize) mod CircleSize
            position
        )
        .countIt(it == 0)

proc solution2*(start: int64, filename: string): int64 =
    var position = start

    return toSeq(lines(filename))
        .map(proc (s: string): int64 =
            let num = parseInt(s[1..^1])
            if s[0] == 'L': -num else: num
        )
        .map(proc (offset: int64): int64 =
            var rounds = abs(offset div CircleSize)
            let prev = position
            position = position + (offset mod CircleSize)
            if position <= 0 and prev != 0: inc(rounds)
            if position >= CircleSize: inc(rounds)
            position = (position + CircleSize) mod CircleSize
            rounds
        )
        .foldl(a + b, 0)
