getwd()
#list.files()
#list.files("specdata")

#1.
pollutantMean <- function(directory, pollutant, id=1:332){
  files.list <- list.files(directory, full.names=TRUE) #creates a list of files
  dat <- data.frame() #creates an empty data frame
  for (i in id){
    #loops through the files, rbinding them together 
    dat <- rbind(dat, read.csv(files.list[i]))
  }
  dat.subset <- dat[pollutant] #subsets the rows that match the 'pollutant' argument
  mean(dat.subset[[pollutant]], na.rm=TRUE) #identifies the mean while stripping out the NAs
}
# Sample code for 1.
pollutantMean("specdata", "sulfate", 1:10)
pollutantMean("specdata", "nitrate", 70:72)
pollutantMean("specdata", "nitrate", 23)

#2.
complete <- function(directory, id=1:332){
  files.list <- list.files(directory, full.names=TRUE) #creates a list of files
  result <- data.frame(id=numeric(0), nobs=numeric(0)) #initialize result
  dat <- data.frame() #creates an empty data frame
  for (i in id){ #loops through the files
    dat <- read.csv(files.list[i]) #read the files
    dat.subset <- dat[(!is.na(dat$sulfate)), ] #subset completely observed cases for sulfate
    dat.subset <- dat.subset[(!is.na(dat.subset$nitrate)), ] #subset completely observed cases for nitrate
    nobs <- nrow(dat.subset) #nrow returns the number of rows in dat.subset
    result <- rbind(result, data.frame(id=i, nobs=nobs)) #gather the data from the specified range or id
  }
  result #returns a data frame of the number of completely observed cases in each data file
}
# Sample code for 2.
complete("specdata", 1)
complete("specdata", c(2,4,8,10,12))
complete("specdata", 30:25)
complete("specdata", 3)

#3. 
corr <- function(directory, threshold = 0){ #Create a function
  files.list <- list.files(directory, full.names=TRUE) #creates a list of files
  cor.result <- numeric(0) #Initialize cor.result
  dat <- data.frame() #creates an empty data frame
  num.complete <- complete(directory) #store all completely observed cases in num.complete
  #in line 49, we will subset the monitor locations where the number of completely observed cases: num.complete$nobs
  #is greater than the treshold
  num.complete <- num.complete[num.complete$nobs>threshold, ] 
  if(nrow(num.complete)>0){ #no of completely observed variables should be > 0
    for(i in num.complete$id){ #loop that iterates across the list of monitors where num.complete > 0
      dat <- read.csv(files.list[i]) #read the files
      dat.subset <- dat[(!is.na(dat$sulfate)), ] #subset the complete cases of sulfate and store to dat.subset
      dat.subset <- dat.subset[(!is.na(dat.subset$nitrate)), ] #add to dat.subset the num of complete cases of nitrate
      sulfate.data <- dat.subset["sulfate"] #Subset the data for sulfate
      nitrate.data <- dat.subset["nitrate"] #Subset the data for nitrate
      cor.result <- c(cor.result, cor(sulfate.data, nitrate.data)) 
      #Concatenates cor.result and the correlation between sulfate and nitrate; Gathers the data for the output later on 
    }
  }
  cor.result #Print result
}
# Sample code for 3.
cr <- corr("specdata", 150)
head(cr); summary(cr)

cr <- corr("specdata", 400)
head(cr); summary(cr)

cr <- corr("specdata", 5000)
head(cr); summary(cr); length(cr)

cr <- corr("specdata")
head(cr); summary(cr); length(cr)

# 4.
#extracted files from rprog_data_HospData.zip are already in the current directory
outcome <- read.csv('outcome-of-care-measures.csv', colClasses = "character") #Read outcome data
head(outcome)
ncol(outcome)
nrow(outcome)
names(outcome)

outcome[, 11] <- as.numeric(outcome[, 11]) #Make object interpretable as numbers
#Make histogram
hist(outcome[, 11], 
     main=paste("Hospital 30-Day Death (Mortality) Rates from Heart Attack"),
     xlab="Deaths", ylab="Frequency", col="light blue") 







