import 'dart:math';
import 'package:freetype_dart/src/wrapper/freetype.dart';
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

  final ft = Freetype();
  final face = ft.newFace('VeraMono.ttf');
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
    drawBitmap(bitmap, x, y);

    // increment pen position
    pen.x += glyph.advance.x;
    pen.y += glyph.advance.y;
  }

  final png = img.encodePng(image);
  File('image4.png').writeAsBytesSync(png);

  //face.free();
  ft.free();
}

void drawBitmap(Bitmap bitmap, int x, int y) {
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
