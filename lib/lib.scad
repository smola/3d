/**
 * Utilities.
 * This library is meant to be used with OpenSCAD 2017.01 or newer.
 * 'assert' module should be enabled in Edit -> Preferences,
 * otherwise, the build will produce warnings.
 * These should work with 2015.03, but not warning-free.
 *
 *
 * License: MIT
 * Copyright © 2018 Santiago M. Mola
 */

/**
 * distance(a, b) computes the euclidiean distance between two points
 * a and b.
 */
function distance(a, b) =
    sqrt(
        pow(a.x - b.x, 2) +
        pow(a.y - b.y, 2) +
        pow(a.z - b.z, 2)
    );

assert(distance([0, 0, 0], [0, 0, 0]) == 0);
assert(distance([0, 0, 0], [1, 0, 0]) == 1);
assert(distance([1, 2, 30], [3, 4, -3]) == sqrt(1097));

/**
 * angle(a, b) computes the angle between two vectors a and b.
 */
function angle(a, b) = atan2(norm(cross(a, b)), a * b);

assert(angle([1, 0, 0], [0, 1, 0]) == 90);
assert(angle([-1, 0, 0], [0, -1, 0]) == 90);
assert(round(angle([3, 4, 5], [10, 2, 8]) * 1000) == 31674);

/**
 * circumradius(a, b, c) computes the circumradius of the circumcircle crossing
 * 3 points.
 */
function circumradius(a, b, c) =
    let (
        b1 = b - a,
        c1 = c - a
    ) 0.5 *
    norm(b1) * norm(c1) * norm(c1 - b1) /
    norm(cross(b1, c1));

assert(round(circumradius(
    [1, 2, 3], [2, 5, 1], [-5, 1, -2])
    * 100000) == 430364);

