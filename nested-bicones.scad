/* helpers */
SMOOTH_FACETS = 240;

/* discrete parameters */
facets = SMOOTH_FACETS;
count = 6;
spherical = true;

/* dimensions */
initial_radius = 28 / 2;  // finger hole
zradius = 10;
shrink = 3;
wall_thick = 1;
gap = spherical ? 0.5 : 2;

step = gap + wall_thick;


for (i = [0:count - 1]) {
    unit(initial_radius + i * step);
}

module unit(r2) {
    r1 = r2 - shrink;
    
    if (spherical) {
        intersection() {
            difference() {
                sphere(r = r2, $fn = facets);
                sphere(r = r2 - wall_thick, $fn = facets);
            }
            cube([r2 * 3, r2 * 3, zradius * 2], center=true);
        }
    } else {
        //linear_extrude(2)
        rotate_extrude($fn = facets)
        polygon([
            [r1, zradius],
            [r2, 0],
            [r1, -zradius],
            [r1 - wall_thick, -zradius],
            [r2 - wall_thick, 0],
            [r1 - wall_thick, zradius],
        ]);
    }
}