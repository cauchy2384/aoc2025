import unittest, os

import d08

const
  FixtureDir = "fixtures" / "d08"

suite "Day 08":
    setup:
        let fixturePath = currentSourcePath.parentDir / FixtureDir

    test "part 1 example":
        check solution(fixturePath / "example.txt", 10) == 40

    test "part 1 input":
        check solution(fixturePath / "input.txt", 1000) == 90036

    test "part 2 example":
        check solution2(fixturePath / "example.txt") == 25272

    test "part 2 input":
        check solution2(fixturePath / "input.txt") == 6083499488
