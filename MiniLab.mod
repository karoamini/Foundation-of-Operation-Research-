
# set of houses
param n;
param range;

set H := 1..n;

param Cx{H};
param Cy{H};
param Dc{H};
param usable{H};

var x{H,H}, binary;
var y{H}, binary;

minimize obj:
	sum {i in H} (Dc[i]*y[i]);
	
s.t. only_permitted_houses{i in H}:
	y[i] <= usable[i];
	
s.t. assign_only_existing_market{i in H, j in H}:
	x[i, j] <= y[j];
	
s.t. each_house_has_to_be_covered{i in H}:
	sum {j in H} x[i, j] >= 1;
	
#Distances
s.t. distance{i in H, j in H}: 
   x[i, j] * sqrt((Cx[i]-Cx[j])^2 + (Cy[i]-Cy[j])^2) <= range;