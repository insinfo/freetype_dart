import 'dart:math';
import 'package:freetype_dart/src/wrapper/freetype.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

void main(List<String> args) {
  final ft = Freetype();
  final stopwatch = Stopwatch()..start();
  createFontPreview(ft, 'VeraMono.ttf', 'VeraMono.png');
  print('executed in: ${stopwatch.elapsed}');
  ft.free();
}

void createFontPreview(Freetype ft, String fontFileName, String outputFileName,
    {int width = 1551,
    int height = 84,
    int fontSize = 48,
    img.Color? backgroundColor,
    img.ColorRgba8? fontColor}) {
  final image = img.Image(width: width, height: height, numChannels: 4);
  if (backgroundColor != null) {
    image.clear(backgroundColor);
  }

  final face = ft.newFace(fontFileName);
  face.setCharSize(fontSize * 64, 0, 100, 0);

  final text = face.familyName;
  final numChars = text.length;

  var targetHeight = height;
  final pen = Vector(10 * 64, (targetHeight - (fontSize + 20)) * 64);

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
    drawBitmap(
        image, bitmap, x, y, fontColor ?? img.ColorRgba8(0, 0, 0, 255));
    // increment pen position
    pen.x += glyph.advance.x;
    pen.y += glyph.advance.y;
  }

  final png = img.encodePng(image);
  File(outputFileName).writeAsBytesSync(png);

  face.free();
}

void drawBitmap(
    img.Image imageCtx, Bitmap bitmap, int x, int y, img.ColorRgba8 fontColor) {
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
      final val = data[idx]; //img.ColorRgba8(84, 13, 110, val)
      fontColor.a = val;
      final cor = fontColor;
      img.drawPixel(imageCtx, i, j, cor, maskChannel: img.Channel.luminance);
    }
  }
}
