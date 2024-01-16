#### freetype dart bindings


##### example

```dart

import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:freetype_dart/src/errors.dart';
import 'package:freetype_dart/src/extensions/extensions.dart';
import 'package:freetype_dart/src/generated_bindings.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

void main(List<String> args) {
  final dylib = DynamicLibrary.open(
      Platform.isWindows ? 'libfreetype-6.dll' : 'libfreetype.so.6');

  final ft = FreetypeBinding(dylib);

  final library = calloc<FT_Library>();

  var err = ft.FT_Init_FreeType(library);
  if (err != FT_Err_Ok) {
    print('err on Init FreeType');
  }

  final face = calloc<FT_Face>();
  err = ft.FT_New_Face(library.value, "VeraMono.ttf".asCharP(), 0, face);

  if (err == FT_Err_Unknown_File_Format) {
    print("Font format is unsupported");
  } else if (err == 1) {
    print("Font file is missing or corrupted");
  }

  // Ensure an unicode characater map is loaded
  err = ft.FT_Select_Charmap(face.value, ft_encoding_unicode);
  print("FT_Select_Charmap $err");
  
  // Select a character to render
  var character = 'A';
  int glyph_index = ft.FT_Get_Char_Index(face.value, character.codeUnitAt(0));
  if (glyph_index == 0) {
    print('código de caractere indefinido');
  }
  print("glyph_index $glyph_index");

  err = ft.FT_Set_Pixel_Sizes(face.value, 0, 240); // Set font size to 24 pixels
  print("FT_Set_Pixel_Sizes $err");
  
  err = ft.FT_Load_Glyph(face.value, glyph_index, FT_LOAD_DEFAULT);
  print("FT_Load_Glyph $err");

  // // Render the glyph to a bitmap
  err = ft.FT_Render_Glyph(
      face.value.ref.glyph, FT_Render_Mode_.FT_RENDER_MODE_NORMAL);
  print("FT_Render_Glyph $err");
  FT_Bitmap bitmap = face.value.ref.glyph.ref.bitmap;

  print(
      "bitmap width ${bitmap.width} rows ${bitmap.rows} mode ${bitmap.pixel_mode} ${bitmap.pitch}");

  var format = img.Format.uint8;

  final buffer = bitmap.buffer
      .cast<Int8>()
      .asTypedList((bitmap.pitch * bitmap.rows).toInt());

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

  ft.FT_Done_Face(face.value);
  ft.FT_Done_FreeType(library.value);
}


```
#### result

![result](https://github.com/insinfo/freetype_dart/blob/main/image.png?raw=true)

```dart
import 'dart:math';
import 'package:freetype_dart/src/wrapper/freetype.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

void main(List<String> args) {
  createPreview('VeraMono.ttf', 'VeraMono.png');
}

void createPreview(String fontFileName, String outputFileName,
    {int width = 640,
    int height = 480,
    int fontSize = 24,
    img.Color? backgroundColor}) {
  final image = img.Image(width: width, height: height);
  image.clear(backgroundColor ?? img.ColorRgb8(255, 255, 255));

  final ft = Freetype();
  final face = ft.newFace(fontFileName);
  face.setCharSize(fontSize * 64, 0, 100, 0);

  final text = face.familyName;
  final numChars = text.length;

  var targetHeight = height;
  final pen = Vector(50 * 64, (targetHeight - 100) * 64);

  final angle = (0.0 / 360) * 3.14159 * 2;

  final matrix = Matrix(0, 0, 0, 0);
  matrix.xx = (cos(angle) * 0x10000).toInt();
  matrix.xy = (-sin(angle) * 0x10000).toInt();
  matrix.yx = (sin(angle) * 0x10000).toInt();
  matrix.yy = (cos(angle) * 0x10000).toInt();

  for (var n = 0; n < numChars; n++) {
    // set transformation
    face.setTransform(matrix, pen);
    // load glyph image into the slot (erase previous one)
    final char = text.codeUnitAt(n);
    final isLoad = face.loadChar(char, LoadFlag.RENDER);
    if (isLoad == false) continue; // ignore errors
    final glyph = face.glyph;
    final bitmap = glyph.bitmap();
    final x = glyph.bitmapLeft;
    final y = targetHeight - glyph.bitmapTop;
    drawBitmap(image, bitmap, x, y);
    // increment pen position
    pen.x += glyph.advance.x;
    pen.y += glyph.advance.y;
  }

  final png = img.encodePng(image);
  File(outputFileName).writeAsBytesSync(png);

  face.free();
  ft.free();
}

void drawBitmap(img.Image imageCtx, Bitmap bitmap, int x, int y) {
  final w = bitmap.width;
  final xMax = w;
  final yMax = bitmap.rows;
  final data = bitmap.buffer;

  for (var p = 0; p < xMax; p++) {
    for (var q = 0; q < yMax; q++) {
      var i = x + p;
      var j = y + q;
      if (i < 0 || j < 0 || i >= imageCtx.width || j >= imageCtx.height) {
        continue;
      }
      final idx = q * w + p;
      // if (idx > data.length - 1) {
      //   continue;
      // }
      final val = data[idx];
      final cor = img.ColorRgba8(84, 13, 110, val);
      img.drawPixel(imageCtx, i, j, cor, maskChannel: img.Channel.luminance);
    }
  }
}

```

#### result

![result](https://github.com/insinfo/freetype_dart/blob/main/image4.png?raw=true)