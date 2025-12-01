import unittest, os

import d01

const
  StartPosition = 50
  FixtureDir = "fixtures" / "d01"

suite "Day 01":
    setup:
        let fixturePath = currentSourcePath.parentDir / FixtureDir

    test "part 1 example":
        check solution(StartPosition, fixturePath / "example.txt") == 3

    test "part 1 input":
        check solution(StartPosition, fixturePath / "input.txt") == 997

    test "part 2 example":
        check solution2(StartPosition, fixturePath / "example.txt") == 6

    test "part 2 input":
        check solution2(StartPosition, fixturePath / "input.txt") == 5978
