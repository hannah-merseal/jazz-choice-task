library(psychTestR)
library(shiny)

options <- test_options("Jazz Demo", admin_password = "rutabaga", researcher_email = "hmerseal@psu.edu")
  
demographic <- join(
  one_button_page("Thanks for participating! First, you'll be entering some information about your musical background."),
  get_basic_demographics(intro = NULL, gender = TRUE, age = TRUE, occupation = FALSE, education = FALSE),
  text_input_page("formal.train", "How many years of formal musical training have you had? This includes music lessons, 
                  instrument lessons, and coursework.", one_line = TRUE, save_answer = TRUE),
  text_input_page("age.train", "How old were you when you started your musical training?", one_line = TRUE, save_answer = TRUE),
  text_input_page("improv.train", "How many years of formal improvisation training have you had?", one_line = TRUE, save_answer = TRUE),
  text_input_page("theory.train", "How many years of formal music theory training have you had?", one_line = TRUE, save_answer = TRUE),
  slider_page("music.listen", "How many hours a week do you spend listening to music?", 0, 100, 0, save_answer = TRUE), 
  final_page("Thank you for participating!")
  )

jazz.choice <- make_test(elts = demographic, opt = options, custom_admin_panel = NULL)
shiny::runApp(jazz.choice)