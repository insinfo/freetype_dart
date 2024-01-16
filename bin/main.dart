import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:freetype_dart/src/errors.dart';

import 'package:freetype_dart/src/extensions/extensions.dart';
import 'package:freetype_dart/src/generated_bindings.dart';

void main(List<String> args) {
  //print('size ${sizeOf<FT_Vector>()}');

  final dylib = DynamicLibrary.open(
      Platform.isWindows ? 'freetype.dll' : 'libfreetype.so.6');

  final ft = FreetypeBinding(dylib);

  final library = calloc<FT_Library>();

  var err = ft.FT_Init_FreeType(library);
  if (err != FT_Err_Ok) {
    print('err on Init FreeType');
  }
  print('FT_Init_FreeType $err');

  final face = calloc<FT_Face>();
  err = ft.FT_New_Face(library.value, "VeraMono.ttf".asCharP(), 0, face);

  if (err == FT_Err_Unknown_File_Format) {
    print("Font format is unsupported");
  } else if (err == 1) {
    print("Font file is missing or corrupted");
  }

  print('FT_New_Face $err');

  err = ft.FT_Set_Char_Size(face.value, 0, 11 * 64 + 32, 0, 0);
  print("FT_Set_Char_Size $err");

  err = ft.FT_Load_Char(face.value, 65, FT_LOAD_RENDER);
  if (err == 1) {
    print("error FT_Load_Char");
  }
  print("FT_Load_Char $err");

  final face_s = face.value.ref;
  final glyph = face_s.glyph.ref;
  final x = glyph.bitmap_left;
  final y = HEIGHT - glyph.bitmap_top;
  final bitmap = glyph.bitmap;

  print('glyph ${glyph}');

  final figure = drawBitmap(bitmap, x, y);
  for (var row in figure) {
    for (var v in row) {
      var c = '-';
      if (v == 0) {
        c = '-';
      } else if (v >= 1 && v <= 127) {
        c = '*';
      } else {
        c = '*';
      }
      stdout.write(c);
    }
    print('');
  }
}

const WIDTH = 32;
const HEIGHT = 24;

// Define the Figure type
typedef Figure = List<List<int>>;

Figure drawBitmap(FT_Bitmap bitmap, int x, int y) {
  var figure = List.generate(HEIGHT, (_) => List.filled(WIDTH, 0));
  var w = bitmap.width;
  // var xMax = x + w;
  // var yMax = y + bitmap.rows;
  var data = bitmap.bufferAsList;

  for (var p = 0; p < w; p++) {
    for (var q = 0; q < bitmap.rows; q++) {
      var i = x + p;
      var j = y + q;
      if (i < 0 || j < 0 || i >= WIDTH || j >= HEIGHT) {
        continue;
      }
      figure[j][i] |= data[q * w + p];
    }
  }
  return figure;
}
