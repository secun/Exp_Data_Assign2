#Question 3- Of the four types of sources (type = point, nonpoint, onroad, nonroad) , which of these 
# four sources have seen decreases in emissions from 1999-2008 for Baltimore City, Which have seen 
# increases in emissions from 1999-2008?

# GUIDANCE: Use the ggplot2 plotting system to make a plot answer this question


# Read the data "NEI" and the classification Code "SCC"
NEI <- readRDS("summarySCC_PM25.rds")


# Subsetting of NEI in a new data frame only with Baltiomore
install.packages("dplyr")
library(dplyr)

NEI_q3 <- NEI %>% 
  filter (fips == "24510") %>% 
  select (fips, type, Emissions, year) %>% 
  group_by (year, type) %>% 
  summarise (sumpm25 = sum(Emissions))

# Load ggplot
install.packages("ggplot2")
library(ggplot2)

#Plot million by year in Baltimore, per type
qplot(year, sumpm25, data = NEI_q3, facets = . ~ type) +
  geom_line() +
  labs(title = "Change of Emission PM2.5 by type of Source in Baltimore", 
       x = expression("Year"), y = expression("PM2.5 Emissions(Tons)"))

# Save the plot in a png file
# Plot saved using the built-in feature form R stuido. No need to code. Code below as example
dev.copy(png, width = 600, height = 480, "C:/GIT/Exp_Data_Assign2/Q3_Rplot.png")
dev.off()
