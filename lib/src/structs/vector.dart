import 'dart:ffi';
import 'typedefs.dart';
// pub struct FT_Vector {
//     pub x: FT_Pos,
//     pub y: FT_Pos,
// }
/// size  8
final class FT_Vector extends Struct {
  @FT_Pos()
  external int x;
  @FT_Pos()
  external int y;
}