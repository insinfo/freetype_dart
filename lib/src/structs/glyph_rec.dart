import 'dart:ffi';
import 'typedefs.dart';
import 'vector.dart';

// pub struct FT_GlyphRec {
//     pub library: FT_Library,
//     pub clazz: *const c_void, // FT_Glyph_Class
//     pub format: FT_Glyph_Format,
//     pub advance: FT_Vector,
// }
/// size 32
final class FT_GlyphRec extends Struct {
  external FT_Library library;
  external Pointer<c_void> clazz; // FT_Glyph_Class
  @FT_Glyph_Format()
  external int format;
  external FT_Vector advance;
}
