include <gearLib.scad>

module lidBase(x,y,z)
{
	translate([x,y,z]) cube([106,51,1.5]);
	translate([x, y-1.5, z+1.5]) cube([106,54,2.5]);
	translate([x, y, z+1.5]) cube ([1.5,51,43]);
}

module lidCutouts(x,y,z)
{
	translate([x+53, y+25.5, z+1.5]) cylinder(h = 2.5,r = 18);
	translate([x, y+5, z+1.5]) cube([101,12,2]);
	translate([x+5, y+49-12, z+1.5]) cube([101,12,2]);
}

module lid(x,y,z)
{
	difference()
	{
		lidBase(x,y,z);
		lidCutouts(x,y,z);
	}
	translate([x+53,y+25.5,z+1.5]) cylinder(h = 1.5,r = 4);
}

module drawGear(x,y,z)
{
	difference() 
	{
		translate([x,y,z]) cylinder(h = 0.5,r = 17);
		translate([x,y,z]) cylinder(h = 0.5,r = 5);
	}
	//14.5 radius
	translate([x, y, z+0.5]) gear(number_of_teeth=11, circular_pitch=400, hub_thickness=0, bore_diameter=9,rim_thickness=2, gear_thickness=2);
}

module drawLeftRack(x,y,z)
{
	translate([x,y,z+(1.5/2)]) rack(height=10, mm_per_tooth=6.2, number_of_teeth=13, thickness=1.5);
	translate([x+79,y-8.1,z]) cube([22,6,1.5]);
	translate([x+101,y-8-5,z]) cube([1.5,51,10]);
}

module drawRightRack(x,y,z)
{

	translate([x+22+79,y,z+(1.5/2)]) rotate([0,0,180]) rack(height=10, mm_per_tooth=6.2, number_of_teeth=13, thickness=1.5);
	translate([x,y+2,z]) cube([22,6,1.5]);
	difference()
	{
		translate([x-9,y-51+11,z]) cube([9,48,10]);
		translate([x-7.5,y-51+13,z+2]) cube([7.5,44,6]);
		translate([x-7.5,y-51+13,z]) cube([6,40,8]);
	}
}


module drawLidAssembled(x,y,z)
{
	lid(x,y,z);
	drawGear(x + 53, y+25.5, z+1.5);
	rotate([0,180,0]) drawLeftRack(x-96, y+14, z-3.5);
	rotate([0,180,0]) drawRightRack(x-111, y+37, z-3.5);
}

module drawLidExploded(x,y,z)
{
	lid(x,y,z);
	drawLeftRack(x+5, y+80, z);
	drawGear(x + 53, y+105, z);
//	drawRightRack(x, y+130, z);
	rotate([270,0,0]) drawRightRack(x+10, z-7.5, y+130);
}

drawLidAssembled(0, 0, 0);
drawLidExploded(0, 100, 0);
//drawLidExploded(0, 0, 0);

//	drawGear(51, 20, 0);
//	drawRightRack(0, 0, 0);