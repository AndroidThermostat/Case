include <gearAndRack.scad>

translate([-6.2*3,0,0])
rack(height=10, mm_per_tooth=6.2, number_of_teeth=13, thickness=3);

translate([-24.5,-5,0])
cube([40,6,3], center=true);

translate([-45,32-36,7.5])
cube([3.5,80,18], center=true);

//44