

include <chainmail_module.scad>;

for (x = [0 : 1]) {
    for (y = [0 : 1]) {
        for (z = [0 : 2]) {
            translate([x, y, z])
            chainMailTile();
        }
    }
}
        