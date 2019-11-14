plot_points_histogram <- function(league_table) {
  ggplot2::ggplot(data = league_table,
                  ggplot2::aes(x = total_points)) +
    ggplot2::geom_histogram(bins = 15)
}
