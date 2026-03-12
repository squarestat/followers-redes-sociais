if(!require(httr)) install.packages("httr", repos="https://cloud.r-project.org")
if(!require(jsonlite)) install.packages("jsonlite", repos="https://cloud.r-project.org")

library(httr)
library(jsonlite)

get_followers <- function(username){

  url <- paste0(
    "https://i.instagram.com/api/v1/users/web_profile_info/?username=",
    username
  )

  res <- httr::GET(
    url,
    httr::add_headers(
      "User-Agent" = "Mozilla/5.0",
      "x-ig-app-id" = "936619743392459"
    )
  )

  data <- jsonlite::fromJSON(httr::content(res, "text", encoding = "UTF-8"))

  data$data$user$edge_followed_by$count
}

users <- c("fgvibre")

followers <- sapply(users, get_followers)

dados <- data.frame(
  data = Sys.Date(),
  username = users,
  followers = followers
)

arquivo <- "followers_historico.csv"

if(file.exists(arquivo)){
  antigo <- read.csv(arquivo)
  dados <- rbind(antigo, dados)
}

write.csv(dados, arquivo, row.names = FALSE)
