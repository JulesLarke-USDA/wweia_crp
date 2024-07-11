## first run: 
# conda activate graphlan 

cd /Users/jules.larke/work/nhanes_crp/data/03/

graphlan_annotate.py --annot annot_1_mod2_ingred.txt ../02/wweia_ingredient_tree.txt wweia.ingred.xml

graphlan_annotate.py --annot food_ingredient_g_annot.txt wweia.ingred.xml wweia_food_g.xml

graphlan.py wweia_food_g.xml ./figure/ingredient_tree/wweia_annot_g_tree.png --dpi 1000 --size 5 --external_legend --avoid_reordering
