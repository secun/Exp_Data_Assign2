##Question 1 - Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
##GUIDANCE: Using the base plotting system, make a plot showing the total PM2.5 emission from all 
##sources for each of the years 1999, 2002, 2005, and 2008.

#Read data
NEI <- readRDS("summarySCC_PM25.rds")



# New data frame with the sum  (formatted for clarity)  of each year
NEI_q1 <- aggregate(Emissions ~ year, data = NEI, FUN = sum)
NEI_q1$Emissions_f <- NEI_q1$Emissions/1000000

#Plot million by year
plot(NEI_q1$year, NEI_q1$Emissions_f, type = "n", 
     xlab = "Year", ylab ="PM2.5 Emissions(Million Tons)", 
     ylim = c(0, max(NEI_q1$Emissions_f)))
lines(NEI_q1$year, NEI_q1$Emissions_f, lwd = 2, col = "read")
points(NEI_q1$year, NEI_q1$Emissions_f, lwd = 3, pch = 20)
title(main = "PM2.5 Emissions  from 1999 to 2008")


# Save the plot in a png file
# Plot saved using the built-in feature form R stuido. No need to code. Code below as example
dev.copy(png, width = 600, height = 480, "C:/GIT/Exp_Data_Assign2/Q2_Rplot1.png")
dev.off()