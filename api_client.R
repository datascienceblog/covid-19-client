library(httr)
library(dplyr)
library(jsonlite)
library(ggplot2)

# Post to API
payload <- list(code = "DE")
response <- httr::POST(url = "http://127.0.0.1/covid",
                       body = toJSON(payload, auto_unbox = TRUE), encode = "json")

# Convert to data frame
content <- rawToChar(response$content)
df <- data.frame(fromJSON(content))

# Make a cool plot
df %>%
  mutate(date = as.Date(date)) %>%
  filter(cases_cum > 100) %>%
  filter(code %in% c("US", "DE", "IT", "FR", "ES")) %>%
  group_by(code) %>%
  mutate(time = 1:n()) %>%
  ggplot(., aes(x = time, y = cases_cum, color = code)) +
  xlab("Days since 100 cases") + ylab("Cumulative cases") +
  geom_line() + theme_minimal()

