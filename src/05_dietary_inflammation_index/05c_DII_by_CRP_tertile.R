library(dplyr)
library(ggplot2)
library(survey)
options(survey.lonely.psu='adjust')

getwd()

dii = read.csv('../../data/05/dii/crp_dii_wweia.csv')
crp <- read.csv("../../data/00/crp_table1.csv")

dii_crp = left_join(dii, crp, on='SEQN')

t1_t3 = dii_crp %>% filter(crp_table != 2)
t1_t3$crp_table <- factor(t1_t3$crp_table)

svy_all <- svydesign(data=t1_t3, id=~SDMVPSU, strata=~SDMVSTRA, weights=~mecwts, nest=TRUE)

svyttest(DII~crp_table, svy_all)

boxplot(t1_t3$DII~t1_t3$crp_table)

current_cutoff <- ggplot(data = t1_t3,
                    aes(
                      x = crp_table,
                      y = DII,
                      fill = factor(crp_table),
                    )) +  geom_boxplot(notch = TRUE) +
  #geom_point(position = position_jitter(), size=3, alpha=0.9) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1))) +
  scale_fill_manual(values = c(
    "darkorange",
    "royalblue"
  )) +
  annotate(
    "segment",
    x = 1,
    xend = 2,
    y = 7,
    yend = 7,
    size = 0.5
  ) +
  annotate(
    "text",
    x = 1.5,
    y = 7.1,
    label = "***",
    size =5
  ) +
  theme_bw() +
  theme(
    title = element_text(size = 10),
    axis.line.x = element_line(color = "black", size = .5),
    axis.line.y = element_line(color = "black", size = .5),
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = 10),
    axis.text.x = element_text(
      size = 10,
      color = "black",
      vjust = 0.2,
    ),
    axis.text.y = element_text(size = 10, color = "black"),
    axis.ticks.x = element_blank(),
    legend.title = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank(),
    legend.position = 'none'
  )
current_cutoff

setwd('/Users/jules.larke/work/nhanes_crp/data/05/plot')
dev.copy(jpeg,'figure_s2.png', width=8, height=4, units="in", res=500)
dev.off()
