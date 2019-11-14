plot_rank_changes <- function(rank_table) {
  ggplot2::ggplot(data = rank_table,
                  aes(x = team, y = rank)) +
    ggplot2::geom_linerange(aes(ymin = lowest_rank,
                                ymax = highest_rank)) +
    ggplot2::geom_point() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
}
