library(tidyverse)
library(lubridate)
library(zoo)

args = commandArgs(trailingOnly=TRUE)
if (length(args) == 0) {
  stop("At least one source file should be named")
}
data = read.csv(args[1])


grouped <- data %>%
  filter(TGTCOUNTRY == "SOUTH VIETNAM" | TGTCOUNTRY == "NORTH VIETNAM") %>%
  mutate(week = lubridate::round_date(ymd(MSNDATE), unit = "week", week_start=0)) %>%
  mutate(month = lubridate::round_date(ymd(MSNDATE), unit = "month")) %>%
  mutate(lat = round(TGTLATDD_DDD_WGS84 / .5) * .5) %>%
  group_by(month, lat) %>%
  tally() %>%
  mutate(n_3r = rollmean(n, k = 3, fill = n)) %>%
  print(n = 50)

if (!is.null(args[2])) {
  write.csv(grouped, args[2], row.names = FALSE)
}
