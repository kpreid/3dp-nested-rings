zsize = 10;
shrink = 3;
wall_thick = 1;
gap = 2;

step = gap + wall_thick;

$fn = 12;

for (i = [3:10]) {
    unit(i * step);
}

module unit(d2) {
    d1 = d2 - shrink;
    
    //linear_extrude(2)
    rotate_extrude()
    polygon([
        [d1, zsize],
        [d2, 0],
        [d1, -zsize],
        [d1 - wall_thick, -zsize],
        [d2 - wall_thick, 0],
        [d1 - wall_thick, zsize],
    ]);
}