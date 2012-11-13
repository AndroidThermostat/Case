include <gearLib.scad>

module top_rack_space() {
	translate([-24.5+40,-3,.5]) cube([40+80,12,4.2], center=true);

	translate([-45,32-36,7.5]) cube([3.5,80,18], center=true);
}

module bottom_rack_space() {
	translate([-24.5+40-10,-5+3,.5]) cube([40+80,12,4.2], center=true);

	translate([-45,32,7.5]) cube([3.5,80,18], center=true);
}

module gear_space() {
	translate([45,12,-1.5]) cylinder(h = 4.5,r = 18);
	translate([10,12,-1.5]) cylinder(h = 4.5,r = 18);
}

module center_peg() {
	cylinder(h = 4.5,r = 4);
}

difference() {
	rotate([0, 180, 0]) translate([40,-16,-35.5]) import("caseTopR.stl");
	
	gear_space();
	translate([0,30,0]) top_rack_space();
	rotate([180,180,0]) translate([-40,5,0]) bottom_rack_space();
}

translate([45,12,-1.5]) center_peg();
translate([10,12,-1.5]) center_peg();


// Gear with bore_diameter changed to a larger (8.5 mm) to suite the larger pegs
translate([10,75,-3]) gear(number_of_teeth=11, circular_pitch=400, hub_thickness=0, bore_diameter=8.5,rim_thickness=3, gear_thickness=3);
