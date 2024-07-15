## first run: 
# conda activate graphlan 

cd /../data/03/

graphlan_annotate.py --annot annot_1_mod2.txt ../02/foodcode/wweia_foodcode_tree.txt wweia.tree.xml

graphlan_annotate.py --annot foodcode_g_annot.txt wweia.tree.xml wweia.tree2.xml

graphlan.py wweia.tree2.xml ./figure/foodcode_tree/wweia_foodcode_tree.png --dpi 1000 --size 5 --external_legend --avoid_reordering
