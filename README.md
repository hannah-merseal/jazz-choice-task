# jazz-choice-task
Demo melody choice task using psychTestR, created for PSY 525 Reproducible Research Methods, Spring 2020

## Getting Started

psychTestR is a new package for creating behavioral experiment interfaces using Shiny, and is quite well-documented at <https://pmcharrison.github.io/psychTestR/>.

Features:

* Integrates data collection and analysis in R
* Allows for a clean workflow
* Modular testing approach (easy to read!)
* Can be deployed locally or online (important in 2020)
* Open source for open science!

## Abstract

I created this task for Penn State University's graduate course in ["Transparent, Open, and Reproducible Research Practices in the Social and Behavioral Sciences"](https://psu-psychology.github.io/psy-525-reproducible-research-2020/). The primary purpose of this project was to explore the functionality of the new [psychTestR](https://pmcharrison.github.io/psychTestR/) package, a tool for creating behavioral experiment interfaces using Shiny. From a reproducibility standpoint, psychTestR offers many exciting features, including the integration of data collection and analysis into an R-based workflow, utilization of the power of Shiny to create Web-compatible applications (which is particularly useful in 2020!), as well as open-access distributability and relative accessibility to R novices. 

The current project is a reconstruction of a dual-audio presentation task that I previously administered using Qualtrics. In this task, participants give preference ratings for short musical phrases from the [Weimar Jazz Database](https://jazzomat.hfm-weimar.de/dbformat/dboverview.html) presented side-by-side in random combinations. This is a continuation of our work exploring [the use of production biases in musical improvisation](https://psyarxiv.com/qdh32/), in which we predict that biases similar to those used in language production occur in improvisation (such as Easy First, a tendency to begin phrases with salient, accessible sequences and use incremental planning to build to sequences that are more complex). We predict that these production biases are implicitly learned over time, and frequent listeners of jazz develop preferences for the structures developed from using production biases. We also ask a battery of questions about prior musical experience and listening habits.

Why use this tool instead of Qualtrics? Data collection in Qualtrics was a particular challenge, with a "brute-force" custom JavaScripting approach required both to present the audio stimuli and pull metadata about the stimuli from the survey. In addition to this, the Qualtrics survey was not openly shareable and could not be easily adapted to other experimental paradigms. psychTestR seems to be more well-suited to presenting randomized audio stimuli, and has [already begun to be utilized in data collection within the music cognition community](https://pmcharrison.github.io/psychTestR/articles/a2-research-examples.html). My app is available [here](https://github.com/hannah-merseal/jazz-choice-task/blob/master/apps/jazz-choice.R), and presentations made to demonstrate my progression through exploring psychTestR are available [here](https://github.com/hannah-merseal/jazz-choice-task/tree/master/Presentation). 

In creating this task, I utilized several of psychTestR's pre-made pages to collect the survey information about listening habits and musical experience. The main task was created using a custom-built page that randomly selects pairs of audio stimuli from a separate Github repository. These links can be changed in order to implement this task with different audio stimuli. Overall, I found the structure of a psychTestR experiment ("pages" collected into "timelines" collected into "tests") to be very approachable and straightforward. With a little extra effort, the customizable nature of the basic page means that quite a wide range of tests can be created using this package. It is not optimized to collect reaction time data, [which is a general but well-documented problem with online data collection](https://www.frontiersin.org/articles/10.3389/fpsyg.2019.02883/full). However, the output for my trial-level data is very clean and optimized for quick integration into analysis in R. I am currently exploring methods of distributing this app online using Penn State hosting capabilities. 

### References
Armitage, J. & Eerola, T. (2020). Reaction time data in music cognition: Comparison of pilot data from lab, crowdsourced, and convenience web samples. Frontiers in Psychology, 10(2883). https://doi.org/10.3389/fpsyg.2019.02883

Beaty, R., Frieler, K., Norgaard, M., Merseal, H., MacDonald, M., & Weiss, D. (2020). Spontaneous melodic productions of expert musicians contain sequencing biases seen in language production. PsyArXiv. https://doi.org/10.31234/osf.io/qdh32

Harrison, Peter M. C. (2020). psychTestR: An R package for designing and conducting behavioural psychological experiments. PsyArXiv. https://doi.org/10.31234/osf.io/dyar7

Pfleiderer, M. (2017). Inside the Jazzomat: New perspectives for jazz research. Pfleiderer, M., Frieler, K., Abeßer, J., Zaddach, W.G., & Burkhart, B. eds. Schott Campus. https://jazzomat.hfm-weimar.de/dbformat/dboverview.html


