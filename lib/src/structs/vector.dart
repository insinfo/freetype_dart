import 'dart:ffi';
import 'typedefs.dart';
// pub struct FT_Vector {
//     pub x: FT_Pos,
//     pub y: FT_Pos,
// }

  // typedef struct  FT_Vector_
  // {
  //   FT_Pos  x;
  //   FT_Pos  y;
  // } FT_Vector;

/// size  8
/// c++ size 16
final class FT_Vector extends Struct {
  @FT_Pos()
  external int x;
  @FT_Pos()
  external int y;
}