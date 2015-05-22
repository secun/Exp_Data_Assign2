# Question 4 - Across the United States, how have emissions from coal combustion-related sources changed 
# from 1999-2008?
# GUIDANCE: no guidance provided

# Read the data "NEI" and the classification Code "SCC"
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Merge the datasets NEI and the SCC codes
NEImerged <- merge(NEI, SCC, by = "SCC", all = FALSE)

# Find the rows with coal
SCCmatch <- as.logical(grepl("^fuel comb -(.*)- coal$", 
                             NEImerged$EI.Sector, ignore.case = TRUE))

# New data frame with data for coal in USA
NEICoal <- NEImerged[SCCmatch, 1:8]


# New data frame with the sum of each year
NEICoalSum <- aggregate(Emissions ~ year, data = NEICoal, FUN = sum)


# Year as numeric for better usuability
NEICoalSum$year <- as.numeric(NEICoalSum$year)

# Emissions in thousand tons for better reading
NEICoalSum$Emission1000 <- NEICoalSum$Emissions/1000


# Plot the emissions in thousand tons by year and by type of source in Baltimore
plot(NEICoalSum$year, NEICoalSum$Emission1000, type = "n", 
     xlab = "Year", ylab ="PM2.5 Emissions (in Thousand Tons)", 
     ylim = c(0, max(NEICoalSum$Emission1000)))
lines(NEICoalSum$year, NEICoalSum$Emission1000, lwd = 2, col = "red")
points(NEICoalSum$year, NEICoalSum$Emission1000, lwd = 3, pch = 20)
title(main = "PM2.5 Emissions from Coal in USA from 1999 to 2008")

# Save the plot in a png file
# Plot saved using the built-in feature form R stuido. No need to code. Code below as example
dev.copy(png, width = 600, height = 480, "C:/GIT/Exp_Data_Assign2/Q4_Rplot.png")
dev.off()