

////
// AUTOMATICALLY GENERATED FILE
//
// this file [chainmail.scad] is generated from [chainmail.scad.erb]. Don't edit it directly.

////
// Copyright (c) 2015, Andrew Monks
//
// Permission to use, copy, modify, and/or distribute this software for any purpose
// with or without fee is hereby granted, provided that the above copyright notice
// and this permission notice appear in all copies.
//
// THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
// REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND
// FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
// INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
// OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
// TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF
// THIS SOFTWARE.



module chainMailTile() {
  

  // blue

  color("blue")
scale([0.9, 0.9, 0.9])
translate([0.0, 0.0, 0.0])
rotate()
rotate_extrude($fn=32)
translate([0.4, 0, 0])
circle(0.1, $fn=16);


  
  color("blue")
scale([0.9, 0.9, 0.9])
translate([0.55, 0.55, 0.55])
rotate()
rotate_extrude($fn=32)
translate([0.4, 0, 0])
circle(0.1, $fn=16);



  // red

  
  color("red")
scale([0.9, 0.9, 0.9])
translate([0.0, 0.55, 0.0])
rotate([0, 90, 0])
rotate_extrude($fn=32)
translate([0.4, 0, 0])
circle(0.1, $fn=16);



  
  color("red")
scale([0.9, 0.9, 0.9])
translate([0.55, 0.0, 0.55])
rotate([0, 90, 0])
rotate_extrude($fn=32)
translate([0.4, 0, 0])
circle(0.1, $fn=16);



  // green

  
  color("green")
scale([0.9, 0.9, 0.9])
translate([0.55, 0.0, 0.0])
rotate([90, 0, 0])
rotate_extrude($fn=32)
translate([0.4, 0, 0])
circle(0.1, $fn=16);



  
  color("green")
scale([0.9, 0.9, 0.9])
translate([0.0, 0.55, 0.55])
rotate([90, 0, 0])
rotate_extrude($fn=32)
translate([0.4, 0, 0])
circle(0.1, $fn=16);


}
