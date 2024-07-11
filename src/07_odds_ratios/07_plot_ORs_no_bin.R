# Purpose: create a plot of the Marginal effect and CIs for high/low inflammation based on 
# ingredietns in the top two categories ( non-alc beverages and pastas and cooked cereals)

library(ggplot2)
library(cowplot)

# Non-alcoholic beverages
nonalc_odds = read.csv('../../data/09/nonalc_bev_odds_all_ingredients_all_cov.csv')

choc_powder_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[1], format = "e", digits = 2))
strawb_powder_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[2], format = "e", digits = 2))
orange_powder_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[3], format = "e", digits = 2))
coffee_tap_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[4], format = "e", digits = 2))
coffee_instant_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[5], format = "e", digits = 2))

coffee_espresso_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[6], format = "e", digits = 2))
coffee_decaf_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[7], format = "e", digits = 2))
coffee_milk_sweet_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[8], format = "e", digits = 2))
coffee_sub_cereal_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[9], format = "e", digits = 2))
black_tea_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[10], format = "e", digits = 2))

green_tea_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[11], format = "e", digits = 2))
instant_tea_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[12], format = "e", digits = 2))
herbal_tea_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[13], format = "e", digits = 2))
cream_soda_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[14], format = "e", digits = 1))
citrus_soda_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[15], format = "e", digits = 2))

choc_soda_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[16], format = "e", digits = 2))
diet_soda_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[17], format = "e", digits = 2))
lemonade_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[18], format = "e", digits = 2))
fruit_punch_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[19], format = "e", digits = 2))
orange_drink_label = paste0("italic(p) ==", formatC(nonalc_odds$Pr...z..[20], format = "e", digits = 2))

colnames(nonalc_odds)

nonalc_odds_ = nonalc_odds[-16,]
nonalc_odds_ = nonalc_odds_[-9,]

nonalc_odds_ = nonalc_odds_[-c(19:34),]

nonalc_odds_names = nonalc_odds_
nonalc_odds_names$X = c('Chocolate powder mix', 'Strawberry powder mix', 'Orange powder mix', 'Coffee, brewed', 'Instant coffee', 'Espresso, brewed',
                        'Decaf coffee', 'Coffee, milk and sugar', 'Black tea', 'Green tea', 'Instant tea', 'Herbal tea',
                        'Cream soda', 'Citrus soda', 'Diet soda', 'Lemonade', 'Fruit punch', 'Orange flavored drink')

nonalc_plot <- ggplot(nonalc_odds_names, aes(x = dy.dx, y = forcats::fct_reorder(X, dy.dx))) +
  geom_point(size = 2) +
  geom_segment(aes(x= Conf..Int..Low, xend = Cont..Int..Hi., yend = X), size = 1, linetype = 1, arrow = arrow(ends = "both", angle = 90, length = unit(0.05, "in"))) +
  ylab("Non-alcoholic beverages") +
  xlab("Marginal effect [95% CI]") +
  ggtitle('Model accuracy = 0.760') +
  theme_classic() +
  annotate(
    "text",
    x = 0.075,
    y = 18,
    label = fruit_punch_label,
    fontface = 'bold',
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 17,
    label = orange_drink_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 16,
    label = strawb_powder_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 15,
    label = choc_powder_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 14,
    label = cream_soda_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 13,
    label = citrus_soda_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 12,
    label = instant_tea_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 11,
    label = lemonade_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 10,
    label = green_tea_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 9,
    label = diet_soda_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 8,
    label = orange_powder_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 7,
    label = black_tea_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 6,
    label = coffee_milk_sweet_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 5,
    label = coffee_tap_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 4,
    label = coffee_instant_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 3,
    label = coffee_decaf_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 2,
    label = coffee_espresso_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.075,
    y = 1,
    label = herbal_tea_label,
    parse = T
  ) +
   coord_cartesian(xlim = c(-0.15, 0.05), # This focuses the x-axis on the range of interest
                  clip = 'off') +   # This keeps the labels from disappearing
  geom_vline(xintercept= 0, linetype = "dashed") +
  theme(plot.margin = unit(c(1,5,1,1), "lines"),
        axis.text.x  = element_text(size = 10, color = 'black'),
        axis.text.y = element_text(size = 10, color = 'black'),
        axis.title.y = element_text(size = 10),
        axis.title.x = element_text(size = 10),
        plot.title = element_text(size = 10, hjust = 0.5),
        legend.position = "none"
  ) 
