get_matchdays <- function(gameweek_id, season_id) {
  url <- paste0('https://api.sporza.be/web/soccer/matchdays/',
                season_id,
                '/',
                gameweek_id)
  response <- httr::GET(url)
  response_body <- httr::content(response)
  return(response_body)
}

get_all_matchdays <- function(gameweek_ids, season_id) {
  gameweek_ids %>% purrr::map(get_matchdays, season_id)
}

parse_games <- function(matchdays_response) {
  return(matchdays_response$groupedMatches[[1]][["matches"]])
}

parse_all_games <- function(matchdays_responses) {
  matchdays_responses %>%
    purrr::map(parse_games) %>%
    purrr::flatten()
}

game_took_place <- function(game) {
  exists("homeTeam", where = game) & exists("homeScore", where = game)
}

parse_game_result <- function(game) {
  if (game_took_place(game)) {
    data.frame(home_team = game$homeTeam$name,
               away_team = game$awayTeam$name,
               home_score = game$homeScore,
               away_score = game$awayScore,
               gameweek = game$roundNr)
  }
}

parse_all_game_results <- function(games) {
  games %>%
    purrr::map(parse_game_result)
}

parse_upcoming_game <- function(game) {
  data.frame(home_team = game$homeTeam$name,
             away_team = game$awayTeam$name,
             gameweek = game$roundNr)
}

parse_all_upcoming_games <- function(games) {
  games %>%
    purrr::map(parse_upcoming_game)
}
