#Question 6 - Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle
#sources in Los Angeles County, California (fips= '06037'). Which city has seen greater change over time?
#GUIDANCE: no guidance provided

# Read the data "NEI" and the classification Code "SCC"
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Subsetting of NEI in a new data frame with mobiles in LA and Baltimore
ColNames = names(NEI)
NEIBaltMobiles <- unique(subset(NEI, fips == "24510" & type == "ON-ROAD", ColNames))
NEILAMobiles <- unique(subset(NEI, fips == "06037" & type == "ON-ROAD", ColNames))

# New data frame with the sum of each year
NEIBaltMobilesSum <- aggregate(Emissions ~ year, data = NEIBaltMobiles, FUN = sum)
NEILAMobilesSum <- aggregate(Emissions ~ year, data = NEILAMobiles, FUN = sum)

# Creating an Index for emissions (1999 = 100)
NEIBaltMobilesSum$Index <- (NEIBaltMobilesSum$Emissions / 
                              NEIBaltMobilesSum$Emissions[[1]]) * 100
NEILAMobilesSum$Index <- (NEILAMobilesSum$Emissions / 
                            NEILAMobilesSum$Emissions[[1]]) * 100

# Combinig sums together
NEIBaltLAMobilesSum <- rbind(NEIBaltMobilesSum, NEILAMobilesSum)

# Add new variable city
NEIBaltLAMobilesSum$city <- rep(c("Baltimore", "Los Angeles"), each = 4)

# Plot the emissions in ton by year
plot(NEIBaltLAMobilesSum$year, NEIBaltLAMobilesSum$Index, type = "n", 
     xlab = "Year", ylab ="PM2.5 Emissions Index (1999 = 100)", 
     ylim = c(0, 120))

with(subset(NEIBaltLAMobilesSum, city == "Baltimore"), 
     points(year, Index, pch = 19, lwd = 2, col = "steelblue"))
with(subset(NEIBaltLAMobilesSum, city == "Baltimore"),
     lines(year, Index, lwd = 2, col = "steelblue"))

with(subset(NEIBaltLAMobilesSum, city == "Los Angeles"), 
     points(year, Index, pch = 19, lwd = 2, col = "red"))
with(subset(NEIBaltLAMobilesSum, city == "Los Angeles"),
     lines(year, Index, lwd = 2, col = "red"))

abline(h = 100, lty = 2)

title(main = "Change of PM2.5 Emissions from Motor Vehicles in Baltimore and LA")

legend("topright", pch = 19, col = c("red", "steelblue"), 
       legend = c("Los Angeles", "Baltimore"))


# Save the plot in a png file
# Plot saved using the built-in feature form R stuido. No need to code. Code below as example
dev.copy(png, width = 800, height = 480, "C:/GIT/Exp_Data_Assign2/Q6_Rplot.png")
dev.off()