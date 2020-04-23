library(shiny)
library(psychTestR)

make_test(list(
  text_input_page(
    label = "name", 
    prompt = "What's your name?", 
    validate = function(answer, ...) {
      if (answer == "")
        "Name cannot be left blank."
      else TRUE
    },
    on_complete = function(answer, state, ...) {
      set_global(key = "name", value = answer,
                 state = state)
    }),
  NAFC_page(
    label = "colour",
    prompt = "What's your favourite colour?",
    choices = c("Red", "Green", "Blue")),
  elt_save_results_to_disk(complete = TRUE),
  reactive_page(function(state, ...) {
    final_page(paste0("Thank you for participating, ", 
                      get_global("name", state),
                      "."))
  })))

