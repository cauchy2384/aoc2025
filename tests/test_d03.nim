import unittest, os

import d03

const
  FixtureDir = "fixtures" / "d03"

suite "Day 03":
    setup:
        let fixturePath = currentSourcePath.parentDir / FixtureDir

    test "part 1 example":
        check solution(fixturePath / "example.txt") == 357

    test "part 1 input":
        check solution(fixturePath / "input.txt") == 17074

    test "part 2 example":
        check solution(fixturePath / "example.txt", 12) == 3121910778619

    test "part 2 input":
        check solution(fixturePath / "input.txt", 12) == 169512729575727
