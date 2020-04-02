library(httr)
library(jsonlite)

# Post to API
payload <- list(code = "DE")
response <- httr::POST(url = "http://127.0.0.1/covid",
                       body = toJSON(payload, auto_unbox = TRUE), encode = "json")

# Convert to data frame
content <- rawToChar(response$content)
df <- data.frame(fromJSON(content))
df
