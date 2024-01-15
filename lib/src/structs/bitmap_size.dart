import 'dart:ffi';
import 'typedefs.dart';

// pub struct FT_Bitmap_Size {
//     pub height: FT_Short,
//     pub width: FT_Short,
//     pub size: FT_Pos,
//     pub x_ppem: FT_Pos,
//     pub y_ppem: FT_Pos,
// }

// typedef struct  FT_Bitmap_Size_
// {
//   FT_Short  height;
//   FT_Short  width;
//   FT_Pos    size;
//   FT_Pos    x_ppem;
//   FT_Pos    y_ppem;
// } FT_Bitmap_Size;

/// size 16
/// in c++ 32
/// 2+2
final class FT_Bitmap_Size extends Struct {
  //FT_Short
  @FT_Short()
  external int height;
  //FT_Short
  @FT_Short()
  external int width;
  //@FT_Pos() Int64
  @FT_Pos()
  external int size;
  //FT_Pos
  @FT_Pos()
  external int x_ppem;
  //FT_Pos
  @FT_Pos()
  external int y_ppem;
}
