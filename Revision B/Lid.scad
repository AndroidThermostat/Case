include <gearLib.scad>


//**********************************Lid***************************************************
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



//*****************************Rack and Pinion*******************************************

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
	translate([x+101,y-8-5,z]) cube([1.5,46,10]);
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





//*****************************Case***************************************************


module drawCase(x,y,z)
{
	height=47;
	length=104.5;

	stepsH=(height-16)/6;
	stepsL=(length-12)/12;

	translate([x+1.5,y+3,z]) cube([104.5,51,1.5]);
	difference() {
		union(){
			translate([x,y,z]) cube([106,3,height]);
			translate([x,y+54,z]) cube([106,3,height]);
		}
		for(iL=[0:stepsL])
		{
			for(iH=[0:stepsH])
			{
				//first wall
				translate([x+6 + iL*12,y,z+3 + iH*6]) cube([3,3,3]);
				translate([x+6 + iL*12 + 6,y,z+6 + iH*6]) cube([3,3,3]);
				//second wall
				translate([x+6 + iL*12,y+54,z+3 + iH*6]) cube([3,3,3]);
				translate([x+6 + iL*12 + 6,y+54,z+6 + iH*6]) cube([3,3,3]);
			}
		}
		translate([x,y+1.5,z+43]) cube([106,1.5,2.5]);
		translate([x,y+54,z+43]) cube([106,1.5,2.5]);
	}
	difference()
	{
		translate([x+106,y,z]) cube([1.5,57,43]);
		translate([x+106,y+23,39]) cube([1.5,10,4]);
	}
	translate([x+(length-20)/2,y,z+height]) cube([20,3,10]);
	translate([x+(length-20)/2,y,z+height+10]) cube([20,5,2]);
}








//*****************************Combinations**********************************************


module drawAssembled(x,y,z)
{
	drawCase(x,y,z);
	rotate([180,0,0]) drawLidAssembled(x,y-54.5,-z - 47);
}

module drawLidAssembled(x,y,z)
{
	lid(x,y,z);
	drawGear(x + 53, y+25.5, z+1.5);
	rotate([0,180,0]) drawLeftRack(-x-96, y+14, -z-3.5);
	rotate([0,180,0]) drawRightRack(-x-111, y+37, -z-3.5);
}

module drawExploded(x,y,z)
{
	% translate([x,y,z-1]) cube([180,150,1]);
	lid(x,y,z);
	drawLeftRack(x+5, y+80, z);
	drawGear(x + 53, y+105, z);
	rotate([270,0,0]) drawRightRack(x+10, -z - 8, y+130);
	rotate([0,0,90]) drawCase(y,-x-170,z);
}



drawAssembled(0, 0, 0);
drawExploded(0, 100, 0);
