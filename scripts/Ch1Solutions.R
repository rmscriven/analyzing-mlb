##############################################
#     Section 1.8 - Chapter 1 Exercises
#
#     data files: Pitching (Lahman)
#                 1964 Retrosheet Gamelog
#                 Sept. 20, 1992 Play-by-play
# 
#       packages: Lahman 
##############################################



##############################################
# 2. Lahman Pitching Data 
##############################################

library(Lahman)
bGib <- subset(Pitching, playerID == "gibsobo01" & yearID == 1968)

# (a) ----------------------------------------
with(bGib, CG / GS)

# (b) ----------------------------------------
with(bGib, SO / BB)

# (c) ----------------------------------------
with(bGib, IPouts / 3)

# (d) ----------------------------------------
with(bGib, (H+BB) / IP)

##############################################
# 3. Retrosheet Game Log
##############################################

tmp <- tempfile()
download.file("http://www.retrosheet.org/gamelogs/gl1964.zip", tmp)
unzip(tmp)
gl64 <- read.csv("GL1964.TXT", header = FALSE)
unlink(tmp)

glhead <- readLines("https://raw.github.com/maxtoki/baseball_R/master/data/game_log_header.csv")
glheader <- unlist(strsplit(glhead, ","))
names(gl64) <- glheader

gl64Bun <- gl64[ gl64$Date == 19640621 & gl64$VisitorStartingPitcherName == "Jim Bunning", ]

# (a) ----------------------------------------
hours <- round(gl64Bun$Duration / 60 , 0)
mins <- ((gl64Bun$Duration / 60) %% 2)*60

# (b) ----------------------------------------
# It is still being researched

# (c) ----------------------------------------
sum(gl64Bun[, c(24,25,26)])

# (d) ----------------------------------------
with(gl64Bun, (VisitorH+VisitorBB+VisitorHBP) / (VisitorAB+VisitorBB+VisitorHBP+VisitorSF))

##############################################
# 4. Retrosheet Play-by-Play Record
##############################################

# Answers vary

##############################################
# 5. PITCHf/x Record of Several Pitches
##############################################

# Answers vary
