import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:freetype_dart/src/bindings_manual.dart';
import 'package:freetype_dart/src/extensions/extensions.dart';
import 'package:freetype_dart/src/structs/bbox.dart';

import 'package:freetype_dart/src/structs/bitmap.dart';
import 'package:freetype_dart/src/structs/bitmap_glyph_rec.dart';
import 'package:freetype_dart/src/structs/bitmap_size.dart';
import 'package:freetype_dart/src/structs/char_map_rec.dart';
import 'package:freetype_dart/src/structs/constants.dart';
import 'package:freetype_dart/src/structs/errors.dart';
import 'package:freetype_dart/src/structs/face_rec.dart';
import 'package:freetype_dart/src/structs/generic.dart';
import 'package:freetype_dart/src/structs/glyph_metrics.dart';
import 'package:freetype_dart/src/structs/glyph_rec.dart';
import 'package:freetype_dart/src/structs/glyph_slot_rec.dart';
import 'package:freetype_dart/src/structs/list_rec.dart';
import 'package:freetype_dart/src/structs/memory_rec.dart';
import 'package:freetype_dart/src/structs/outline.dart';
import 'package:freetype_dart/src/structs/size_metrics.dart';
import 'package:freetype_dart/src/structs/size_rec.dart';
import 'package:freetype_dart/src/structs/typedefs.dart';
import 'package:freetype_dart/src/structs/vector.dart';

import 'dart:io';
import 'package:image/image.dart' as img;
//import 'package:freetype_dart/src/old/generated_bindings.dart' as auto;

void printf(object) {
  stdout.write(object);
}

