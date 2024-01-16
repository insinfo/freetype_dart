import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart';
import 'package:freetype_dart/src/extensions/extensions.dart';
import 'package:freetype_dart/src/generated_bindings.dart';

// ignore: unused_import
import 'package:path/path.dart' show dirname, join;

import '../errors.dart';

// pacman -Syyu
//
/// Feetype high level API
class Freetype implements Finalizable {
  String dllPath = r'libfreetype-6.dll';

  late DynamicLibrary dylib;
  Allocator allocator = calloc;
  late FreetypeBinding binding;
  late Pointer<Pointer<FT_LibraryRec_>> raw;

  ///   Used to prevent double free and usage after free.
  bool _isFree = false;

  static final Finalizer<Freetype> _finalizer =
      Finalizer((instance) => instance.free());

  Freetype({DynamicLibrary? dl, String? dllPath, this.allocator = calloc}) {
    if (dl == null) {
      var path = r'freetype.dll';
      if (Platform.isWindows) {
        path = r'freetype.dll';
      } else if (Platform.isLinux) {
        ///usr/lib/x86_64-linux-gnu/libfreetype.so.6
        path = r'libfreetype.so.6';
      }
      //join(dirname(Platform.script.path),'..', 'freetype.dll');
      //print(path);
      this.dllPath = dllPath == null ? path : dllPath;
      dylib = DynamicLibrary.open(this.dllPath);
    } else {
      dylib = dl;
    }

    binding = FreetypeBinding(dylib);
    raw = allocator<Pointer<FT_LibraryRec_>>();

    final err = binding.FT_Init_FreeType(raw);
    if (err != FT_Err_Ok) {
      throw Exception('Error on Init FreeType');
    }
   
    _finalizer.attach(this, this);
  }

  /// Open a font file using its pathname. `face_index` should be 0 if there is only 1 font
  /// in the file.
  Face newFace(String path, {int faceIndex = 0}) {
    Pointer<FT_Face> face = allocator<FT_Face>();
    final pathP = path.asCharP(allocator: allocator);
    final err = binding.FT_New_Face(raw.value, pathP, faceIndex, face);

    if (err == FT_Err_Unknown_File_Format) {
      throw Exception("Font format is unsupported");
    } else if (err == 1) {
      throw Exception("Font file is missing or corrupted");
    }

    return Face.fromRaw(
      raw.value,
      face.value,
      binding,
      allocator,
    );
  }

  void free() {
    if (_isFree) {
      return;
    }
    _isFree = true;
    _finalizer.detach(this);
    //ftb.FT_Done_Library(raw.value);
    binding.FT_Done_FreeType(raw.value);
  }
}

class Face {
  FT_Library library_raw;
  FT_Face raw;
  late GlyphSlot glyph;
  FreetypeBinding binding;
  dynamic bytes;
  Allocator allocator;

  bool _isFree = false;

  Face.fromRaw(
    this.library_raw,
    this.raw,
    this.binding,
    this.allocator, {
    this.bytes,
  }) {  
    glyph = GlyphSlot.fromRaw(library_raw, raw.ref.glyph, binding);
  }

  void setCharSize(
      int charWidth, int charHeight, int horzResolution, int vertResolution) {
    final err = binding.FT_Set_Char_Size(
      raw,
      charWidth,
      charHeight,
      horzResolution,
      vertResolution,
    );

    if (err != FT_Err_Ok) {
      throw Exception('Error on set Char Size');
    }
  }

  void setPixelSizes(int pixel_width, int pixel_height) {
    final err = binding.FT_Set_Pixel_Sizes(raw, pixel_width, pixel_height);
    if (err != FT_Err_Ok) {
      throw Exception('Error on set Pixel Sizes');
    }
  }

  void loadGlyph(int glyphIndex, LoadFlag load_flags) {
    final err = binding.FT_Load_Glyph(raw, glyphIndex, load_flags.value);
    if (err != FT_Err_Ok) {
      throw Exception('Error on load Glyph');
    }
  }

