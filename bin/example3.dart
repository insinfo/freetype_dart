import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';

import 'package:freetype_dart/src/errors.dart';
import 'package:freetype_dart/src/extensions/extensions.dart';
import 'package:freetype_dart/src/generated_bindings.dart';

import 'package:image/image.dart' as img;

const WIDTH = 240;
const HEIGHT = 300;

void main(List<String> args) {
  final dylib = DynamicLibrary.open(
      Platform.isWindows ? 'libfreetype-6.dll' : 'libfreetype.so.6');

  final ft = FreetypeBinding(dylib);

  final library = malloc<FT_Library>();

  var err = ft.FT_Init_FreeType(library);
  if (err != FT_Err_Ok) {
    print('err on Init FreeType');
  }

  Pointer<FT_Face> face = malloc<FT_Face>();
  err = ft.FT_New_Face(library.value, "VeraMono.ttf".asCharP(), 0, face);

  if (err == FT_Err_Unknown_File_Format) {
    print("Font format is unsupported");
  } else if (err == 1) {
    print("Font file is missing or corrupted");
  } else if (err == FT_Err_Invalid_Argument) {
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
  err = ft.FT_Render_Glyph(
      face.value.ref.glyph, FT_Render_Mode_.FT_RENDER_MODE_NORMAL);
  print("FT_Render_Glyph $err");
  final bitmap = face.value.ref.glyph.ref.bitmap;

  print(
      "bitmap width ${bitmap.width} rows ${bitmap.rows} mode ${bitmap.pixel_mode} ${bitmap.pitch}");

  final face_s = face.value.ref;
  final glyph = face_s.glyph.ref;
  final x = glyph.bitmap_left;
  final y = HEIGHT - glyph.bitmap_top - 50;

  final image = img.Image(width: WIDTH * 2, height: HEIGHT * 2);
  image.clear(img.ColorRgb8(255, 255, 255));
  var w = bitmap.width;

  var data = bitmap.bufferAsList;

  for (var p = 0; p < w; p++) {
    for (var q = 0; q < bitmap.rows; q++) {
      var i = x + p;
      var j = y + q;
      if (i < 0 || j < 0 || i >= WIDTH || j >= HEIGHT) {
        continue;
      }
      var val = data[q * w + p];
      // final pixel = image.getPixel(i, j);
      // pixel.r = val;
      // pixel.g = val;
      // pixel.b = val;
      final cor = img.ColorRgba8(84, 13, 110, val);
      img.drawPixel(image, i, j, cor, maskChannel: img.Channel.luminance);
    }
  }

  final png = img.encodePng(image);

  File('image2.png').writeAsBytesSync(png);

  ft.FT_Done_Face(face.value);
  ft.FT_Done_FreeType(library.value);
}
