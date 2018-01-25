library(repurrrsive)
library(listviewer)
library(jsonlite)
library(dplyr)
library(tibble)
library(purrr)

library(tidyverse)

standings <- fromJSON("https://statsapi.web.nhl.com/api/v1/standings", simplifyVector = FALSE)


standings <- standings$records

str(standings, max.level = 2)

teamRecords <- map(standings, "teamRecords")

#extract name

teamName <- teamRecords %>%
  map(. %>% map_chr(c("team", "name")))

str(teamName)

Name_df <- tibble(teamName) %>%
  unnest()

#extract info

info_df <- teamRecords %>%
  map(. %>% map_df(`[`, c("points", "gamesPlayed"))) %>%
  tibble() %>%
  unnest()

bind_cols(Name_df, info_df)

# output

