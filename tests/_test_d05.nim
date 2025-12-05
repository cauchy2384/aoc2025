import unittest, os

import d05

const
  FixtureDir = "fixtures" / "d05"

suite "Day 05":
    setup:
        let fixturePath = currentSourcePath.parentDir / FixtureDir

    test "part 1 example":
        check solution(fixturePath / "example.txt") == 3

    test "part 1 input":
        check solution(fixturePath / "input.txt") == 782

    test "part 2 example":
        check solution(fixturePath / "example.txt", true) == 14

    test "part 2 input":
        check solution(fixturePath / "input.txt", true) == 353863745078671
