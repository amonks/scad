include <chainmail_module.scad>;

for (x = [0 : 2]) {
    for (y = [0 : 2]) {
        for (z = [0 : 2]) {
            translate([x, y, z])
            chainMailTile();
        }
    }
}
        