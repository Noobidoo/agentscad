/*
 * Copyright (c) 2019, Gilles Bouissac
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 *   * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 *   * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * 
 * Description: BSW screw modelisation
 * Author:      Gilles Bouissac
 */
use <agentscad/lib-screw.scad>
use <agentscad/bsw-screw.scad>

// ----------------------------------------
//          Animation params:
//            fps:   10
//            steps: 100
// ----------------------------------------

ALL_SCREW  = [for ( idx=[0:bswGetDataLength()-1] ) bswData( idx ) ];

// Modulo
function mod(a,m) = a - m*floor(a/m);
module showcaseAnimated() {

    translate( [0,0,0] ) {

        idx=floor($t*len(ALL_SCREW));
        screw = ALL_SCREW[idx];

        translate( [1.5*screwGetHeadDP(screw),0,4*screwGetHeadLP(screw)] )
            color( "gold" )
            rotate( $vpr )
            linear_extrude(1)
            text( screwGetName(screw), halign="center", valign="center", size=screwGetThreadD(screw) );
        rotate( [180,0,0] )
        translate( [0,screwGetHeadDP(screw)/1.5,0] ) {
            translate( [3*screwGetHeadDP(screw),0,0] ) {
                color( "red", 0.5 )
                    bswBoltPassage( bswClone(screw,tlp=3) );
                translate( [0,0,+screwGetThreadL(screw)-screwGetHeadLP(screw)/2] )
                    color( "silver", 0.5 )
                    bswNutPassage( screw );
            }
            translate( [1.5*screwGetHeadDP(screw),0,0] ) {
                color( "red", 0.5 )
                    bswBoltAllenPassage( bswClone(screw,tlp=3) );
                translate( [0,0,+screwGetThreadL(screw)-screwGetHeadLP(screw)/2] )
                    color( "silver", 0.5 )
                    bswNutPassage( screw );
            }
            bswBoltAllen( screw );
            translate( [0,0,+screwGetThreadL(screw)-screwGetSquareHeadL(screw)/2] )
                color( "cyan", 0.5 )
                bswNutSquare( screw );
        }
        rotate( [180,0,0] )
        translate( [0,-screwGetHeadDP(screw)/1.5,0] ) {
            translate( [3*screwGetHeadDP(screw),0,0] ) {
                color( "red", 0.5 )
                    bswBoltPassage( bswClone(screw,tlp=3) );
                translate( [0,0,+screwGetThreadL(screw)-screwGetHeadLP(screw)/2] )
                    color( "silver", 0.5 )
                    bswNutPassage( screw );
            }
            translate( [1.5*screwGetHeadDP(screw),0,0] ) {
                color( "red", 0.5 )
                    bswBoltHexagonalPassage( bswClone(screw,tlp=3) );
                translate( [0,0,+screwGetThreadL(screw)-screwGetHeadLP(screw)/2] )
                    color( "silver", 0.5 )
                    bswNutPassage( screw );
            }
            bswBoltHexagonal( screw );
            translate( [0,0,+screwGetThreadL(screw)-screwGetSquareHeadL(screw)/2] )
                color( "cyan", 0.5 )
                bswNutHexagonal( screw );
        }
    }
}

showcaseAnimated ($fn=100);

