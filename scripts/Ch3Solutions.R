##############################################
# Section 3.11 - Chapter 3 Exercises
#
# data files: hofpitching.csv, Master.csv,
#             batting.csv, gl1998.txt
#
#   packages: Lahman
# 
#  alternate: TRUE
##############################################


##############################################
# 1. Hall of Fame Pitching Dataset 
# 
# Note: "hofpitching" is "hfp" here
##############################################

path <- "https://raw.github.com/maxtoki/baseball_R/master/data"
path2file <- paste0(path, "/", "hofpitching.csv")
hfp <- read.csv(path2file)

cuts <- c(0, 10000, 15000, 20000, 30000)
labels = c("(< 10k)", "(10k, 15k)", "(15k, 20k)", "(> 20k)")
hfp$BF.group <- with(hfp, cut(BF, cuts, labels = labels))

# (a)
table(hfp$BF.group)

# (b)
barplot(table(hfp$BF.group)) 

# (c)
pie(table(hfp$BF.group))

##############################################
# 2. Hall of Fame Pitching Dataset (Continued) 
##############################################

# (a)
hist(hfp$WAR, xlab = "WAR per season", 
     main = "Wins Above Replacement - Hall of Fame pitchers")

# (b) 
as.character(hfp$X)[ order(hfp$WAR, decreasing = TRUE) ][1:2]

##############################################
# 3. Hall of Fame Pitching Dataset (Continued) 
##############################################

hfp$WAR.Season = with(hfp, WAR / Yrs)

# (a)
par(mar = c(5, 8, 4, 2))
stripchart(WAR.Season ~ BF.group, data = hfp, 
           method = 'jitter', pch = 1, las = 1)

# (b)
boxplot(WAR.Season ~ BF.group, data = hfp, horizontal = TRUE, 
        xlab = "WAR per season", pch = 1, las = 1)

##############################################
# 4. Hall of Fame Pitching Dataset (Continued)
##############################################

par(mar = c(5, 4, 4, 2) + 0.1)
hfp$MidYear = with(hfp, (From + To) / 2)
hfp.recent = subset(hfp, MidYear >= 1960)

# (a)
hfp[order(hfp$WAR.Season), ]

# (b)
windows(width = 7, height = 10)
dotchart(hfp$WAR.Season, labels = hfp$X, cex = 0.5, pch = 19, xlab = "WAR", 
         main = c("Wins Above Replacement - Hall of Fame Pitchers"))

# (c)
as.character(hfp$X)[order(hfp$WAR.Season, decreasing = TRUE)][1:2]

##############################################
# 5. Hall of Fame Pitching Dataset (Continued) 
##############################################

# (a)
with(hfp, plot(WAR.Season ~ MidYear))

# (c)
with(hfp, identify(WAR.Season, MidYear, X, n = 2))

##############################################
# 6. Working with the Lahman Batting Dataset 
##############################################

# (a)
library(Lahman)
data(Master, "Batting")

# (b)
getinfo = function (firstname, lastname){
  playerline = subset(Master, nameFirst == firstname & nameLast == lastname)
  name.code = as.character(playerline$playerID)
  birthyear = playerline$birthYear
  birthmonth = playerline$birthMonth
  birthday = playerline$birthDay
  byear = ifelse(birthmonth <= 6, birthyear, birthyear + 1)
  list(name.code = name.code, byear = byear)
}

cobb = getinfo("Ty", "Cobb")
williams = getinfo("Ted", "Williams")
rose = getinfo("Pete", "Rose")

# (b)
cobb.bat = subset(Batting, playerID == cobb$name.code)
williams.bat = subset(Batting, playerID == williams$name.code)
rose.bat = subset(Batting, playerID == rose$name.code[1])

# (c)
cobb.bat$Age = cobb.bat$yearID - cobb$byear
williams.bat$Age = williams.bat$yearID - williams$byear
rose.bat$Age = rose.bat$yearID - rose$byear[1]

# (d)
with(rose.bat, plot(cumsum(H) ~ Age, type = 'l', las = 1, ylab = "Hits"))

# (e)
with(cobb.bat, lines(cumsum(H) ~ Age, lty = 2))
with(williams.bat, lines(cumsum(H) ~ Age, lty = 3))
legend("bottomright", legend = c("Cobb", "Average", "Williams"),
       lty = c(2, 1, 3))


####################################
# 7.Retrosheet Play-by-Play Data Set
####################################

library(devtools)
source_gist(8892981)
parse.retrosheet2.pbp(1998)
data <- read.csv("all1998.csv", header = FALSE)
roster <- read.csv("roster1998.csv")
fields = read.csv("fields.csv")
names(data) = fields[, "Header"]
retro.ids <- read.csv("https://raw.github.com/maxtoki/baseball_R/master/data/retrosheetIDs.csv")

# (a)
sosa.id = as.character(subset(retro.ids, FIRST == "Sammy" & LAST == "Sosa")$ID)
mac.id = as.character(subset(retro.ids, FIRST == "Mark" & LAST == "McGwire")$ID)
sosa.data = subset(data, BAT_ID == sosa.id)
mac.data = subset(data, BAT_ID == mac.id)

# (b)
sosa.data = subset(sosa.data, BAT_EVENT_FL == TRUE)
mac.data = subset(mac.data, BAT_EVENT_FL == TRUE)

# (c)
mac.data$PA <- 1:nrow(mac.data)
sosa.data$PA <- 1:nrow(sosa.data)

# (d)
mac.HR.PA <- mac.data$PA[mac.data$EVENT_CD == 23]
sosa.HR.PA <- sosa.data$PA[sosa.data$EVENT_CD == 23]

# (e)
mac.spacings <- diff(c(0, mac.HR.PA))
sosa.spacings <- diff(c(0, sosa.HR.PA))

# (f)
summary(mac.spacings); summary(sosa.spacings)
par(mfrow = c(1, 2))
hist(mac.spacings)
hist(sosa.spacings)

## clear .GlobalEnv ##
rm(list=ls())