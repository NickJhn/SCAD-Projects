fps = 25;
time = 30;
frames = fps*time;
echo(frames);
function animate(t1, t2) = max(0,min(1,(($t*frames-(t1))/(t2-t1))));
time_a  = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30];

a1 = animate(fps*time_a[ 1], fps*time_a[ 2]);
a2 = animate(fps*time_a[ 2], fps*time_a[ 3]);
a3 = animate(fps*time_a[ 3], fps*time_a[ 4]);
a4 = animate(fps*time_a[ 4], fps*time_a[ 5]);
a5 = animate(fps*time_a[ 5], fps*time_a[ 6]);
a6 = animate(fps*time_a[ 6], fps*time_a[ 7]);
a7 = animate(fps*time_a[ 7], fps*time_a[ 8]);
a8 = animate(fps*time_a[ 8], fps*time_a[ 9]);
a9 = animate(fps*time_a[ 9], fps*time_a[10]);
a10= animate(fps*time_a[10], fps*time_a[11]);
a11= animate(fps*time_a[11], fps*time_a[12]);
a12= animate(fps*time_a[12], fps*time_a[13]);
a13= animate(fps*time_a[13], fps*time_a[14]);
a14= animate(fps*time_a[14], fps*time_a[15]);
a15= animate(fps*time_a[15], fps*time_a[16]);
a16= animate(fps*time_a[16], fps*time_a[17]);
a17= animate(fps*time_a[17], fps*time_a[18]);
a18= animate(fps*time_a[18], fps*time_a[19]);
a19= animate(fps*time_a[19], fps*time_a[20]);
a20= animate(fps*time_a[20], fps*time_a[21]);
a21= animate(fps*time_a[21], fps*time_a[22]);
a22= animate(fps*time_a[22], fps*time_a[23]);
a23= animate(fps*time_a[23], fps*time_a[24]);
a24= animate(fps*time_a[24], fps*time_a[25]);
a25= animate(fps*time_a[25], fps*time_a[26]);
a26= animate(fps*time_a[26], fps*time_a[27]);
a27= animate(fps*time_a[27], fps*time_a[28]);
a28= animate(fps*time_a[28], fps*time_a[29]);
a29= animate(fps*time_a[29], fps*time_a[30]);



bedheight = 7.4*a3 - 4*a6+ 4*a8 + 2.1*a10 + 1.4*a15 +1.8*a20;
bedtilt = 8*a13 -8*a17;
bed_x_pos = 15 -30*a9 -5*a11 + 55*a14 +10*a16 -65*a17;
servoangle = 90 -61.5* a2 - 28.5*a5 +24*a19 + 66*a21;

module servo() {
  translate([0,4,0])
  {
    translate([0,-3.02,0]) rotate([90,0,0]) color("white") cylinder(r=15, h=1);
    translate([0,1,0]) rotate([90,0,0]) cylinder(r=3, h=5);
    translate([-10,0,-5]) color([0.3,0.3,0.3]) cube([28,20,10]);
  }
}

module switch() {
  translate([0,0,4]) {
    translate([-25,-5,0]) color("blue") cube([30,10,12]);
    color("green")translate([0,0,-2+((servoangle==0)?max(5-bedheight,0):0)]) {
      cylinder(r=2,h=5, $fn=16);
      sphere(r=2, $fn=16);
    }
    color([((servoangle==0)&&(bedheight<3.5))?1:0.4,0,0]) translate([-10,0,13]) rotate([0,180,0]) {
      cylinder(h=3,d=3,$fn=16);
      sphere(d=3,$fn=16);
    }
  }
}

