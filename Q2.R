##Question 2- Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
##(fips == "24510") from 1999 to 2008? 

##GUIDANCE: Use the base plotting system to make a plot answering this question.


#Read data
NEI <- readRDS("summarySCC_PM25.rds")

# Subsetting of in Baltimore
ColNames = names(NEI)
NEI_bal <- unique(subset(NEI, fips == "24510", ColNames))


# New data frame with the sum of each year
NEI_q2 <- aggregate(Emissions ~ year, data = NEI_bal, FUN = sum)


#Plot million by year in Baltimore
plot(NEI_q2$year, NEI_q2$Emissions, type = "n", 
     xlab = "Year", ylab ="PM2.5 Emissions(Tons)", 
     ylim = c(0, max(NEI_q2$Emissions)))
lines(NEI_q2$year, NEI_q2$Emissions, lwd = 2, col = "red")
points(NEI_q2$year, NEI_q2$Emissions, lwd = 3, pch = 20)
title(main = "PM2.5 Emissions in Baltimore from 1999 to 2008")

# Save the plot in a png file
# Plot saved using the built-in feature form R stuido. No need to code. Code below as example
dev.copy(png, width = 600, height = 480, "C:/GIT/Exp_Data_Assign2/Q2_Rplot.png")
dev.off()