  bool loadChar(int char_code, LoadFlag load_flags) {
    final err = binding.FT_Load_Char(raw, char_code, load_flags.value);
    if (err != FT_Err_Ok) {
      //throw Exception('Error on load Char');
      print("error FT_Load_Char");
      return false;
    }
    return true;
  }

  int getCharIndex(int charcode) {
    final res = binding.FT_Get_Char_Index(raw, charcode);
    if (res == 0) {
      throw Exception('undefined character code');
    }
    return res;
  }

  void setTransform(Matrix matrix, Vector delta) {
    binding.FT_Set_Transform(raw, matrix.toFtMatrixP(), delta.toFtVectorP());
  }

  int get ascender {
    return raw.ref.ascender;
  }

  int get descender {
    return raw.ref.descender;
  }

  int get emSize {
    return raw.ref.units_per_EM;
  }

  int get height {
    return raw.ref.height;
  }

  int get maxAdvanceWidth {
    return raw.ref.max_advance_width;
  }

  int get maxAdvanceHeight {
    return raw.ref.max_advance_height;
  }

  int get underlinePosition {
    return raw.ref.underline_position;
  }

  int get numGlyphs {
    return raw.ref.num_glyphs;
  }

  int get numFaces {
    return raw.ref.num_faces;
  }

  String get familyName {
    return raw.ref.family_name.cast<Utf8>().toDartString();
  }

  String get styleName {
    return raw.ref.style_name.cast<Utf8>().toDartString();
  }

  void free() {
    if (_isFree) {
      return;
    }
    _isFree = true;
    //_finalizer.detach(this); 
    binding.FT_Done_Face(raw);
  }
}

/// enum
class LoadFlag {
  final int value;
  const LoadFlag(this.value);
  static const DEFAULT = const LoadFlag(FT_LOAD_DEFAULT);
  static const NO_SCALE = const LoadFlag(FT_LOAD_NO_SCALE);
  static const NO_HINTING = const LoadFlag(FT_LOAD_NO_HINTING);
  static const RENDER = const LoadFlag(FT_LOAD_RENDER);
  static const NO_BITMAP = const LoadFlag(FT_LOAD_NO_BITMAP);
  static const VERTICAL_LAYOUT = const LoadFlag(FT_LOAD_VERTICAL_LAYOUT);
  static const FORCE_AUTOHINT = const LoadFlag(FT_LOAD_FORCE_AUTOHINT);
  static const CROP_BITMAP = const LoadFlag(FT_LOAD_CROP_BITMAP);
  static const PEDANTIC = const LoadFlag(FT_LOAD_PEDANTIC);
  static const IGNORE_GLOBAL_ADVANCE_WITH =
      const LoadFlag(FT_LOAD_IGNORE_GLOBAL_ADVANCE_WIDTH);
  static const NO_RECURSE = const LoadFlag(FT_LOAD_NO_RECURSE);
  static const IGNORE_TRANSFORM = const LoadFlag(FT_LOAD_IGNORE_TRANSFORM);
  static const MONOCHROME = const LoadFlag(FT_LOAD_MONOCHROME);
  static const LINEAR_DESIGN = const LoadFlag(FT_LOAD_LINEAR_DESIGN);
  static const NO_AUTOHINT = const LoadFlag(FT_LOAD_NO_AUTOHINT);
  static const TARGET_NORMAL = const LoadFlag(FT_LOAD_TARGET_NORMAL);
  static const TARGET_LIGHT = const LoadFlag(FT_LOAD_TARGET_LIGHT);
  static const TARGET_MONO = const LoadFlag(FT_LOAD_TARGET_MONO);
  static const TARGET_LCD = const LoadFlag(FT_LOAD_TARGET_LCD);
  static const TARGET_LCD_V = const LoadFlag(FT_LOAD_TARGET_LCD_V);
  static const COLOR = const LoadFlag(FT_LOAD_COLOR);
}

