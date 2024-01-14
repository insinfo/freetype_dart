import 'dart:ffi';

import 'typedefs.dart';
// pub struct FT_Size_Metrics {
//     pub x_ppem: FT_UShort,
//     pub y_ppem: FT_UShort,
//     pub x_scale: FT_Fixed,
//     pub y_scale: FT_Fixed,
//     pub ascender: FT_Pos,
//     pub descender: FT_Pos,
//     pub height: FT_Pos,
//     pub max_advance: FT_Pos,
// }
/// size 28
final class FT_Size_Metrics extends Struct {
  @FT_UShort()
  external int x_ppem;
  @FT_UShort()
  external int y_ppem;
  @FT_Fixed()
  external int x_scale;
  @FT_Fixed()
  external int y_scale;
  @FT_Pos()
  external int ascender;
  @FT_Pos()
  external int descender;
  @FT_Pos()
  external int height;
  @FT_Pos()
  external int max_advance;
}
