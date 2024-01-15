import 'dart:ffi';

import 'vector.dart';

// pub struct FT_Outline {
//     pub n_contours: c_short,
//     pub n_points: c_short,
//     pub points: *mut FT_Vector,
//     pub tags: *mut c_char,
//     pub contours: *mut c_short,
//     pub flags: c_int,
// }

//  typedef struct  FT_Outline_
//   {
//     short       n_contours;      /* number of contours in glyph        */
//     short       n_points;        /* number of points in the glyph      */
//     FT_Vector*  points;          /* the outline's points               */
//     char*       tags;            /* the points flags                   */
//     short*      contours;        /* the contour end points             */
//     int         flags;           /* outline masks                      */
//   } FT_Outline;

/// size 40
/// c++ size 40
final class FT_Outline extends Struct {
  @Short()
  external int n_contours;
  @Short()
  external int n_points;
  external Pointer<FT_Vector> points;
  external Pointer<Char> tags;
  external Pointer<Short> contours;
  @Int()
  external int flags;  
}