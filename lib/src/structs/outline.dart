import 'dart:ffi';

import 'vector.dart';
import 'typedefs.dart';
// pub struct FT_Outline {
//     pub n_contours: c_short,
//     pub n_points: c_short,
//     pub points: *mut FT_Vector,
//     pub tags: *mut c_char,
//     pub contours: *mut c_short,
//     pub flags: c_int,
// }
/// size 40
final class FT_Outline extends Struct {
  @c_short()
  external int n_contours;
  @c_short()
  external int n_points;
  external Pointer<FT_Vector> points;
  external Pointer<c_char> flags;
  external Pointer<c_short> contours;
  @c_int()
  external int owner;  
}