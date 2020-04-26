library(psychTestR)
library(shiny)

#admin business
options <- test_options("Jazz Demo", admin_password = "rutabaga", researcher_email = "hmerseal@psu.edu")

save_time_started <- code_block(fun = function(state, ...) {
  set_global(key = "time.started",
             value = Sys.time(),
             state = state)
})

#demographic and musicianship questions  
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
  elt_save_results_to_disk(complete = TRUE)
  )

#If "no" instruments, skip through the next 2 blocks (n = number of questions)
branch <- code_block(function(state, ...) {
  if (answer(state) == "No") {
    skip_n_pages(state, 16)
  }
})

#instrument and training questions
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
practice <- join(
  text_input_page("play.11",
                  "Approximately how many hours a week did you spend playing music before the age of 11?
                  This includes hours spent practicing and hours spent performing.",
                  one_line = TRUE, save_answer = TRUE),
  text_input_page("improv.11",
                  "Approximately how many hours a week did you spend improvising before the age of 11?",
                  one_line = TRUE, save_answer = TRUE),
  text_input_page("play.1217",
                  "Approximately how many hours a week did you spend playing music between the ages of 12 and 17?
                  This includes hours spent practicing and hours spent performing.",
                  one_line = TRUE, save_answer = TRUE),
  text_input_page("improv.1217",
                  "Approximately how many hours a week did you spend improvising between the ages of 12 and 17?",
                  one_line = TRUE, save_answer = TRUE),
  text_input_page("play.18",
                  "Approximately how many hours a week did you spend playing music after the age of 18?
                  This includes hours spent practicing and hours spent performing.",
                  one_line = TRUE, save_answer = TRUE),
  text_input_page("improv.18",
                  "Approximately how many hours a week did you spend improvising after the age of 18?",
                  one_line = TRUE, save_answer = TRUE),
  text_input_page("play.now",
                  "Approximately how many hours a week do you currently spend playing music?
                  This includes hours spent practicing and hours spent performing.",
                  one_line = TRUE, save_answer = TRUE),
  text_input_page("improv.now",
                  "Approximately how many hours a week do you currently spend improvising?",
                  one_line = TRUE, save_answer = TRUE)
)

#randomized presentation of WJD stims:
#generate trials

trials12 = 0 # how many of this type of trial so far
trials13 = 0
trials23 = 0
stimnums <- c() # matrix of stim numbers
for(i in 1:150) {
  # pick one type at random
  categories <- sample(c("12","13","23"),1)
  # pick new type if done too many of this type already
  while((categories == "12" & trials12 == 50) | (categories == "13" & trials13 == 50) | (categories == "23" & trials23 == 50)) {
    categories <- sample(c("12","13","23"),1)
  }
  
  # get stim numbers
  if (categories == "12") {
    stim1 = paste("1_",ceiling(runif(1,min=0,max=50)),sep="")
    stim2 = paste("2_",ceiling(runif(1,min=0,max=50)),sep="")
    trials12 = trials12 + 1
  } else if (categories == "13") {
    stim1 = paste("1_",ceiling(runif(1,min=0,max=50)),sep="")
    stim2 = paste("3_",ceiling(runif(1,min=0,max=50)),sep="")
    trials13 = trials13 + 1
  } else if (categories == "23") {
    stim1 = paste("2_",ceiling(runif(1,min=0,max=50)),sep="")
    stim2 = paste("3_",ceiling(runif(1,min=0,max=50)),sep="")
    trials23 = trials23 + 1
  }
  
  if (runif(1) > 0.5) { # swap order 50% of the time
    stimnums <- rbind(stimnums, c(stim1, stim2)) # add to matrix
  } else {
    stimnums <- rbind(stimnums, c(stim2, stim1))
  }
}

save_stims <- code_block(function(state, ...) {
  save_result(state, "stims", stimnums)
})

audio <- c()
for(i in 1:150) {
  audio <- join(audio,
    NAFC_page(label=paste("audio.",i),prompt=(shiny::HTML(paste(
        "<audio controls> <source src=\"https://raw.githubusercontent.com/hannah-merseal/friendly-engine/master/", stimnums[i,1], ".mp3\" type=\"audio/mpeg\"> </audio>",
        "<audio controls> <source src=\"https://raw.githubusercontent.com/hannah-merseal/friendly-engine/master/", stimnums[i,2], ".mp3\" type=\"audio/mpeg\"> </audio>",sep=""))),
              choices=c("first clip","second clip"),
              save_answer = TRUE)
  )
}
audio <- join(audio,elt_save_results_to_disk(complete = TRUE))


compute_time_taken <- code_block(function(state, ...) {
  time_taken <- Sys.time() - get_global("time_started", state)
  msg <- paste0("Time taken: ", format(time_taken, digits = 3))
  elt_save_results_to_disk(complete = TRUE)
})

#making the test
jazz.choice <- make_test(join(
  save_time_started,
  training,
  branch,
  instruments,
  practice,
  save_stims,
  audio,
  compute_time_taken,
  final_page("Thank you for participating!")),
  opt = options, custom_admin_panel = NULL)

shiny::runApp(jazz.choice)