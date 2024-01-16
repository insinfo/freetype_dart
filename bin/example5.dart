import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:freetype_dart/src/bindings_manual2.dart';
import 'package:freetype_dart/src/old/generated_bindings.dart';
import 'package:freetype_dart/src/structs/errors.dart';

import 'dart:io';
import 'package:image/image.dart' as img;
//import 'package:freetype_dart/src/old/generated_bindings.dart' as auto;

void printf(object) {
  stdout.write(object);
}

void main(List<String> args) {
  //C:\msys64\mingw64\bin
  final path = r'libfreetype-6.dll';
  //Platform.isWindows ? 'freetype.dll' : 'libfreetype.so.6'
  final dylib = DynamicLibrary.open('bin/2.13.2/freetype.dll');

  final ft = FeetypeBindings2(dylib);

  final library = malloc<FT_Library>();

  var err = ft.FT_Init_FreeType(library);
  if (err != FT_Err_Ok) {
    print('err on Init FreeType');
  }

  ft.FT_Add_Default_Modules(library.value);

  final face = malloc<Pointer<FT_FaceRec_>>();
  err = ft.FT_New_Face(
      library.value, "VeraMono.ttf".toNativeUtf8().cast(), 0, face);

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

  err = ft.FT_Load_Glyph(face.value, 65, FT_LOAD_DEFAULT);
  print("FT_Load_Glyph $err");

  // // Render the glyph to a bitmap
  err = ft.FT_Render_Glyph(face.value.ref.glyph, 0);
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
