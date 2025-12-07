import unittest, os

import d07

const
  FixtureDir = "fixtures" / "d07"

suite "Day 07":
    setup:
        let fixturePath = currentSourcePath.parentDir / FixtureDir

    test "part 1 example":
        check solution(fixturePath / "example.txt") == 21

    test "part 1 input":
        check solution(fixturePath / "input.txt") == 1613

    test "part 2 example":
        check solution(fixturePath / "example.txt", true) == 40

    test "part 2 input":
        check solution(fixturePath / "input.txt", true) == 48021610271997
