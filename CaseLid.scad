include <gearLib.scad>

module top_rack_space() {
	translate([-24.5+40,-3,.5]) cube([120,12,4.5], center=true);

	translate([-45,32-36,7.5]) cube([3.5,80,18], center=true);
}

module bottom_rack_space() {
	translate([-24.5+30,-2,.5]) cube([120,12,4.5], center=true);

	translate([-45,32,7.5]) cube([3.5,80,18], center=true);
}

// Added total gap of 7.4mm (+-3.7 mm to each)
module gear_space() {
	translate([45+3.7,12,-1.5]) cylinder(h = 4.5,r = 18);
	translate([10-3.7,12,-1.5]) cylinder(h = 4.5,r = 18);
}

module center_peg() {
	cylinder(h = 4.5,r = 4);
}

difference() {
	rotate([0, 180, 0]) translate([40,-16,-35.5]) import("caseTop.stl");
	
	gear_space();
	translate([0,30,0]) top_rack_space();
	rotate([180,180,0]) translate([-40,5,0]) bottom_rack_space();
}

// Added total gap of 7.4mm (+-3.7 mm to each peg)
translate([45+3.7,12,-1.5]) center_peg();
translate([10-3.7,12,-1.5]) center_peg();

// Added Bridges to hold up the racks
translate([-25,19,2.5]) cube([3,15,1]);
translate([26,-15,2.5]) cube([3,50,1]);


// Gear with bore_diameter changed to a larger (8.5 mm) to suite the larger pegs
//translate([10,75,-3]) gear(number_of_teeth=11, circular_pitch=400, hub_thickness=0, bore_diameter=8.5,rim_thickness=3, gear_thickness=3);
