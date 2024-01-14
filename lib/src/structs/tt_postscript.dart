
import 'dart:ffi';

// pub struct TT_Postscript {
//     pub formatType: FT_Fixed,
//     pub italicAngle: FT_Fixed,
//     pub underlinePosition: FT_Short,
//     pub underlineThickness: FT_Short,
//     pub isFixedPitch: FT_ULong,
//     pub minMemType42: FT_ULong,
//     pub maxMemType42: FT_ULong,
//     pub minMemType1: FT_ULong,
//     pub maxMemType1: FT_ULong,
//     /* Glyph names follow in the 'post' table, but we don't */
//     /* load them by default.                                */
// }
/// size 32
final class TT_Postscript extends Opaque {}