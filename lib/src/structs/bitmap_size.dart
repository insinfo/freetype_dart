import 'dart:ffi';
import 'typedefs.dart';
// pub struct FT_Bitmap_Size {
//     pub height: FT_Short,
//     pub width: FT_Short,
//     pub size: FT_Pos,
//     pub x_ppem: FT_Pos,
//     pub y_ppem: FT_Pos,
// }
/// size 16
final class FT_Bitmap_Size extends Struct {
  @FT_Short()
  external int height;
  @FT_Short()
  external int width;
  @FT_Pos()
  external int size;
  @FT_Pos()
  external int x_ppem;
  @FT_Pos()
  external int y_ppem;
}
