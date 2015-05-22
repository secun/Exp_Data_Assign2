#Question 5 - How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

#GUIDANCE: no guidance provided

# Read the data "NEI" and the classification Code "SCC"
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subsetting of NEI in a new data frame with only Baltiomore and mobiles
ColNames = names(NEI)
NEIBaltMobiles <- unique(subset(NEI, fips == "24510" & type == "ON-ROAD", ColNames))


# New data frame with the sum of each year
NEIBaltMobilesSum <- aggregate(Emissions ~ year, data = NEIBaltMobiles, FUN = sum)



# Plot the emissions in thousand tons by year from motor vehicle sources in Baltimore
plot(NEIBaltMobilesSum$year, NEIBaltMobilesSum$Emissions, type = "n", 
     xlab = "Year", ylab ="PM2.5 Emissions(Tons)", 
     ylim = c(0, max(NEIBaltMobilesSum$Emissions)))
lines(NEIBaltMobilesSum$year, NEIBaltMobilesSum$Emissions, lwd = 2, col = "red")
points(NEIBaltMobilesSum$year, NEIBaltMobilesSum$Emissions, lwd = 3, pch = 20)
title(main = "PM2.5 Emissions from Motor Vehicles in Baltimore from 1999 to 2008")





# Save the plot in a png file
# Plot saved using the built-in feature form R stuido. No need to code. Code below as example
dev.copy(png, width = 600, height = 480, "C:/GIT/Exp_Data_Assign2/Q5_Rplot.png")
dev.off()