#### freetype dart bindings


##### example

```dart
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:freetype_dart/src/bindings_manual.dart';
import 'package:freetype_dart/src/extensions/extensions.dart';
import 'package:freetype_dart/src/structs/bitmap.dart';
import 'package:freetype_dart/src/structs/constants.dart';
import 'package:freetype_dart/src/structs/errors.dart';
import 'package:freetype_dart/src/structs/typedefs.dart';

import 'dart:io';
import 'package:image/image.dart' as img;

void printf(object) {
  stdout.write(object);
}

void main(List<String> args) {
  final dylib =
      DynamicLibrary.open(r'C:\MyProjectsDart\freetype\libfreetype-6.dll');

  final ft = FeetypeBindings(dylib);

  final library = calloc<FT_Library>();

  var err = ft.FT_Init_FreeType(library);
  if (err != FT_Err_Ok) {
    print('err on Init FreeType');
  }

  ft.FT_Add_Default_Modules(library.value);

  final face = calloc<FT_Face>();
  err = ft.FT_New_Face(library.value,
      "C:/MyProjectsDart/freetype/VeraMono.ttf".asInt8(), 0, face);

  if (err == FT_Err_Unknown_File_Format) {
    print("Font format is unsupported");
  } else if (err == 1) {
    print("Font file is missing or corrupted");
  }

  // Ensure an unicode characater map is loaded
  err = ft.FT_Select_Charmap(face.value, FT_ENCODING_UNICODE);
  print("FT_Select_Charmap $err");

  Pointer<FT_UInt> gid = calloc<FT_UInt>();

  var charcode = ft.FT_Get_First_Char(face.value, gid);
  print("charcode $charcode ${gid.value}");
  // while (gid.value != 0) {
  //   print("Codepoint: $charcode, glyph_index: ${gid.value}");
  //   charcode = ft.FT_Get_Next_Char(face.value, charcode, gid);
  // }

  // Select a character to render
  var character = 'A';
  int glyph_index = ft.FT_Get_Char_Index(face.value, character.codeUnitAt(0));
  if (glyph_index == 0) {
    print('código de caractere indefinido');
  }
  print("glyph_index $glyph_index");

  err = ft.FT_Set_Pixel_Sizes(face.value, 0, 240); // Set font size to 240 pixels
  print("FT_Set_Pixel_Sizes $err");
  //0,       16*64,   300,    300
  // 40 * 64, 0, 50, 0
  // err = ft.FT_Set_Char_Size(face.value, 0, 11 * 64 + 32, 0, 0);
  // print("FT_Set_Char_Size $err");

  err = ft.FT_Load_Glyph(face.value, glyph_index, FT_LOAD_DEFAULT);
  print("FT_Load_Glyph $err");

  // // Render the glyph to a bitmap
  err = ft.FT_Render_Glyph(face.value.ref.glyph, FT_RENDER_MODE_NORMAL);
  print("FT_Render_Glyph $err");
  FT_Bitmap bitmap = face.value.ref.glyph.ref.bitmap;

  print(
      "bitmap width ${bitmap.width} rows ${bitmap.rows} mode ${bitmap.pixel_mode} ${bitmap.pitch}");

  var format = img.Format.uint8;
  switch (bitmap.palette_mode) {
    case FT_PIXEL_MODE_MONO:
      format = img.Format.uint1;
      break;
    case FT_PIXEL_MODE_GRAY:
      format = img.Format.uint8;
      break;
    case FT_PIXEL_MODE_BGRA:
      format = img.Format.uint32;
      break;
  }

  final buffer =
      bitmap.buffer.asTypedList((bitmap.pitch * bitmap.rows).toInt());

  // Create a 256x256 8-bit (default) rgb (default) image.
  final image = img.Image.fromBytes(
      width: bitmap.width,
      height: bitmap.rows,
      bytes: buffer.buffer,
      numChannels: 1,
      format: format);

  // Encode the resulting image to the PNG image format.
  final png = img.encodePng(image);
  // Write the PNG formatted data to a file.
  File('image.png').writeAsBytesSync(png);
}

```
#### result

![result](https://github.com/insinfo/freetype_dart/blob/main/image.png?raw=true)

```dart
import 'dart:math';
import 'package:freetype_dart/src/wrapper/feetype.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

const WIDTH = 640;
const HEIGHT = 480;
const fontSize = 24;

final image = img.Image(
  width: WIDTH,
  height: HEIGHT,
);

void main(List<String> args) {
  image.clear(img.ColorRgb8(255, 255, 255));
  
  final ft = Feetype();
  final face = ft.newFace('C:/MyProjectsDart/freetype/VeraMono.ttf');
  print(face.familyName);
  face.setCharSize(fontSize * 64, 0, 100, 0);
  //face.setPixelSizes(0, fontSize);

  final text = face.familyName;
  final num_chars = text.length;

  var target_height = HEIGHT;
  final pen = Vector(50 * 64, (target_height - 100) * 64);

  // use 25 degrees
  final angle = (0.0 / 360) * 3.14159 * 2;

  final matrix = Matrix(0, 0, 0, 0);
  matrix.xx = (cos(angle) * 0x10000).toInt();
  matrix.xy = (-sin(angle) * 0x10000).toInt();
  matrix.yx = (sin(angle) * 0x10000).toInt();
  matrix.yy = (cos(angle) * 0x10000).toInt();

  for (var n = 0; n < num_chars; n++) {
    // set transformation
    face.setTransform(matrix, pen);
    // load glyph image into the slot (erase previous one)
    final char = text.codeUnitAt(n);
    final isLoad = face.loadChar(char, LoadFlag.RENDER);
    if (isLoad == false) continue; // ignore errors
    final glyph = face.glyph;
    final bitmap = glyph.bitmap();

    final x = glyph.bitmapLeft; 
    final y = target_height - glyph.bitmapTop; 
    drawBitmap(bitmap, x, y, x, y);

    // increment pen position
    pen.x += glyph.advance.x;
    pen.y += glyph.advance.y;
  }

  
  ft.free();  

  final png = img.encodePng(image);
  File('image4.png').writeAsBytesSync(png);
}

void drawBitmap(Bitmap bitmap, int x, int y, int xx, int yy) {
  var w = bitmap.width;
  var xMax = w;
  var yMax = bitmap.rows;
  var data = bitmap.buffer;

  for (var p = 0; p < xMax; p++) {
    for (var q = 0; q < yMax; q++) {
      var i = x + p;
      var j = y + q;
      if (i < 0 || j < 0 || i >= WIDTH || j >= HEIGHT) {
        continue;
      }
      final idx = q * w + p;
      // if (idx > data.length - 1) {
      //   continue;
      // }
      final val = data[idx];
      final cor = img.ColorRgba8(84, 13, 110, val);
      img.drawPixel(image, i, j, cor, maskChannel: img.Channel.luminance);
    }
  }
}

```

#### result

![result](https://github.com/insinfo/freetype_dart/blob/main/image4.png?raw=true)