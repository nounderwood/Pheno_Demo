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
## reset PAT (paste in a new one generated when git says the old one expired)
gitcreds::gitcreds_set()




##clone repo from github; this step asks for the PAT
usethis::create_from_github("https://github.com/nounderwood/LTREB-Phenology-Demography-Project.git", destdir = "D:/LTREB/LTREB_Phenology_Demography")

##created clone of GitHub repo Pheno_Demo in D:/LTREB/LTREB_Phenology_Demography using Rstudio dialogue
##,following ch 12 of happygitwithR. This creates a new Rstudio project Pheno-Demo

##note that the FIRST time you can't use the dialogue because Git won't be an option, so first time
##use either the git console (chapter 11) or R (chapter 15)

##Created this script to keep track of what I did while setting up GitHub-RStudio
##connection, put in same place as cloned repo D:/LTREB/LTREB_Phenology_Demography

##code to import the first sheets in all the DENU files in raw data folder
setwd(D:LTREB/LTREB_Phenology_Demography/Pheno_Demo)
etc. (to be finished later)


##importing data; got this code by clicking environment and then import in upper right of Rstudio
library(readxl)
DENU_2024_demography <- read_excel("Raw Data/DENU_2024_demography.xlsx", 
                                   sheet = "2024 demography")

DENU_2024_phenology <- read_excel("Raw Data/DENU_2024_demography.xlsx", 
                                   sheet = "2024 phenology")

##making variables into correct formats as needed
DENU_2024_phenology$num.buds <- as.numeric(DENU_2024_phenology$num.buds)
DENU_2024_phenology$flower.open <- as.numeric(DENU_2024_phenology$flower.open)
DENU_2024_phenology$flower.spent <- as.numeric(DENU_2024_phenology$flower.spent)
DENU_2024_phenology$fruit.no <- as.numeric(DENU_2024_phenology$fruit.no)

##making a new variable that is the sum of the reproductive parts seen on each plant on each day
DENU_2024_phenology$repro_sum <- (DENU_2024_phenology$num.buds +  
      DENU_2024_phenology$flower.open + DENU_2024_phenology$flower.spent +
      DENU_2024_phenology$fruit.no)

##making a dataframe with the maximum reproductive parts recorded for each plant in
##the phenology census
##start with unique plants in the phenology dataset; there are 373
flowered_pheno_2024 <- unique(DENU_2024_phenology$unique.id)
max_repro_per_plant_2024_temp <- rep(0,length(flowered_pheno_2024))
for (i in 1:length(flowered_pheno_2024)) {
   max_repro_per_plant_2024_temp[i] <- max(
     DENU_2024_phenology$repro_sum[DENU_2024_phenology$unique.id == 
                                     flowered_pheno_2024[i]], na.rm = T)
}
max_repro_per_plant_2024 <- as.data.frame(cbind(flowered_pheno_2024,max_repro_per_plant_2024_temp))


##make a file with only the flowering plants
flowering_2024 <- subset(DENU_2024_demography, DENU_2024_demography$inf == 1)
flowering_2023 <- subset(DENU_2023_demography, DENU_2023_demography$inf == 1)

##checking to make sure no duplicate plant IDs in demography - length of just the
##unique plants and the whole data file differ by 1, because the data file has headers
##and the unique plants list doesn't, so should be no duplicates.
unique_plants <- unique(DENU_2024_demography$unique.id.2022)
length(unique_plants)
dim(DENU_2024_demography)


##length of demography is longer than length of uniqueIDs in demography by 5.
##Bummer. Fixed one missing uniqueID in excel. I think I fixed the rest
##but now I'm not sure what this code is doing.
duplicate_IDs <- which(duplicated(DENU_2024_demography$unique.id.2022))


##this gets list of unique IDs of plants that had zero flowers listed in the 
##demography dataset. 
zero_flowers_demog_2024 <- unique(DENU_2024_demography$unique.id.2022
                [DENU_2024_demography$flower.no==0])

##gets list of unique IDs of plants in phenology dataset; there were 373 of them
flowered_pheno_2024 <- unique(DENU_2024_phenology$unique.id)

##gets list of plants in phenology dataset that were listed as having zero flowers
##in the demog dataset; there were 14 of them
problem_flowers_2024 <- which(flowered_pheno_2024 %in% zero_flowers_demog_2024)

##this lists the unique ID's of those 27 plants
flowered_pheno_2024[problem_flowers_2024]

##get the sum of buds, flowers, spent flowers and fruits (note that in 2021
##we didn't record spent so those might be under-estimates)
DENU_2024_phenology$total_rep_units <- sum(DENU_2024_phenology$num.buds,
   DENU_2024_phenology$flower.open,DENU_2024_phenology$flower.spent,DENU_2024_phenology$fruit.no)


