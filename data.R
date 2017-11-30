# Load data every time the app is open 
library(RCurl)

# This loads the test as a string
my.file <- getURL('https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/fatal-police-shootings-data.csv', ssl.verifyhost=FALSE, ssl.verifypeer=FALSE)
# Use textConnection() to open a “connection” with the string, much like you would open a connection with a file on your hard drive in order to read it
# Once you have a connection, read it in as a csv
raw.data <- read.csv(textConnection(my.file), header=T, stringsAsFactors = FALSE)
# head(raw.data)


# Use this in your files by calling source on this file name