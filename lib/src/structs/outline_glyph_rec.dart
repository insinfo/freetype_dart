

import 'dart:ffi';

import 'glyph_rec.dart';
import 'outline.dart';

// pub struct FT_OutlineGlyphRec {
//     pub root: FT_GlyphRec,
//     pub outline: FT_Outline,
// }
/// size 72
final class FT_OutlineGlyphRec extends Struct {
  external FT_GlyphRec root;
  external FT_Outline outline;
}
