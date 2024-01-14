import 'dart:ffi';

import 'matrix.dart';
import 'typedefs.dart';

final class FT_SubGlyph_ extends Struct {
  @FT_Int()
  external int index;

  external Pointer<FT_Byte> control_data;

  @FT_Int()
  external int control_len;

  @FT_UShort()
  external int flags;

  @FT_Int()
  external int arg1;

  @FT_Int()
  external int arg2;

  external FT_Matrix transform;

  external Pointer<FT_SubGlyph> parent;
}