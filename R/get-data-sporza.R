get_matchdays <- function(season_id, gameweek_id) {
  url <- paste0('https://api.sporza.be/web/soccer/matchdays/',
                season_id,
                '/',
                gameweek_id)
  response <- httr::GET(url)
  response_body <- httr::content(response)
  return(response_body)
}

parse_games <- function(matchdays_response) {
  return(matchdays_response$groupedMatches[[1]][["matches"]])
}

parse_game_result <- function(game) {
  data.frame(home_team = game$homeTeam$name,
             away_team = game$awayTeam$name,
             home_score = game$homeScore,
             away_score = game$awayScore)
}


