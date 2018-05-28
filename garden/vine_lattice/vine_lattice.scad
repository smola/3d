/**
 * Adjustable scaffold for climbing plants.
 *
 * License: MIT
 * Copyright © 2018 Santiago M. Mola
 */

support_stick_width = 4;
support_stick_height = 30;
support_spike_height = 45;

scaffold_length = 130;
scaffold_width = 3;
scaffold_height = 120;
scaffold_rows = 3;
scaffold_cols = 3;

// Support stick
module support_stick(w, h1, h2) {
    // Stick
    cube([w, w, h1]);

    // Spike
    polyhedron(
        points = [
            [0, 0, 0],
            [0, w, 0],
            [w, w, 0],
            [w, 0, 0],
            [0, w / 2, -1 * h2]
        ],
        faces = [
            [0, 1, 2, 3],
            [4, 1, 0],
            [4, 2, 1],
            [4, 3, 2],
            [4, 0, 3]
        ]
    );
}

// Grid defined by length (l), height (h) and width (w), number of rows
// and number of columns.
module grid(l, h, w, rows, cols) {
    // Rows
    row_height = h / rows;
    for (row = [0:rows])
        translate([0, 0, row * row_height])
            cube([w, l, w]);

    // Columns
    col_width = l / cols;
    for (col = [0:cols])
        translate([0, col * col_width, 0])
            cube([w, w, h]);
}

module frame(l, h, w) {
    cube([w, l, w]);
    translate([0, 0, h - w])
        cube([w, l, w]);
    cube([w, w, h]);
    translate([0, l - w, 0])
        cube([w, w, h]);
}

// Scaffold defined by length (l), height (h), outer width (ow) and inner width (iw).
module scaffold(l, h, ow, iw, rows, cols) {
    // Outer frame
    frame(l, h, ow);

    // Inner frame dimensions
    iy0 = ow - iw;
    iz0 = ow - iw;
    il = l - ow * 2 + iw;
    ih = h - ow * 2 + iw;
    
    // Grid
    translate([0, iy0, iz0])
        grid(il, ih, iw, rows, cols);

}

translate([scaffold_height, 0, 0]) {
    rotate([0, -90, 0]) {
        translate([0, 0, -1 * support_stick_height])
            support_stick(support_stick_width, support_stick_height, support_spike_height);
        translate([0, scaffold_length - support_stick_width, -1 * support_stick_height])
            support_stick(support_stick_width, support_stick_height, support_spike_height);

        scaffold(scaffold_length, scaffold_height, support_stick_width, scaffold_width, scaffold_rows, scaffold_cols);
    }
}
