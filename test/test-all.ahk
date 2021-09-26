SetBatchLines, -1
#SingleInstance, force
#NoTrayIcon
#Include %A_ScriptDir%\..\export.ahk

expect := new expect()

expect.group(".test")
expect.label("vars, arrays, objects")
expect.test("hello", "hello")
expect.test(["hello"], ["hello"])
expect.test({"key": "value"}, {"key": "value"})


expect.group(".equal")
expect.label("vars, arrays, objects")
expect.equal("hello", "hello")
expect.equal(["hello"], ["hello"])
expect.equal({"key": "value"}, {"key": "value"})


expect.group(".notEqual")
expect.label("vars, arrays, objects")
expect.notEqual("hello", "hello!")
expect.notEqual(["hello"], ["world"])
expect.notEqual({"key": "value"}, {"key": "differentValue"})


expect.group(".true")
expect.label("vars")
expect.true(true)
expect.true(1)
expect.label("expressions")
expect.true((1 == 1))
expect.true((1 != 0))
expect.label("Function")
expect.true(inStr("String", "s"))


expect.group(".false")
expect.label("vars")
expect.false(false)
expect.false(0)
expect.label("expressions")
expect.false((1 == 0))
expect.false((1 != 1))

expect.group(".undefined")
expect.label("detect undefined value")
expect.undefined("")
expect.undefined(undefinedVar)

expect.group("._buildReport")
; build 2nd case for output that won't tarnish main output
expect2 := new expect()
expect.label("output")
report := expect2._buildReport()
expect.false(!inStr(report, "0%"))
expect.false(!inStr(report, "0 tests"))
expect.false(!inStr(report, "failures"))


; wrap up
expect.final()
expect.fullReport()
expect.writeResultsToFile()
ExitApp
