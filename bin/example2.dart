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

  //Pointer<FT_UInt> gid = calloc<FT_UInt>();
  //var charcode = ft.FT_Get_First_Char(face.value, gid);
  //print("charcode $charcode ${gid.value}");
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

  err = ft.FT_Set_Pixel_Sizes(face.value, 0, 240); // Set font size to 24 pixels
  print("FT_Set_Pixel_Sizes $err");
  //0,       16*64,   300,    300
  // 40 * 64, 0, 50, 0
  // err = ft.FT_Set_Char_Size(face.value, 0, 11 * 64 + 32, 0, 0);
  // print("FT_Set_Char_Size $err");

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
