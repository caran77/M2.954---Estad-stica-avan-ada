
satisfaccioLaboral <- read.csv("D:/Users/cagarcia/uoc/M2.954 - Estadística avançada/PAC1/rawData.csv", header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE, blank.lines.skip = TRUE)

satisfaccioLaboralAux <- read.csv("D:/Users/cagarcia/uoc/M2.954 - Estadística avançada/PAC1/rawData.csv", header=TRUE, sep=",", na.strings="NA", dec=".", strip.white=TRUE, blank.lines.skip = TRUE)


satisfaccioLaboral$educ_level <- factor(satisfaccioLaboral$educ_level, levels=c(1,2,3,4), labels = c("N", "P", "S", "U"));

table(satisfaccioLaboral$educ_level);

satisfaccioLaboral$job_type <- factor(satisfaccioLaboral$job_type, levels=c(1,2), 
                                      labels=c("C", "PC"))

table (satisfaccioLaboral$job_type)

satisfaccioLaboral$happiness <- gsub(",", ".", satisfaccioLaboral$happiness);
satisfaccioLaboral$happiness <- as.numeric(satisfaccioLaboral$happiness);
summary(satisfaccioLaboral$happiness);

satisfaccioLaboral$sick_leave_b <- factor(satisfaccioLaboral$sick_leave_b, levels=c(0,1), labels=c(FALSE, TRUE));
summary(satisfaccioLaboral$sick_leave_b);

satisfaccioLaboral$work_hours <- -1 * satisfaccioLaboral$work_hours[satisfaccioLaboral$work_hours <= 0]

satisfaccioLaboral$sick_leave_b <- as.logical(satisfaccioLaboral$sick_leave_b); 
satisfaccioLaboral$educ_level <- as.ordered(satisfaccioLaboral$educ_level);

satisfaccioLaboral$work_hours <- round(satisfaccioLaboral$work_hours, digits = 1)

satisfaccioLaboral$ageNorm <- (satisfaccioLaboral$age - mean(satisfaccioLaboral$age)) / sd(satisfaccioLaboral$age);
satisfaccioLaboral$seniorityNorm <- (satisfaccioLaboral$seniority - mean(satisfaccioLaboral$seniority)) / sd(satisfaccioLaboral$seniority);
satisfaccioLaboral$sick_leaveNorm <- (satisfaccioLaboral$sick_leave - mean(satisfaccioLaboral$sick_leave)) / sd(satisfaccioLaboral$sick_leave);
satisfaccioLaboral$work_hoursNorm <- (satisfaccioLaboral$work_hours - mean(satisfaccioLaboral$work_hours)) / sd(satisfaccioLaboral$work_hours);
satisfaccioLaboral$Cho_initialNorm <- (satisfaccioLaboral$Cho_initial - mean(satisfaccioLaboral$Cho_initial)) / sd(satisfaccioLaboral$Cho_initial);
satisfaccioLaboral$Cho_finalNorm <- (satisfaccioLaboral$Cho_final - mean(satisfaccioLaboral$Cho_final)) / sd(satisfaccioLaboral$Cho_final);

satisfaccioLaboral$sex <- toupper(trimws(satisfaccioLaboral$sex, "both")); 
table(satisfaccioLaboral$sex);

satisfaccioLaboral$city <- trimws(satisfaccioLaboral$city, "both");
satisfaccioLaboral$city <- tools::toTitleCase(satisfaccioLaboral$city);
satisfaccioLaboral$city <- stringr::str_replace(satisfaccioLaboral$city, 'De', 'de');
table(satisfaccioLaboral$city);

boxplot(satisfaccioLaboral$work_hours,main="Work hours box plot", col="gray")

boxplot(satisfaccioLaboral$happiness,main="Work hours box plot", col="gray")

boxplot.stats(satisfaccioLaboral$work_hours)$out

boxplot.stats(satisfaccioLaboral$happiness)$out

summary(satisfaccioLaboral)

satisfaccioLaboral[is.na(satisfaccioLaboral$happiness),]

library(VIM)

VIM::kNN(satisfaccioLaboral)

satisfaccioLaboral.complet <- VIM::kNN(satisfaccioLaboral)

satisfaccioLaboral.complet$happiness

satisfaccioLaboral$happinessComplete <- satisfaccioLaboral.complet$happiness

summary(satisfaccioLaboral$happinessComplete)

satisfaccioLaboral$happiness <- satisfaccioLaboral$happinessComplete[is.na(satisfaccioLaboral$happiness)]

mean(satisfaccioLaboral$happiness)
median(satisfaccioLaboral$happiness)
mean(satisfaccioLaboral$happiness, trim=0.05)
psych::winsor.mean(satisfaccioLaboral$happiness, trim=0.05)
IQR(satisfaccioLaboral$happiness)
sd(satisfaccioLaboral$happiness)
mad(satisfaccioLaboral$happiness)

