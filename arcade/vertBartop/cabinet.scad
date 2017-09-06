scale([1/2.54, 1/2.54, 1/2.54]) {
    scale([1, 1, 1]) {
        
        t = 2.54/2;
        w = 39;
        backH = 61.21;
        bottomD = 46.5;
        marqueH = 12;
        frontH = 43 + marqueH;
        
        
        union() {
            // CP Front
            color("lightgray") translate([0, t, 0]) rotate([90,0,0]) cube([w,9.9,t]);
            // Bottom
            color("slategray") translate([0, 0, -t]) cube([w,bottomD,t]);
            // Back
            color("black") translate([0, bottomD, 0]) rotate([90,0,0]) cube([w,backH,t]);
            
            // Marque/Screen Assembly
            translate([0, bottomD, backH]) rotate([180-26.25,0,0]) {
                // Top
                color("blue") cube([w,14.43,t]);
                // Marque
                color("yellow") translate([0, 14.43+t, 0]) rotate([90,0,0]) cube([w,marqueH,t]);
                // Marque Bottom
                color("cyan") translate([0, 14.43, marqueH]) rotate([180,0,0]) cube([w,8,t]);
                // Front
                color("green") translate([0, 14.43-8, t]) rotate([90,0,0]) difference() {
                    cube([w,frontH,t]);
                    translate([w/2, marqueH/2+frontH/2-t/2, t/2]) cube([32.5, 39.5, t+1], true);
                }
                // CP
                color("magenta") 
                    translate([0, 14.48-8-t/2, t+43+marqueH-t/2]) 
                    rotate([127.5-90,0,0]) 
                    cube([w,18.56,t]);
            }

        }
    }
}