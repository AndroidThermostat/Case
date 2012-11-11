include <gearLib.scad>

rack_and_pinion_thickness = 3;
rack_and_pinion_cover_thickness = 2;
phone_grip_thickness = 13;
rack_phone_grip_thickness = rack_and_pinion_thickness + rack_and_pinion_cover_thickness + phone_grip_thickness;

module top_rack()
{
	translate([-6.2*3,0,rack_and_pinion_thickness/2])
	rack(height=10, mm_per_tooth=6.2, number_of_teeth=13, thickness=rack_and_pinion_thickness);

	translate([-24.5,-5,rack_and_pinion_thickness/2])
	cube([40,6,rack_and_pinion_thickness], center=true);

	translate([-45,32-36,rack_phone_grip_thickness/2])
	cube([3.5,80,rack_phone_grip_thickness], center=true);
}

module bottom_rack()
{
	translate([-6.2*3,0,rack_and_pinion_thickness/2])
	rack(height=10, mm_per_tooth=6.2, number_of_teeth=13, thickness=rack_and_pinion_thickness);

	translate([-24.5,-5,rack_and_pinion_thickness/2])
	cube([40,6,3], center=true);

	translate([-45,32,rack_phone_grip_thickness/2])
	cube([3.5,80,rack_phone_grip_thickness], center=true);
}

module pinion_gear()
{
	gear(number_of_teeth=11, circular_pitch=400, hub_thickness=0, bore_diameter=6,rim_thickness=3, gear_thickness=3);
}

module plate()
{
	translate([0,-20,0]) top_rack();
	translate([20,20,0]) rotate([0,0,180]) bottom_rack();
	translate([27,0,0]) pinion_gear();
	translate([0,0,0]) pinion_gear();
}

plate();