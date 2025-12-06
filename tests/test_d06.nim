import unittest, os

import d06

const
  FixtureDir = "fixtures" / "d06"

suite "Day 06":
    setup:
        let fixturePath = currentSourcePath.parentDir / FixtureDir

    test "part 1 example":
        check solution(fixturePath / "example.txt") == 4277556

    test "part 1 input":
        check solution(fixturePath / "input.txt") == 4805473544166

    test "part 2 example":
        check solution(fixturePath / "example2.txt", true) == 3263827

    test "part 2 input":
        check solution(fixturePath / "input.txt", true) == 8907730960817
