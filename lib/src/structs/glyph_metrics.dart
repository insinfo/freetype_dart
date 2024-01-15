import 'dart:ffi';
import 'typedefs.dart';

// pub struct FT_Glyph_Metrics {
//     pub width: FT_Pos,
//     pub height: FT_Pos,
//     pub horiBearingX: FT_Pos,
//     pub horiBearingY: FT_Pos,
//     pub horiAdvance: FT_Pos,
//     pub vertBearingX: FT_Pos,
//     pub vertBearingY: FT_Pos,
//     pub vertAdvance: FT_Pos,
// }

//  typedef struct  FT_Glyph_Metrics_
//   {
//     FT_Pos  width;
//     FT_Pos  height;
//     FT_Pos  horiBearingX;
//     FT_Pos  horiBearingY;
//     FT_Pos  horiAdvance;
//     FT_Pos  vertBearingX;
//     FT_Pos  vertBearingY;
//     FT_Pos  vertAdvance;
//   } FT_Glyph_Metrics;

/// size 32
/// c++ 64
final class FT_Glyph_Metrics extends Struct {
  @FT_Pos()
  external int width;
  @FT_Pos()
  external int height;
  @FT_Pos()
  external int horiBearingX;
  @FT_Pos()
  external int horiBearingY;
  @FT_Pos()
  external int horiAdvance;
  @FT_Pos()
  external int vertBearingX;
  @FT_Pos()
  external int vertBearingY;
  @FT_Pos()
  external int vertAdvance;
}