import 'dart:ffi';
import 'bitmap.dart';
import 'glyph_rec.dart';
import 'typedefs.dart';
// pub struct FT_BitmapGlyphRec {
//     pub root: FT_GlyphRec,
//     pub left: FT_Int,
//     pub top: FT_Int,
//     pub bitmap: FT_Bitmap,
// }
/// size 80
final class FT_BitmapGlyphRec extends Struct {
  external FT_GlyphRec root;
  @FT_Int()
  external int left;
  @FT_Int()
  external int top;
  external FT_Bitmap bitmap;
}