class RenderMode {
  final int value;
  const RenderMode(this.value);
  static const Normal = const LoadFlag(FT_Render_Mode_.FT_RENDER_MODE_NORMAL);
  static const Light = const LoadFlag(FT_Render_Mode_.FT_RENDER_MODE_LIGHT);
  static const Mono = const LoadFlag(FT_Render_Mode_.FT_RENDER_MODE_MONO);
  static const Lcd = const LoadFlag(FT_Render_Mode_.FT_RENDER_MODE_LCD);
  static const LcdV = const LoadFlag(FT_Render_Mode_.FT_RENDER_MODE_LCD_V);
  static const Sdf = const LoadFlag(FT_Render_Mode_.FT_RENDER_MODE_SDF);
  static const Max = const LoadFlag(FT_Render_Mode_.FT_RENDER_MODE_MAX);
}

class GlyphSlot {
  FT_Library library_raw;
  FT_GlyphSlot raw;
  FreetypeBinding binding;

  GlyphSlot.fromRaw(
    this.library_raw,
    this.raw,
    this.binding,
  );

  /// Convert a given glyph image to a bitmap. It does so by inspecting the glyph image format,
  /// finding the relevant renderer, and invoking it.
  void renderGlyph(RenderMode render_mode) {
    final err = binding.FT_Render_Glyph(raw, render_mode.value);
    if (err != FT_Err_Ok) {
      throw Exception('Error on render glyph');
    }
  }

  Vector get advance {
    return Vector.fromFtVector(raw.ref.advance);
  }

  Bitmap bitmap() {
    return Bitmap.fromRaw(raw);
  }

  /// The bitmap's left bearing expressed in integer pixels. Only valid if the format is
  /// FT_GLYPH_FORMAT_BITMAP, this is, if the glyph slot contains a bitmap.
  int get bitmapLeft {
    return raw.ref.bitmap_left;
  }

  /// The bitmap's top bearing expressed in integer pixels. Remember that this is the distance
  /// from the baseline to the top-most glyph scanline, upwards y coordinates being positive.
  int get bitmapTop {
    return raw.ref.bitmap_top;
  }
}

class Bitmap {
  FT_GlyphSlot slot;

  FT_Bitmap get raw {
    return slot.ref.bitmap;
  }

  Bitmap.fromRaw(this.slot);

  /// A typeless pointer to the bitmap buffer. This value should be aligned
  /// on 32-bit boundaries in most cases.
  List<int> get buffer {
    final bufferSize = pitch * rows;
    if (bufferSize > 0) {
      return slot.ref.bitmap.buffer.cast<Int8>().asTypedList((pitch * rows).toInt());
    } else {
      return <int>[];
    }
  }

  int get pitch => slot.ref.bitmap.pitch;
  int get rows => slot.ref.bitmap.rows;
  int get width => slot.ref.bitmap.width;
  int get numGrays => slot.ref.bitmap.num_grays;
  int get pixelMode => slot.ref.bitmap.pixel_mode;
  int get paletteMode => slot.ref.bitmap.palette_mode;
}

class Vector {
  int x;
  int y;

  Vector(
    this.x,
    this.y,
  );

  factory Vector.fromFtVector(FT_Vector ftv) {
    return Vector(ftv.x, ftv.y);
  }

  Pointer<FT_Vector> toFtVectorP() {
    final v = calloc<FT_Vector>();
    v.ref.x = x;
    v.ref.y = y;
    return v;
  }
}

class Matrix {
  int xx;
  int xy;
  int yx;
  int yy;

  Matrix(
    this.xx,
    this.xy,
    this.yx,
    this.yy,
  );

  factory Matrix.fromFtMatrix(FT_Matrix ftv) {
    return Matrix(ftv.xx, ftv.xy, ftv.yx, ftv.yy);
  }

  Pointer<FT_Matrix> toFtMatrixP() {
    final v = calloc<FT_Matrix>();
    v.ref.xx = xx;
    v.ref.xy = xy;
    v.ref.yx = yx;
    v.ref.yy = yy;
    return v;
  }
}
