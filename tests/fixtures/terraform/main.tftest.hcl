run "greeting" {
  command = plan

  variables {
    name = "fixture"
  }

  assert {
    condition     = output.greeting == "Hello, fixture!"
    error_message = "The greeting must use the supplied name."
  }
}
