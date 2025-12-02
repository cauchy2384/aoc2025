import unittest, os

import d02

const
  FixtureDir = "fixtures" / "d02"

suite "Day 02":
    setup:
        let fixturePath = currentSourcePath.parentDir / FixtureDir

    test "part 1 example":
        check solution(fixturePath / "example.txt", false) == 1227775554

    test "part 1 input":
        check solution(fixturePath / "input.txt", false) == 19219508902

    test "part 2 example":
        check solution(fixturePath / "example.txt", true) == 4174379265

    test "part 2 input":
        check solution(fixturePath / "input.txt", true) == 27180728081
