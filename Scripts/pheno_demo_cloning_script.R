##This script is for notes on how I got git to talk to Rstudio so we can work with github.
##following directions in https://happygitwithr.com/rstudio-git-github

##after downloading Git and making repo in GitHub, used the Git console on my computer to
##introduce myself to git.
##could have done this in R, and did try that too, but found confusing. 
##Cloning creates an Rproject, so making a different Rproject to do the "introduction" part
##results in two projects.  If you do the introduction in git shell, then the cloning in 
##Rstudio there is just one project. Seems eaiser.
##If wanting to use the R commands for introduction, here they are:
library(usethis)
##Introduce self to git. I think these are just labels.
use_git_config(user.name = "Nora Underwood", user.email = "nunderwood@bio.fsu.edu")
##not sure this is necessary but I did it.
usethis::git_default_branch_configure()
##make a PAT
usethis::create_github_token()
##clone repo from github; this step asks for the PAT
usethis::create_from_github("https://github.com/nounderwood/LTREB-Phenology-Demography-Project.git", destdir = "D:/LTREB/LTREB_Phenology_Demography")

##created clone of GitHub repo Pheno_Demo in D:/LTREB/LTREB_Phenology_Demography using Rstudio dialogue
##,following ch 12 of happygitwithR. This creates a new Rstudio project Pheno-Demo

##note that the FIRST time you can't use the dialogue because Git won't be an option, so first time
##use either the git console (chapter 11) or R (chapter 15)

##Created this script to keep track of what I did while setting up GitHub-RStudio
##connection, put in same place as cloned repo D:/LTREB/LTREB_Phenology_Demography












