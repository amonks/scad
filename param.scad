// edit this stuff

difference() {
    ring(8, 2.5, [1.5, 1.5, 1.5]);
    ring(128, 8, [0.8, 0.8, 0.8]);
}
 

module ring(count, radius, cubeScale) {
    union() {
        for(i = [1:count]) {
            rotay = (i / count) * 720;

            r = radius;
            theta = (i / count) * 360;
            u = r * cos(theta);
            
            translate(sphereTranslation(r, theta, u))
                rotate([rotay, rotay, rotay])
                    scale(cubeScale)
                        cube(5, true);
        }
    }
}
 

// see http://mathworld.wolfram.com/Sphere.html
function sphereTranslation(r, theta, u) =
    [
        sqrt((r*r) - (u*u)) * sin(theta),
        sqrt((r*r) - (u*u)) * cos(theta),
        u
    ];