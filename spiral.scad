count = 1000;
length = 500.0;
resolution = 20;
mouthpiece_radius = 0.5;
mouthpiece_length = 4.0;

module horn(x, y, z, theta, r) {
    translate([x, y, z])
        rotate([0, 0, theta])
        sphere(r, $fn = resolution); 
}
for (t = [0:count]) {
    i = (t / count) * length;
    theta = i * 1.0;
    a = i / 49.0;
    x = cos(theta) * a;
    y = sin(theta) * a;
    z = i * -0.03;
    r = pow(2, i / 300.0) + mouthpiece_radius;
    
    difference() {
//        difference() {
            horn(x, y, z, theta, r);
//            horn(x, y, z, theta, r / 2);
//        };
        translate([0, 0, -5])
            scale([1, 1, 10])
            cylinder(mouthpiece_length, r / 8.0, r / 8.0, $fn = resolution * 4.0);
    }
    
    if (t == 0) {  
        difference() {
            cylinder(mouthpiece_length, r, r, $fn = resolution * 4.0);
            scale([1, 1, 2])
                cylinder(mouthpiece_length, r / 2.0, r / 2.0, $fn = resolution * 4.0);
        }
    }  
}