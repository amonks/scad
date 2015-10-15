union() {
    extrusions(32, 2, 0, 32, 1, 1, true);
}



module extrusions(points, height, twist, slices, r, scale, center) {
    union() {
        for (i = [1:points]) {
            theta = (i / points) * 360;
            translate([
                r * cos(theta),
                r * sin(theta),
                0
            ])
                rotate([theta, theta, 0])
                    cube(2, true);
        }
    }   
}