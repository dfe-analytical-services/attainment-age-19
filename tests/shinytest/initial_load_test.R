app <- ShinyDriver$new("../../", loadTimeout = 6.e4)
app$snapshotInit("initial_load_test", screenshot = FALSE)
app$snapshot()

app$setInputs(navlistPanel="LA & FSM")
app$snapshot()
