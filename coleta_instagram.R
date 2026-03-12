packages <- c("httr", "jsonlite")

for (p in packages) {
  if (!require(p, character.only = TRUE)) {
    install.packages(p, repos = "https://cloud.r-project.org")
    library(p, character.only = TRUE)
  }
}

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