nonalc_plot

# Pastas and cooked cereals
pcc_odds = read.csv('../../data/09/pcc_odds_all_ingredients_all_cov.csv')

pasta_dry_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[1], format = "e", digits = 2))
macaroni_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[2], format = "e", digits = 2))
noodles_dry_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[3], format = "e", digits = 2))
noodles_cooked_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[4], format = "e", digits = 2))
noodles_spinach_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[5], format = "e", digits = 2))
chow_mein_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[6], format = "e", digits = 2))
pasta_wheat_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[7], format = "e", digits = 2))
rice_white_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[8], format = "e", digits = 2))
rice_brown_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[9], format = "e", digits = 2))
rice_wild_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[10], format = "e", digits = 2))
barley_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[11], format = "e", digits = 2))
corn_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[12], format = "e", digits = 2))
millet_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[13], format = "e", digits = 2))
oats_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[14], format = "e", digits = 2))
quinoa_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[15], format = "e", digits = 2))
bulgar_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[16], format = "e", digits = 2))
oat_bran_label = paste0("italic(p) ==", formatC(pcc_odds$Pr...z..[17], format = "e", digits = 2))


pcc_oddsnames = pcc_odds

pcc_oddsnames = pcc_oddsnames[-2,]
pcc_oddsnames = pcc_oddsnames[-4,]
pcc_oddsnames = pcc_oddsnames[-c(16:31),]

pcc_oddsnames$X = c('Pasta, dry', 'Egg noodles, dry', 'Egg noodles, cooked',  'Chow mein noodles',
                    'Pasta, whole wheat', 'Rice, white', 'Rice, brown', 'Rice, wild', 'Barley, pearled', 'Corn grits',
                    'Millet, cooked', 'Oats, regular and quick', 'Quinoa, cooked', 'Bulgar, dry', 'Oat bran, raw')

pcc_plot <- ggplot(pcc_oddsnames, aes(x = dy.dx, y = forcats::fct_reorder(X, dy.dx))) +
  geom_point(size = 2) +
  geom_segment(aes(x= Conf..Int..Low, xend = Cont..Int..Hi., yend = X), size = 1, linetype = 1, arrow = arrow(ends = "both", angle = 90, length = unit(0.05, "in"))) +
  ylab("Pastas and cereals") +
  xlab("Marginal effect [95% CI]") +
  ggtitle('Model accuracy = 0.743') +
  theme_classic() +
  annotate(
    "text",
    x = 0.05,
    y = 15,
    label = rice_wild_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.05,
    y = 14,
    label = chow_mein_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.05,
    y = 13,
    label = noodles_cooked_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.05,
    y = 12,
    label = rice_white_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.05,
    y = 11,
    label = oat_bran_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.05,
    y = 10,
    label = corn_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.05,
    y = 9,
    label = pasta_dry_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.05,
    y = 8,
    label = noodles_dry_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.05,
    y = 7,
    label = barley_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.05,
    y = 6,
    label = oats_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.05,
    y = 5,
    label = rice_brown_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.05,
    y = 4,
    label = pasta_wheat_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.05,
    y = 3,
    label = bulgar_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.05,
    y = 2,
    label = quinoa_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.05,
    y = 1,
    label = millet_label,
    parse = T
  ) +
  coord_cartesian(xlim = c(-0.04, 0.04), # This focuses the x-axis on the range of interest
                  clip = 'off') +   # This keeps the labels from disappearing
  geom_vline(xintercept= 0, linetype = "dashed") +
  theme(plot.margin = unit(c(1,5,1,1), "lines"),
        axis.text.x  = element_text(size = 10, color = 'black'),
        axis.text.y = element_text(size = 10, color = 'black'),
        axis.title.y = element_text(size = 10),
        axis.title.x = element_text(size = 10),
        plot.title = element_text(size = 10, hjust = 0.5),
        legend.position = "none"
  ) 