void main(List<String> args) {
  print("FT_Fixed size ${sizeOf<FT_Fixed>()}");
  print("FT_Int size ${sizeOf<FT_Int>()}");
  print("FT_UInt size ${sizeOf<FT_UInt>()}");
  print("FT_Int16 size ${sizeOf<FT_Int16>()}");
  print("FT_UInt16 size ${sizeOf<FT_UInt16>()}");
  print("FT_Int32 size ${sizeOf<FT_Int32>()}");
  print("FT_UInt32 size ${sizeOf<FT_UInt32>()}");
  print("FT_Int64 size ${sizeOf<FT_Int64>()}");
  print("FT_UInt64 size ${sizeOf<FT_UInt64>()}");
  print("FT_Short size ${sizeOf<FT_Short>()}");
  print("FT_UShort size ${sizeOf<FT_UShort>()}");
  print("FT_Byte size ${sizeOf<FT_Byte>()}");
  print("FT_Bytes size ${sizeOf<FT_Bytes>()}");
  print("FT_Long size ${sizeOf<FT_Long>()}");
  print("FT_ULong size ${sizeOf<FT_ULong>()}");
  print("FT_Bool size ${sizeOf<FT_Bool>()}");
  print("FT_Offset size ${sizeOf<FT_Offset>()}");
  print("FT_String size ${sizeOf<FT_String>()}");
  print("FT_Tag size ${sizeOf<FT_Tag>()}");
  print("FT_Error size ${sizeOf<FT_Error>()}");
  print("FT_Pointer size ${sizeOf<FT_Pointer>()}");
  print("FT_FWord size ${sizeOf<FT_FWord>()}");
  print("FT_UFWord size ${sizeOf<FT_UFWord>()}");
  print("FT_F2Dot14 size ${sizeOf<FT_F2Dot14>()}");
  print("FT_F26Dot6 size ${sizeOf<FT_F26Dot6>()}");
  print("FT_Encoding size  ${sizeOf<FT_Encoding>()}");
  print("FT_Size_Request_Type size  ${sizeOf<FT_Size_Request_Type>()}");
  print("FT_FaceRec size ${sizeOf<FT_FaceRec>()}");
  print("FT_Bitmap_Size size ${sizeOf<FT_Bitmap_Size>()}");
  print("FT_CharMapRec size ${sizeOf<FT_CharMapRec>()}");
  print("FT_Generic size ${sizeOf<FT_Generic>()}");
  print("FT_Short size ${sizeOf<FT_Short>()}");
  print("FT_Pos size ${sizeOf<FT_Pos>()}");
  print("FT_BBox size  ${sizeOf<FT_BBox>()}");
  print("FT_BitmapGlyphRec size  ${sizeOf<FT_BitmapGlyphRec>()}");
  print("FT_GlyphRec size  ${sizeOf<FT_GlyphRec>()}");
  print("FT_Glyph_Format size  ${sizeOf<FT_Glyph_Format>()}");
  print("FT_Vector size  ${sizeOf<FT_Vector>()}");
  print("FT_Bitmap size  ${sizeOf<FT_Bitmap>()}");
  print("FT_GlyphSlotRec size  ${sizeOf<FT_GlyphSlotRec>()}");
  print("FT_Glyph_Metrics size  ${sizeOf<FT_Glyph_Metrics>()}");
  print("FT_Outline size  ${sizeOf<FT_Outline>()}");
  print("FT_Slot_Internal size  ${sizeOf<FT_Slot_Internal>()}");
  print("FT_SizeRec size  ${sizeOf<FT_SizeRec>()}");
  print("FT_Size_Metrics size  ${sizeOf<FT_Size_Metrics>()}");
  print("FT_Size_Internal size  ${sizeOf<FT_Size_Internal>()}");
  print("FT_MemoryRec size  ${sizeOf<FT_MemoryRec>()}");
  print("FT_Stream size  ${sizeOf<FT_Stream>()}");
  print("FT_ListRec size  ${sizeOf<FT_ListRec>()}");

  //C:\msys64\mingw64\bin
  final path = r'libfreetype-6.dll';
  //Platform.isWindows ? 'freetype.dll' : 'libfreetype.so.6'
  final dylib = DynamicLibrary.open('bin/2.12.1/freetype.dll');

  final ft = FeetypeBindings(dylib);

  final library = malloc<FT_Library>();

  var err = ft.FT_Init_FreeType(library);
  if (err != FT_Err_Ok) {
    print('err on Init FreeType');
  }

  ft.FT_Add_Default_Modules(library.value);

  Pointer<FT_Face> face = malloc<FT_Face>();
  err = ft.FT_New_Face(library.value, "VeraMono.ttf".asCharP(), 0, face);

  if (err == FT_Err_Unknown_File_Format) {
    print("Font format is unsupported");
  } else if (err == 1) {
    print("Font file is missing or corrupted");
  }else if(err == FT_Err_Invalid_Argument){
    print("FT_New_Face Invalid Argument");
  }
  print("FT_New_Face $err");

  // Ensure an unicode characater map is loaded
  // err = ft.FT_Select_Charmap(face.value, FT_ENCODING_UNICODE);
  // print("FT_Select_Charmap $err");

  // Pointer<FT_UInt> gid = malloc<FT_UInt>();
  // var charcode = ft.FT_Get_First_Char(face.value, gid);
  // print("charcode $charcode ${gid.value}");
  // while (gid.value != 0) {
  //   print("Codepoint: $charcode, glyph_index: ${gid.value}");
  //   charcode = ft.FT_Get_Next_Char(face.value, charcode, gid);
  // }

  //Select a character to render
  var character = '3';
  int glyph_index = ft.FT_Get_Char_Index(face.value, character.codeUnitAt(0));
  if (glyph_index == 0) {
    print('código de caractere indefinido');
  }
 print("glyph_index $glyph_index");
// // Set font size in pixels
  err = ft.FT_Set_Pixel_Sizes(face.value, 0, HEIGHT);
  print("FT_Set_Pixel_Sizes $err");
//   //0,       16*64,   300,    300
//   // 40 * 64, 0, 50, 0
//   // err = ft.FT_Set_Char_Size(face.value, 0, 11 * 64 + 32, 0, 0);
//   // print("FT_Set_Char_Size $err");

 err = ft.FT_Load_Glyph(face.value, glyph_index, FT_LOAD_DEFAULT);
   print("FT_Load_Glyph $err");

 print("face.value.ref.glyph ${face.value.ref.glyph}");

  // // Render the glyph to a bitmap
 err = ft.FT_Render_Glyph(face.value.ref.glyph, FT_RENDER_MODE_NORMAL);
print("FT_Render_Glyph $err");
  //FT_Bitmap bitmap = face.value.ref.glyph.ref.bitmap;

  //print(  "bitmap width ${bitmap.width} rows ${bitmap.rows} mode ${bitmap.pixel_mode} ${bitmap.pitch}");

  // final face_s = face.value.ref;
  // final glyph = face_s.glyph.ref;
  // final x = glyph.bitmap_left;
  // final y = HEIGHT - glyph.bitmap_top - 50;

  // final image = img.Image(width: WIDTH * 2, height: HEIGHT * 2);

  // var w = bitmap.width;

  // var data = bitmap.bufferAsList;

  // for (var p = 0; p < w; p++) {
  //   for (var q = 0; q < bitmap.rows; q++) {
  //     var i = x + p;
  //     var j = y + q;
  //     if (i < 0 || j < 0 || i >= WIDTH || j >= HEIGHT) {
  //       continue;
  //     }
  //     var val = data[q * w + p];
  //     final pixel = image.getPixel(i, j);
  //     pixel.r = val;
  //     pixel.g = val;
  //     pixel.b = val;
  //   }
  // }

  //final png = img.encodePng(image);

  //File('image2.png').writeAsBytesSync(png);

  //ft.FT_Done_Face(face.value);

  //ft.FT_Done_FreeType(library.value);
}

const WIDTH = 240;
const HEIGHT = 300;
