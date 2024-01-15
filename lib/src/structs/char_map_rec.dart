import 'dart:ffi';
import 'typedefs.dart';
// pub struct FT_CharMapRec {
//     pub face: FT_Face,
//     pub encoding: FT_Encoding,
//     pub platform_id: FT_UShort,
//     pub encoding_id: FT_UShort,
// }

//  typedef struct  FT_CharMapRec_
//   {
//     FT_Face      face;
//     FT_Encoding  encoding;
//     FT_UShort    platform_id;
//     FT_UShort    encoding_id;
//   } FT_CharMapRec;
/// https://freetype.org/freetype2/docs/reference/ft2-character_mapping.html#ft_charmaprec
/// size 16 
/// c++ size 16
final class FT_CharMapRec extends Struct {
  external FT_Face face;
  // enum  
  @FT_Encoding()
  external int encoding;
  @FT_UShort()
  external int platform_id;
  @FT_UShort()
  external int encoding_id;
}

abstract class FT_Encoding_ {
  static const int FT_ENCODING_NONE = 0;
  static const int FT_ENCODING_MS_SYMBOL = 1;
  static const int FT_ENCODING_UNICODE = 2;
  static const int FT_ENCODING_SJIS = 3;
  static const int FT_ENCODING_PRC = 4;
  static const int FT_ENCODING_BIG5 = 5;
  static const int FT_ENCODING_WANSUNG = 6;
  static const int FT_ENCODING_JOHAB = 7;
  static const int FT_ENCODING_GB2312 = 4;
  static const int FT_ENCODING_MS_SJIS = 3;
  static const int FT_ENCODING_MS_GB2312 = 4;
  static const int FT_ENCODING_MS_BIG5 = 5;
  static const int FT_ENCODING_MS_WANSUNG = 6;
  static const int FT_ENCODING_MS_JOHAB = 7;
  static const int FT_ENCODING_ADOBE_STANDARD = 8;
  static const int FT_ENCODING_ADOBE_EXPERT = 9;
  static const int FT_ENCODING_ADOBE_CUSTOM = 10;
  static const int FT_ENCODING_ADOBE_LATIN_1 = 11;
  static const int FT_ENCODING_OLD_LATIN_2 = 12;
  static const int FT_ENCODING_APPLE_ROMAN = 13;
}

const int ft_encoding_none = 0;
const int ft_encoding_unicode = 2;
const int ft_encoding_symbol = 1;
const int ft_encoding_latin_1 = 11;
const int ft_encoding_latin_2 = 12;
const int ft_encoding_sjis = 3;
const int ft_encoding_gb2312 = 4;
const int ft_encoding_big5 = 5;
const int ft_encoding_wansung = 6;
const int ft_encoding_johab = 7;
const int ft_encoding_adobe_standard = 8;
const int ft_encoding_adobe_expert = 9;
const int ft_encoding_adobe_custom = 10;
const int ft_encoding_apple_roman = 13;