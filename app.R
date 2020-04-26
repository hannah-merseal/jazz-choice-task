library(psychTestR)
library(shiny)

options <- test_options("Jazz Demo", admin_password = "rutabaga", researcher_email = "hmerseal@psu.edu")

save_time_started <- code_block(fun = function(state, ...) {
  set_global(key = "time.started",
             value = Sys.time(),
             state = state)
})
  
training <- join(
  one_button_page("Thanks for participating! First, you'll be entering some information about your musical background."),
  get_basic_demographics(intro = NULL, gender = TRUE, age = TRUE, occupation = FALSE, education = FALSE),
  text_input_page("formal.train", 
                  "How many years of formal musical training have you had? This includes music lessons, instrument lessons, and coursework.", 
                  one_line = TRUE, save_answer = TRUE),
  text_input_page("age.train", 
                  "How old were you when you started your musical training?", 
                  one_line = TRUE, save_answer = TRUE),
  text_input_page("improv.train", 
                  "How many years of formal improvisation training have you had?", 
                  one_line = TRUE, save_answer = TRUE),
  text_input_page("theory.train", 
                  "How many years of formal music theory training have you had?", 
                  one_line = TRUE, save_answer = TRUE),
  slider_page("music.listen", 
              "How many hours a week do you spend listening to music?",
              0, 100, 0, save_answer = TRUE),
  slider_page("jazz.listen", 
              "How many hours a week do you spend listening to jazz?",
              0, 100, 0, save_answer = TRUE),
  NAFC_page("instrumentYN",
            "Do you play any instruments?",
            c("Yes", "No"), save_answer = TRUE, on_complete = NULL),
  #I want to make this ^ so if they pick no the next 2 blocks don't show up
  elt_save_results_to_disk(complete = TRUE)
  )

instruments <- join(
  text_input_page("primary.instrument",
                  "What is your primary instrument?",
                  one_line = TRUE, save_answer = TRUE),
  slider_page("primary.proficiency",
              "What is your proficiency on your primary instrument? 
Please rate on a scale of 1-7, with 1 being 'not proficient' and 7 being 'extremely proficient'.",
              1, 7, 1, save_answer = TRUE),
  slider_page("primary.years",
              "How many years have you spent playing your primary instrument?",
              0, 100, 0, save_answer = TRUE),
  slider_page("primary.training",
              "How many years of formal training do you have on your primary instrument?",
              0, 100, 0, save_answer = TRUE),
  text_input_page("other.instruments",
                  "Please list any other instruments you play, and the number of years spent playing each.",
                  one_line = TRUE, save_answer = TRUE),
  slider_page("improv.proficiency",
              "What is your proficiency at improvising? 
Please rate on a scale of 1-7, with 1 being 'not proficient' and 7 being 'extremely proficient'.",
              1, 7, 1, save_answer = TRUE),
  elt_save_results_to_disk(complete = TRUE)
)

# Practice questions go here
practice <- join()
# Audio questions go here

compute_time_taken <- code_block(function(state, ...) {
  time_taken <- Sys.time() - get_global("time_started", state)
  msg <- paste0("Time taken: ", format(time_taken, digits = 3))
  elt_save_results_to_disk(complete = TRUE)
})

jazz.choice <- make_test(join(
  save_time_started,
  training,
  compute_time_taken,
  final_page("Thank you for participating!")),
  opt = options, custom_admin_panel = NULL)

shiny::runApp(jazz.choice)