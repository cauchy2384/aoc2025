import unittest, os

import d04

const
  FixtureDir = "fixtures" / "d04"

suite "Day 04":
    setup:
        let fixturePath = currentSourcePath.parentDir / FixtureDir

    test "part 1 example":
        check solution(fixturePath / "example.txt") == 13

    test "part 1 input":
        check solution(fixturePath / "input.txt") == 1474

    test "part 2 example":
        check solution(fixturePath / "example.txt", true) == 43

    test "part 2 input":
        check solution(fixturePath / "input.txt", true) == 8910
