union() {
    chainmail(5, 5, 0, 3, 30);
}

module chainmail(width, height, depth, distance, angle) {
    for (x = [0 : width]) {
        for (y = [0 : height ]) {
            for (z = [0 : depth]) {
                translate([x * distance, y * distance, z * distance])
                    ring(3, 0.5, 20, [
                        (x % 2) * angle * 2 - angle, 
                        (y % 2) * angle * 2 - angle, 
                        (z % 2) * angle * 2 - angle
                    ]);
            }
        }
    }
}

module ring(radius, thickness, resolution, rotation) {
    rotate(rotation)
        rotate_extrude($fn = resolution)
            translate([radius, 0, 0])
                circle(thickness, $fn = resolution);
}