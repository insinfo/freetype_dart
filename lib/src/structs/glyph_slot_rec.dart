import 'dart:ffi';
import 'bitmap.dart';
import 'generic.dart';
import 'glyph_metrics.dart';
import 'outline.dart';
import 'typedefs.dart';
import 'vector.dart';

// pub struct FT_GlyphSlotRec {
//     pub library: FT_Library,
//     pub face: FT_Face,
//     pub next: FT_GlyphSlot,
//     pub reserved: FT_UInt,
//     pub generic: FT_Generic,
//     pub metrics: FT_Glyph_Metrics,
//     pub linearHoriAdvance: FT_Fixed,
//     pub linearVertAdvance: FT_Fixed,
//     pub advance: FT_Vector,
//     pub format: FT_Glyph_Format,
//     pub bitmap: FT_Bitmap,
//     pub bitmap_left: FT_Int,
//     pub bitmap_top: FT_Int,
//     pub outline: FT_Outline,
//     pub num_subglyphs: FT_UInt,
//     pub subglyphs: FT_SubGlyph,
//     pub control_data: *mut c_void,
//     pub control_len: c_long,
//     pub lsb_delta: FT_Pos,
//     pub rsb_delta: FT_Pos,
//     pub other: *mut c_void,
//     pub internal: FT_Slot_Internal,
// }
/// size 248
final class FT_GlyphSlotRec extends Struct {
  external FT_Library library;
  external FT_Face face;
  external FT_GlyphSlot next;
  @FT_UInt()
  external int reserved;
  external FT_Generic generic;
  external FT_Glyph_Metrics metrics;
  @FT_Fixed()
  external int linearHoriAdvance;
  @FT_Fixed()
  external int linearVertAdvance;
  external FT_Vector advance;
  @FT_Glyph_Format()
  external int format;
  external FT_Bitmap bitmap;
  @FT_Int()
  external int bitmap_left;
  @FT_Int()
  external int bitmap_top;
  external FT_Outline outline;
  @FT_UInt()
  external int num_subglyphs;
  external Pointer<FT_SubGlyph> subglyphs;
  external Pointer<c_void> control_data;
  external Pointer<Void> control_len;
  @FT_Pos()
  external int lsb_delta;
  @FT_Pos()
  external int rsb_delta;
  external Pointer<c_void> other;
  external FT_Slot_Internal internal;
}
