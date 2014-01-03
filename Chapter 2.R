##############################################
# Section 2.12 - Chapter 2 Exercises
#
# data files: Pitching
#
#   packages: Lahman, plyr
##############################################

##############################################
# 1. Top Base Stealers in the Hall of Fame
##############################################

SB = c(1406, 938, 897, 741, 738, 689, 506, 504, 474)
CS = c(335, 307, 212, 195, 109, 162, 136, 131, 114)
G = c(3081, 2616, 3034, 2826, 2476, 2649, 2599, 2683, 2379)

SB.Attempt = SB + CS

Success.Rate = round(SB / SB.Attempt, 2)

SB.Game = round(SB / G, 2)

plot(SB.Game, Success.Rate)

Player = c('Rickey Henderson', 'Lou Brock', 'Ty Cobb', 'Eddie Collins',
           'Max Carey', 'Joe Morgan', 'Luis Aparicio', 'Paul Molitor',
           'Roberto Alomar')

list(Player[Success.Rate == max(Success.Rate)], max(Success.Rate))

list(Player = Player[Success.Rate == min(Success.Rate)], 
     Rate = min(Success.Rate))

Player[SB.Game == max(SB.Game)]

##################################################
# 2. Character, Factor, and Logical Variables in R
##################################################

outcomes = c('Single', 'Out', 'Out', 'Single', 'Out', 
             'Double', 'Out', 'Walk', 'Out', 'Single')

table(outcomes)

f.outcomes = factor(outcomes, levels = c('Out', 'Walk', 'Single', 'Double'))
table(f.outcomes)
# The table is now organized by least successful to most successful outcome.

outcomes == 'Walk'
# Logical vector with value 1 if the batter draws a walk, 0 otherwise.

sum(outcomes == 'Walk')
# The sum of the logical vector above.  Since a walk is 1 and all other
# outcomes are zero, the sum of the vector is the number of walks.

##############################################
# 3. Pitchers in the 350 Wins Club
##############################################

W = c(373, 354, 364, 417, 355, 373, 361, 363, 511)
L = c(208, 184, 310, 279, 227, 188, 208, 245, 316)
Name = c('Alexander', 'Clemens', 'Galvin', 'Johnson', 'Maddux',
         'Mathewson', 'Nichols', 'Spahn', 'Young')

Win.PCT = round(100 * W / (W + L), 2)

Wins.350 = data.frame(Name, W, L, Win.PCT)

Wins.350[order(Win.PCT), ]

Name[Win.PCT == max(Win.PCT)] 

Name[Win.PCT == min(Win.PCT)]

##############################################
# 4. Pitchers in the 350 Wins Club, Continued
##############################################

SO = c(2198, 4672, 1806, 3509, 3371, 2502, 1868, 2583, 2803)
BB = c(951, 1580, 745, 1363, 999, 844, 1268, 1434, 1217)
# `Name` was defined above.

SO.BB.Ratio = round(SO / BB, 2)

SO.BB = data.frame(Name, SO, BB, SO.BB.Ratio)

subset(SO.BB, SO.BB.Ratio > 2.8)

SO.BB[order(SO.BB$BB), ]

SO.BB.Ratio[BB == max(BB)] # high, relative to the others

##############################################
# 5. Pitcher Strikeout/Walk Ratios
##############################################

library(Lahman)
data(Pitching)

stats = function(d){
  c.SO = sum(d$SO, na.rm = TRUE)
  c.BB = sum(d$BB, na.rm = TRUE)
  c.IPouts = sum(d$IPouts, na.rm = TRUE)
  c.midYear = median(d$yearID, na.rm = TRUE)
  data.frame(SO = c.SO, BB = c.BB, c.IPouts = c.IPouts, midYear = c.midYear)
} 
# In the book, the function is written with IPouts = c.IPouts.  
# However, the Pitching table already has a variable named "IPouts".
# Changed to avoid confusion in part (d)

library(plyr)

career.pitching = ddply(Pitching, .(playerID), stats)

df = merge(Pitching, career.pitching, by = "playerID")

career.10000 = subset(career.pitching, c.IPouts >= 10000)

with(career.10000, plot(midYear, SO / BB))
with(career.10000, lines(lowess(midYear, SO / BB))
# Pitchers' SO/BB ratio declined for those whose mid career year was 1880 
# to about 1920, and has steadily increased for those pitchers with mid
# career years about 1920 to present day.