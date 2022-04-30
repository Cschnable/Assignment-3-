getwd()
#1
read.csv("StormEvents_details-ftp_v1.0_d1998_c20220425.csv")
Storms=read.csv("StormEvents_details-ftp_v1.0_d1998_c20220425.csv")
head(Storms,2)
View(Storms)
#2
new_columns<-c("BEGIN_YEARMONTH","BEGIN_DAY","BEGIN_TIME","END_YEARMONTH","END_DAY","END_TIME","EPISODE_ID","EVENT_ID","STATE","STATE_FIPS","CZ_NAME","CZ_TYPE","CZ_FIPS","EVENT_TYPE","SOURCE","BEGIN_LAT","END_LAT","BEGIN_LON","END_LON")
newdata = Storms[new_columns]
head(newdata)
#3
library(dplyr)
newdata = newdata %>% arrange("BEGIN_YEARMONTH")

#4
library(tidyverse)
newdata = newdata %>% mutate(STATE = str_to_title(STATE), CZ_NAME = str_to_title(CZ_NAME))

#5
newdata = newdata %>% filter(CZ_TYPE =="C") %>% select(-CZ_TYPE)

#6
library(stringr)
str_pad(newdata$STATE_FIPS, width=3,side="left", pad = "0")
unite(newdata,"FIPS",c(STATE_FIPS, CZ_FIPS), sep = "_", remove=FALSE)
view(newdata)
#7
newdata = newdata %>% rename_all(tolower)
view(newdata)
#8
data("state")
us_state_info<-data.frame(state=state.name, region=state.region, area=state.area)

#9
table(newdata$state)
Events1998<-data.frame(table(newdata$state))
view(Events1998)
merged<-merge(x=newset1,y=us_state_info,by.x="state", by.y="state")
newset1<-rename(Events1998, c("state"="Var1"))
view(merged)

#10
library(ggplot2)
storm_plot<-ggplot(merged, aes(x = area, y = Freq)) +
  geom_point(aes(color = region)) +
  labs(x = "Land area (square miles)",
       y = "# of storm events in 1998")
storm_plot

