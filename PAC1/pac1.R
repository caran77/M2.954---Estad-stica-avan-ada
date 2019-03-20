
satisfaccioLaboral <- 
  read.table("D:/Users/cagarcia/uoc/M2.954 - Estadística avançada/PAC1/rawData.csv",
             header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE, blank.lines.skip = TRUE)

summary(satisfaccioLaboral)

satisfaccioLaboral$city <- tolower(trimws(satisfaccioLaboral$city, "both"))

satisfaccioLaboral$sex <- tolower(trimws(satisfaccioLaboral$sex, "both"))

table(satisfaccioLaboral$city)

table(satisfaccioLaboral$sex)


install.packages("gdata")

install.packages("quanteda")

trim(satisfaccioLaboral$city)

satisfaccioLaboral$city <- trimws(satisfaccioLaboral$city, "both")

satisfaccioLaboral$sex <- trimws(satisfaccioLaboral$sex, "both")

summary(satisfaccioLaboral$sex)

satisfaccioLaboral$city <- factor()

factor() satisfaccioLaboral$sex

satisfaccioLaboral$sex <- trim.blanks(satisfaccioLaboral$sex)

trim(satisfaccioLaboral$sex, recode.factor=FALSE)

trim.blanks()