pcc_plot



# Cow milk
milk_odds = read.csv('../../data/09/milk_odds_all_ingredients_all_cov.csv')

whole_label = paste0("italic(p) ==", formatC(milk_odds$Pr...z..[1], format = "e", digits = 2))
two_percent_label = paste0("italic(p) ==", formatC(milk_odds$Pr...z..[2], format = "e", digits = 2))
one_percent_label = paste0("italic(p) ==", formatC(milk_odds$Pr...z..[3], format = "e", digits = 2))
nonfat_label = paste0("italic(p) ==", formatC(milk_odds$Pr...z..[4], format = "e", digits = 2))
dry_label = paste0("italic(p) ==", formatC(milk_odds$Pr...z..[5], format = "e", digits = 2))
average_fat_label = paste0("italic(p) ==", formatC(milk_odds$Pr...z..[6], format = "e", digits = 2))
buttermilk_label = paste0("italic(p) ==", formatC(milk_odds$Pr...z..[7], format = "e", digits = 2))
chocolate_milk_label = paste0("italic(p) ==", formatC(milk_odds$Pr...z..[8], format = "e", digits = 2))


milk_oddsnames = milk_odds

milk_oddsnames = milk_oddsnames[-c(9:22),]

milk_oddsnames$X = c('Whole', '2% fat', '1% fat', 'Nonfat', 'Powdered', 'Average fat*', 'Buttermilk', 'Chocolate')

milk_plot <- ggplot(milk_oddsnames, aes(x = dy.dx, y = forcats::fct_reorder(X, dy.dx))) +
  geom_point(size = 2) +
  geom_segment(aes(x= Conf..Int..Low, xend = Cont..Int..Hi., yend = X), size = 1, linetype = 1, arrow = arrow(ends = "both", angle = 90, length = unit(0.05, "in"))) +
  ylab("Cow's milk") +
  xlab("Marginal effect [95% CI]") +
  ggtitle('Model accuracy = 0.755') +
  theme_classic() +
  annotate(
    "text",
    x = 0.04,
    y = 8,
    label = buttermilk_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.04,
    y = 7,
    label = whole_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.04,
    y = 6,
    label = two_percent_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.04,
    y = 5,
    label = chocolate_milk_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.04,
    y = 4,
    label = nonfat_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.04,
    y = 3,
    label = one_percent_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.04,
    y = 2,
    label = average_fat_label,
    parse = T
  ) +
  annotate(
    "text",
    x = 0.04,
    y = 1,
    label = dry_label,
    parse = T
  ) +
  coord_cartesian(xlim = c(-0.05, 0.03), # This focuses the x-axis on the range of interest
                  clip = 'off') +   # This keeps the labels from disappearing
  geom_vline(xintercept= 0, linetype = "dashed") +
  theme(plot.margin = unit(c(1,5,1,1), "lines"),
        axis.text.x  = element_text(size = 10, color = 'black'),
        axis.text.y = element_text(size = 10, color = 'black'),
        axis.title.y = element_text(size = 10),
        axis.title.x = element_text(size = 10),
        plot.title = element_text(size = 10, hjust = 0.5),
        legend.position = "none"
  ) 
milk_plot

g2 = plot_grid(nonalc_plot, pcc_plot, milk_plot, nrow = 3, rel_heights = c(1,0.833333333333333,0.6))
g2
ggsave('odds_ratio_top_3.png', width = 8, height = 10, units = 'in', dpi=1000)
