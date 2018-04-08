/* discrete parameters */
facets = 240;
count = 6;

/* dimensions */
initial_radius = 16;
zradius = 10;
shrink = 3.1;
initial_wall_thick = 0.8;
gap = 2.2;

step = gap + initial_wall_thick;


for (i = [0:count - 1]) {
    radius = initial_radius + i * step;
    unit(radius, initial_wall_thick * (radius / initial_radius));
}

module unit(d2, wall_thick) {
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