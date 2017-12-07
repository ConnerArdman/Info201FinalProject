# Load data every time the app is open 
raw.data <- read.csv("https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/fatal-police-shootings-data.csv", header=T, stringsAsFactors = FALSE)
