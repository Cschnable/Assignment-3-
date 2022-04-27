getwd()
#1
read.csv("StormEvents_details-ftp_v1.0_d1998_c20220425.csv")
Storms=read.csv("StormEvents_details-ftp_v1.0_d1998_c20220425.csv")

#2
new_columns <-Storms %>% c("BEGIN_YEARMONTH","BEGIN_DAY","BEGIN_TIME","END_YEARMONTH","END_DAY","END_TIME","EPISODE_ID","EVENT_ID","STATE","STATE_FIPS","CZ_NAME","CZ_TYPE","CZ_FIPS","EVENT_TYPE","SOURCE","START_LAT","END_LAT","START_LON","END_LON")
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
newdata = newdata %>% mutate(STATE_FIPS = str_pad(STATE_FIPS, width = 2,side = "left",pad = "0"), CZ_FIPS = str_pad(CZ_FIPS, width=3, side= "left", pad="0")
                      unite("FIPS", STATE_FIPS, CZ_FIPS, sep="0")

#7
newdata = newdata %>% rename_all(newdata,tolower)

#8
data("state")
us_state_info<-data.frame(state=state.name, region=state.region, area=state.area)

#9
Events.1998<- data.frame(table(newdata$STATE))
merge(x=Events.1998,y=us_state_info,by.x="state", by.y="state")
newset1<-rename(Events.1998, c("state"="Var1"))
merged.state<-(mutate_all(df, toupper))
merge(x=Events.1998,y=us_state_info,by.x="state", by.y="state")

#10
library(ggplot2)
storm_plot<-ggplot(merged.state, aes(x=area,y=n)) +
  geom_point(aes(color=region)) +
  labs(x = "Land area (square miles)",
       y = "# of storm events in 2017")
storm_plot