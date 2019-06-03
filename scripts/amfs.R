source(".scripts/FirstPassAcceptance.R")
afms <- getFPA(file = "./data/special.csv")
afms <- cleanFPA(afms)
afms <- subset(afms, project == "750.012")
afms <- process(FPA = afms)
str(afms)

# number of reviews
nrow(afms)

# numberof unique deliverables
length(unique(afms$UID))

table(afms$status)

nrow(unique(
     subset(afms, subset = status == "A-FP")
))/nrow(afms) * 100

fpa <- getFPA()
fpa <- cleanFPA(fpa)
fpa.lite <- subset(fpa, application != "AFMS")
fpa.afms <- subset(fpa, application == "AFMS")

fpa <- process(FPA = fpa)
fpa.lite <- process(FPA = fpa.lite)
fpa.afms <- process(FPA = fpa.afms)

source(file = "./scripts/Monthly_calculation.R")
monthStats(afms)
monthStats(fpa)
monthStats(fpa.lite)
monthStats(fpa.afms)
