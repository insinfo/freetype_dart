import 'dart:ffi';
import 'bbox.dart';
import 'bitmap_size.dart';
import 'generic.dart';
import 'list_rec.dart';
import 'typedefs.dart';

// pub struct FT_FaceRec {
//     pub num_faces: FT_Long,
//     pub face_index: FT_Long,
//     pub face_flags: FT_Long,
//     pub style_flags: FT_Long,
//     pub num_glyphs: FT_Long,
//     pub family_name: *mut FT_String,
//     pub style_name: *mut FT_String,
//     pub num_fixed_sizes: FT_Int,
//     pub available_sizes: *mut FT_Bitmap_Size,
//     pub num_charmaps: FT_Int,
//     pub charmaps: *mut FT_CharMap,
//     pub generic: FT_Generic,
//     pub bbox: FT_BBox,
//     pub units_per_EM: FT_UShort,
//     pub ascender: FT_Short,
//     pub descender: FT_Short,
//     pub height: FT_Short,
//     pub max_advance_width: FT_Short,
//     pub max_advance_height: FT_Short,
//     pub underline_position: FT_Short,
//     pub underline_thickness: FT_Short,
//     pub glyph: FT_GlyphSlot,
//     pub size: FT_Size,
//     pub charmap: FT_CharMap,
//     /* @private begin */
//     pub driver: FT_Driver,
//     pub memory: FT_Memory,
//     pub stream: FT_Stream,
//     pub sizes_list: FT_ListRec,
//     pub autohint: FT_Generic,
//     pub extensions: *mut c_void,
//     pub internal: FT_Face_Internal,
//     /* @private end */
// }

/// size 216
final class FT_FaceRec extends Struct {
  @FT_Long()
  external int num_faces;
  @FT_Long()
  external int face_index;
  @FT_Long()
  external int face_flags;
  @FT_Long()
  external int style_flags;
  @FT_Long()
  external int num_glyphs;
  external Pointer<FT_String> family_name;
  external Pointer<FT_String> style_name;
  @FT_Int()
  external int num_fixed_sizes;
  external Pointer<FT_Bitmap_Size> available_sizes;
  @FT_Int()
  external int num_charmaps;
  external Pointer<FT_CharMap> charmaps;
  external FT_Generic generic;
  external FT_BBox bbox;
  @FT_UShort()
  external int units_per_EM;
  @FT_Short()
  external int ascender;
  @FT_Short()
  external int descender;
  @FT_Short()
  external int height;
  @FT_Short()
  external int max_advance_width;
  @FT_Short()
  external int max_advance_height;
  @FT_Short()
  external int underline_position;
  @FT_Short()
  external int underline_thickness;
  external FT_GlyphSlot glyph;
  external FT_Size size;
  external FT_CharMap charmap;
  external FT_Driver driver;
  external FT_Memory memory;
  external FT_Stream stream;
  external FT_ListRec sizes_list;
  external FT_Generic autohint;
  external Pointer<Void> extensions;
  external FT_Face_Internal internal;
}