module hotend() {
  translate([-32,15,-45]) rotate([0,0,180]) {
    color("silver") {
      // cooler
      //   disks
      translate([0,0,53]) cylinder(h=1,d=25,$fn=16);
      translate([0,0,50]) cylinder(h=1,d=25,$fn=16);
      translate([0,0,47]) cylinder(h=1,d=25,$fn=16);
      translate([0,0,44]) cylinder(h=1,d=25,$fn=16);
      translate([0,0,41]) cylinder(h=1,d=25,$fn=16);
      translate([0,0,38]) cylinder(h=1,d=25,$fn=16);
      translate([0,0,35]) cylinder(h=1,d=25,$fn=16);
      translate([0,0,32]) cylinder(h=1,d=25,$fn=16);
      translate([0,0,29]) cylinder(h=1,d=25,$fn=16);
      translate([0,0,26]) cylinder(h=1,d=25,$fn=16);
      //   center
      translate([0,0,25]) cylinder(h=28,d=10,$fn=12);
      //heatbreak
      translate([0,0,15]) cylinder(h=10,d=6,$fn=12);
      // block
      translate([-5,-5,8]) cube([15,10,10]);
      // heater
      translate([6,10,13]) rotate([90,0,0]) cylinder(h=20,d=6,$fn=12);
    }
    color("gold") {
    // nozzle
      translate([0,0,6]) cylinder(h=2,d=6,$fn=12);
      translate([0,0,3]) cylinder(h=3,d=8,$fn=6);
      cylinder(h=3,d1=1,d2=6,$fn=12);
    }
  }
}

module arm() {
    translate([-5,-1,5]) {
        cube([10,1,55]);
        translate([-8,0,0]) cube([18,1,10]);
    }
}

module bed() {
  translate([bed_x_pos,0,-bedheight+5]) rotate([0,bedtilt,0]) {
    color("red") translate([0,0,-50.5]) cube([100-20*a3,50,1],center = true);
    // screw
    color("red") translate([20,5.5,-50.5]) cylinder(r=2.5, h=5);
  }
}

// arm & swich
translate([0,1,-50]) {
    translate([0,0,50]) servo();
    translate([0,0,50]) rotate([0,-servoangle,0]) translate([0,0,-50]) {
        translate([0,5,0]) switch();
        arm();
    }
}
/* Disks
color([0.5,0.5,0.5,0.6]) rotate([90,0,0]) cylinder(h=1,r=50,$fn=64);
color([0.5,0.5,0.5,0.3]) rotate([90,0,0]) cylinder(h=1,r=52.5,$fn=64);
color([0.5,0.5,0.5,0.8]) rotate([90,0,0]) cylinder(h=1,r=48,$fn=64);
*/
// bed
bed();

hotend();

color([1.0,1.0,1.0,a1]) translate([-40,0,-44.3]) rotate([90,0,180]) text("_Null",5);
color([1.0,1.0,1.0,a4-a23]) translate([65,0,-51.7]) rotate([90,0,180]) text("Deploy_",5);
color([1.0,1.0,1.0,a7]) translate([-40,0,-47.7]) rotate([90,0,180]) text("_____Z_PROBE_OFFSET_FROM_EXTRUDER",5);
color([1.0,1.0,1.0,a9-a12]) translate([80,0,-70]) rotate([90,0,180]) text("There may be an screw",6);
color([1.0,1.0,1.0,a12-a17]) translate([80,0,-70]) rotate([90,0,180]) text("or a tilt bed",6);
color([1.0,1.0,1.0,a18-a23]) translate([-60,0,-55.2]) rotate([90,0,180]) text("_Travel_Height",5);
color([1.0,1.0,1.0,a22-a23]) translate([40,0,-56.9]) rotate([90,0,180]) text("Stow_",5);
color([1.0,1.0,1.0,a23]) translate([95,0,-56.9]) rotate([90,0,180]) text("Unified_Savety_Height_",5);
color([1.0,1.0,1.0,a24]) translate([80,0,-70]) rotate([90,0,180]) text("Regardles of the type of your probe",6);
color([1.0,1.0,1.0,a24]) translate([80,0,-80]) rotate([90,0,180]) text("You can find one minimal save hight!",6);
