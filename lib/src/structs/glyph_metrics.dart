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
/// size 32
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