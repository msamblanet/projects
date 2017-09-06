// ********************************************
// Layer Selection...
renderThroughHoles = true; // Mill entirely through part
renderDrillPoints = true; // Mark points for drilling
renderBackRecesses = true; // Just enough to help alignment
renderFrontRecesses = true; // About 5/16"
// ********************************************

size = [18.56/2.54, 39/2.54];
lip = [2, 1.75];
$fn = 360;
drillMarkRadius = 1/32;

module button() {
    difference() {
        if (renderBackRecesses) circle(13/16);
        if (renderThroughHoles) circle(9/16);
    }
}

module buttonPair() {
    button();
    translate([1.5, 0]) button();
}

module sixButtonArray() {
    translate([     0,     0]) buttonPair();
    translate([-11/16, 21/16]) buttonPair();
    translate([- 5/16, 44/16]) buttonPair();
}

module eightButtonArray() {
    translate([     0,     0]) buttonPair();
    translate([-11/16, 21/16]) buttonPair();
    translate([- 5/16, 44/16]) buttonPair();
    translate([     0, 67/16]) buttonPair();
}

module js() {
    button();
    
    if (renderDrillPoints) translate([-23/16,-15/16]) circle(drillMarkRadius);
    if (renderDrillPoints) translate([ 23/16,-15/16]) circle(drillMarkRadius);
    if (renderDrillPoints) translate([-23/16, 15/16]) circle(drillMarkRadius);
    if (renderDrillPoints) translate([ 23/16, 15/16]) circle(drillMarkRadius);
    
    if (renderBackRecesses) difference() { 
        square([3+25/32, 2.5], true);
        if (renderThroughHoles || renderDrillPoints) square([3+25/32-1/8, 2.5-1/8], true);
    }
}

module spinner() {
    button();
    if (renderDrillPoints) translate([ (7/8-5/64), (7/8-5/64)]) circle(drillMarkRadius);
    if (renderDrillPoints) translate([-(7/8-5/64), (7/8-5/64)]) circle(drillMarkRadius);
    if (renderDrillPoints) translate([ (7/8-5/64),-(7/8-5/64)]) circle(drillMarkRadius);
    if (renderDrillPoints) translate([-(7/8-5/64),-(7/8-5/64)]) circle(drillMarkRadius);
    if (renderBackRecesses) difference() {
        square([2,2], true);
        if (renderThroughHoles || renderDrillPoints) square([2-1/8,2-1/8], true);
    }
}

module coinSlot() {
    // Coin slot - Recess 5/16"?
    size = [2+11/32, 2+5/32];
    translate([size[0]/2, size[1]/2]) rotate(180, 0)
        translate([-size[0]/2, -size[1]/2]) {
            if (renderFrontRecesses) difference() {
                r = 1/8;
                hull() {
                    translate([        r,r]) circle(r);
                    translate([size[0]-r,r]) circle(r);
                    translate([        r,size[1]-r]) circle(r);
                    translate([size[0]-r,size[1]-r]) circle(r);
                    
                }
                if (renderThroughHoles || renderDrillPoints) translate([r/2, r/2]) square([size[0]-r, size[1]-r]);
            }
            if (renderThroughHoles) translate([53/64, 11/32]) square([1+3/32,9/64]);
            if (renderThroughHoles) translate([81/128, 111/128]) square([1+37/128,1+3/64]);

            if (renderDrillPoints) translate([3/8-13/128,1/4-13/128]) circle(drillMarkRadius);
            if (renderDrillPoints) translate([3/8-13/128,1+33/64-13/128]) circle(drillMarkRadius);
            if (renderDrillPoints) translate([2+11/64-13/128,1/4-13/128]) circle(drillMarkRadius);
            if (renderDrillPoints) translate([2+11/64-13/128,1+33/64-13/128]) circle(drillMarkRadius);
        }
}

module tb() {
    union() {
        if (renderBackRecesses) difference() {
            square([183/32,183/32], true);
            if (renderThroughHoles || renderDrillPoints) square([183/32-1/8, 183/32-1/8], true);
        }
        if (renderThroughHoles) circle(d=3+3/8);
        
        rotate([0,0,45]) {
            if (renderDrillPoints) translate([ 205/128, 205/128]) circle(drillMarkRadius);
            if (renderDrillPoints) translate([-205/128, 205/128]) circle(drillMarkRadius);
            if (renderDrillPoints) translate([ 205/128,-205/128]) circle(drillMarkRadius);
            if (renderDrillPoints) translate([-205/128,-205/128]) circle(drillMarkRadius);
        }
        
    }
}

module registrationPins() {
    if (renderThroughHoles) translate([1/4, 0.5]) circle(d=1/8);
    if (renderThroughHoles) translate([1/4, 1]) circle(d=1/8);

    if (renderThroughHoles) translate([1/4, 8.5]) circle(d=1/8);
    if (renderThroughHoles) translate([1/4, 9]) circle(d=1/8);
}

difference() {   
    lastButtonPos = size[1]-lip[1]-9/16-67/16;
    buttonPos = size[1]-lip[1]-9/16-44/16;
    //spinPos = 3;
    //jsPos = (buttonPos + spinPos) / 2;
    //tbPos = (buttonPos + jsPos) / 2;
    jsPos = 3;
    spinPos = (jsPos + buttonPos) / 2;
    
    square(size);
    //registrationPins();   
    translate([5/8,0]) coinSlot();
    translate([size[0]-lip[0]-9/16-1.5, 0]) {
        translate([0, spinPos]) spinner();
        translate([1.5, jsPos]) rotate([0,0,90]) js();
        //translate([0, tbPos]) tb();
        //translate([0, size[1]-lip[1]-9/16-67/16]) eightButtonArray();
        translate([0, buttonPos]) sixButtonArray();
    }
}

