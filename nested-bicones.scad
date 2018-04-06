/* discrete parameters */
facets = 240;
count = 6;

/* dimensions */
initial_radius = 28 / 2;
zradius = 10;
shrink = 3;
wall_thick = 1;
gap = 2;

step = gap + wall_thick;


for (i = [0:count - 1]) {
    unit(initial_radius + i * step);
}

module unit(d2) {
    d1 = d2 - shrink;
    
    //linear_extrude(2)
    rotate_extrude($fn = facets)
    polygon([
        [d1, zradius],
        [d2, 0],
        [d1, -zradius],
        [d1 - wall_thick, -zradius],
        [d2 - wall_thick, 0],
        [d1 - wall_thick, zradius],
    ]);
}