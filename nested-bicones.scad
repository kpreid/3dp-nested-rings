/* helpers */
SMOOTH_FACETS = 240;
MINIMUM_SURFACE_GAP = 0.6;  // 0.5 works but requires some breaking away and does not spin smoothly

/* discrete parameters */
spherical = true;
facets = spherical ? SMOOTH_FACETS / 2 : SMOOTH_FACETS;
count = 6;

/* dimensions */
initial_radius = 23;
zradius = 10;
chevron_shrink = 3.1;
wall_thick = 1.4;
gap = spherical ? MINIMUM_SURFACE_GAP : 2;
internal_sphere_notch_zradius = 3;
internal_sphere_notch_wall_thick = 0.6;

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
        rotate_extrude($fn = facets)
        intersection() {
            difference() {
                circle(r = r2, $fn = facets);
                circle(r = r2 - wall_thick, $fn = facets);
                
                if (internal_sphere_notch_zradius > 0) {
                    minkowski() {
                        intersection() {
                            circle(r = r2 - wall_thick, $fn = facets);

                            translate([0, -internal_sphere_notch_zradius])
                            square([r2 * 1.5, internal_sphere_notch_zradius * 2]);
                        }
                        
                        // diamond shape to create 45° overhangs
                        circle(r=wall_thick - internal_sphere_notch_wall_thick, $fn=4);
                    }
                }
            }
            
            translate([0, -zradius])
            square([r2 * 1.5, zradius * 2]);
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