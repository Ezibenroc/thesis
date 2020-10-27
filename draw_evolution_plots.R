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
    theme_minimal()

p1 = subplot +
    aes(y=nb_pages) +
    ylab("Number of pages")
p2 = subplot +
    aes(y=file_size) +
    ylab("File size (MB)")

plot = p1 + p2

ggsave("build/evolution_plot.png", plot=plot, width=8, height=4)
