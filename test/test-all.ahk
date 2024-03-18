#requires autohotkey v1.1

SetBatchLines, -1
#SingleInstance, force
#NoTrayIcon
#Include %A_ScriptDir%\..\export.ahk

expect := new expect()
failingExpect := new expect()

expect.group(".equal")
expect.label("vars, arrays, objects")
expect.equal("hello", "hello")
expect.equal(["hello"], ["hello"])
expect.equal({"key": "value"}, {"key": "value"})
expect.equal({"key": "value"}, {"key": "value"}, "with note")

expect.group(".test")
expect.label("vars, arrays, objects")
expect.test("hello", "hello")
expect.test(["hello"], ["hello"])
expect.test({"key": "value"}, {"key": "value"})
expect.test(true, true, "with note")


expect.group(".notEqual")
expect.label("vars, arrays, objects")
expect.notEqual("hello", "hello!")
expect.notEqual(["hello"], ["world"])
expect.notEqual({"key": "value"}, {"key": "differentValue"})
expect.notEqual({"key": "value"}, "a string")


expect.group(".true")
expect.label("vars")
expect.true(true)
expect.true(1)
expect.label("expressions")
expect.true((1 == 1))
expect.true((1 != 0))
expect.label("Function")
expect.true(inStr("String", "s"))
expect.true(inStr("String", "s"), "with note")


expect.group(".false")
expect.label("vars")
expect.false(false)
expect.false(0)
expect.label("expressions")
expect.false((1 == 0))
expect.false((1 != 1))
expect.false((1 != 1), "with note")


expect.group(".undefined")
expect.label("detect undefined value")
expect.undefined("")
expect.undefined(undefinedVar)
expect.undefined(undefinedVar, "with note")


expect.group("._buildReport")
; build 2nd case for output that won't tarnish main output
expect2 := new expect()
expect.label("output")
report := expect2._buildReport()

; expect no failires in string output
expect.false(!inStr(report, "0%"))
expect.false(!inStr(report, "0 tests"))
expect.false(!inStr(report, "failures"))

; expect more than 20 tests
expect.true((expect.testTotal > 20))

; expect zero failures in variables
expect.equal(expect.failTotal, 0)
expect.group("Failing tests")
expect.label(".test")
expect.false(failingExpect.test(1, 2))

expect.label(".equal")
expect.false(failingExpect.equal(1, 2))

expect.label(".notEqual")
expect.false(failingExpect.notEqual(1, 1))

expect.label(".report")
expect.true((0 < inStr(failingExpect.report(), "0%")))

; wrap up
expect.report()
expect.writeResultsToFile()
expect.fullReport()
exitapp
