/* helpers */
SMOOTH_FACETS = 240;
MINIMUM_SURFACE_GAP = 0.5;

/* discrete parameters */
spherical = false;
facets = spherical ? SMOOTH_FACETS / 2 : SMOOTH_FACETS;
count = 6;

/* dimensions */
initial_radius = 16;
zradius = 10;
chevron_shrink = 3.1;
wall_thick = spherical ? 1 : 1.4;
gap = spherical ? MINIMUM_SURFACE_GAP : 2;

step = gap + wall_thick;

/* special options */
preview_cut = false;

difference() {
    main();
    
    if (preview_cut)
    translate([0, 0, -500])
    cube([1000, 1000, 1000]);
}


module main() {
    for (i = [0:count - 1]) {
        radius = initial_radius + i * step;
        unit(radius);
    }
}

module unit(r2) {
    
    if (spherical) {
        intersection() {
            difference() {
                sphere(r = r2, $fn = facets);
                sphere(r = r2 - wall_thick, $fn = facets);
            }
            cube([r2 * 3, r2 * 3, zradius * 2], center=true);
        }
    } else {
        r1 = r2 - chevron_shrink;
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