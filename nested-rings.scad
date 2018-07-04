// Variables' comments formatted for Thingiverse Customizer.

// Style of rings. Biconical rings can slide axially as well as tumbling; spherical rings are close-fitting and more likely to jam.
type = "biconical";  // [biconical:Biconical, spherical:Spherical]

// Number of rings to generate. The size is determined starting from the center, so more rings is larger.
ring_count = 6;

// Radius of the midline of the smallest ring. The opening will be smaller than this depending on the type.
initial_radius = 16;

/* dimensions */
zradius = 10;
chevron_shrink = 3.1;
wall_thick = 1.4;
internal_sphere_notch_zradius = 3;
internal_sphere_notch_wall_thick = 0.6;


/* special options */
preview_cut = false;

/* [Hidden] */

spherical = type == "spherical";  // may be more than one sphere-ish type

// Chosen constants and not-exposed calculations
SMOOTH_FACETS = 240;
MINIMUM_SURFACE_GAP = 0.6;  // 0.5 works but requires some breaking away and does not spin smoothly
gap = spherical ? MINIMUM_SURFACE_GAP : 2;
facets = spherical ? SMOOTH_FACETS / 2 : SMOOTH_FACETS;  // make spheres somewhat less super-expensive

// Derived values
step = gap + wall_thick;


difference() {
    main();
    
    if (preview_cut)
    translate([0, 0, -500])
    cube([1000, 1000, 1000]);
}


module main() {
    for (i = [0:ring_count - 1]) {
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