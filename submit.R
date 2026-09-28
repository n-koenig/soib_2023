library(tidyverse)
library(glue)
library(tictoc)
# for parallel iterations
library(furrr)
library(parallel)

source("00_scripts/00_functions.R")


# Is the current run for a new major SoIB version (every 3-4 years), 
# or for an interannual update (every year between major versions)?
# testing git
interannual_update = FALSE


# PART 0 (paths) ----------------------------------------------------------

source("00_scripts/01_create_metadata.R")

# cur_mask <- "none"
# my_assignment <- 2:100 # CHANGE FOR YOUR SUBSET
# tic(glue("Species trends for full country (sims {min(my_assignment)}--{max(my_assignment)})"))
# source("00_scripts/run_species_trends.R")
# toc() # 102 hours
# rm(my_assignment)

tic.clearlog()
tic("Resolved trends & occupancy for all 42 masks")
# full-country takes 5 h 11 min; woodland 2 h 10 min; PA 3 h 30 min

print(glue("Activated future-walking using advanced Kenbunshoku Haki!"))

# start multiworker parallel session
# plan(multisession, workers = 25)

# analyses_metadata %>% 
#   pull(MASK) %>% 
  # future-walking over each mask
  # future_walk(.progress = TRUE, .options = furrr_options(seed = TRUE), ~ 
#   {
    # if (.x != "none") {
    #   return(NULL)
    # }
    # new environment for each parallel iteration
    cur_env <- new.env()
    assign("cur_mask", "none", envir = cur_env)
    assign("interannual_update", interannual_update, envir = cur_env)
    
    tic(glue("Resolved trends & occupancy for none"))
    source("00_scripts/resolve_trends_and_occupancy.R", local = cur_env)
    toc()
    
#   }

# end multiworker parallel session
# plan(sequential)

toc(log = TRUE, quiet = TRUE) 
tic.log()
