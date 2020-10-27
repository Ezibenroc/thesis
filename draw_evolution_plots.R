library(ggplot2)
library(dplyr)
library(readr)
library(patchwork)

df = read.csv("build/thesis_data.csv") %>%
    mutate(timestamp=parse_datetime(as.character(timestamp), "%Y-%m-%d %H:%M:%S")) %>%
    mutate(file_size = file_size*1e-6)

subplot = ggplot(df) +
    aes(x=timestamp) +
    geom_point() +
    geom_line() +
    xlab("Timestamp") +
    expand_limits(y=0) +
    theme_light()

p1 = subplot +
    aes(y=nb_pages) +
    ylab("Number of pages") +
    scale_x_datetime(position = "top")
p2 = subplot +
    aes(y=file_size) +
    ylab("File size (MB)")

plot = p1 / p2 + plot_annotation(
    title = 'Evolution of the manuscript file'
)

ggsave("build/evolution_plot.png", plot=plot, width=4, height=8)
