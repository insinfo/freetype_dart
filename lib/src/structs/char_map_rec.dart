import 'dart:ffi';
import 'typedefs.dart';
// pub struct FT_CharMapRec {
//     pub face: FT_Face,
//     pub encoding: FT_Encoding,
//     pub platform_id: FT_UShort,
//     pub encoding_id: FT_UShort,
// }
/// size 16
final class FT_CharMapRec extends Struct {
  external FT_Face face;
  @FT_Encoding()
  external int encoding;
  @FT_UShort()
  external int platform_id;
  @FT_UShort()
  external int encoding_id;
}