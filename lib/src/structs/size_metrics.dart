import 'dart:ffi';

import 'typedefs.dart';
// pub struct FT_Size_Metrics {
//     pub x_ppem: FT_UShort,
//     pub y_ppem: FT_UShort,
//     pub x_scale: FT_Fixed,
//     pub y_scale: FT_Fixed,
//     pub ascender: FT_Pos,
//     pub descender: FT_Pos,
//     pub height: FT_Pos,
//     pub max_advance: FT_Pos,
// }

// typedef struct  FT_Size_Metrics_
//   {
//     FT_UShort  x_ppem;      /* horizontal pixels per EM               */
//     FT_UShort  y_ppem;      /* vertical pixels per EM                 */
//     FT_Fixed   x_scale;     /* scaling values used to convert font    */
//     FT_Fixed   y_scale;     /* units to 26.6 fractional pixels        */
//     FT_Pos     ascender;    /* ascender in 26.6 frac. pixels          */
//     FT_Pos     descender;   /* descender in 26.6 frac. pixels         */
//     FT_Pos     height;      /* text height in 26.6 frac. pixels       */
//     FT_Pos     max_advance; /* max horizontal advance, in 26.6 pixels */
//   } FT_Size_Metrics;

/// size 28
/// c++ size 56
final class FT_Size_Metrics extends Struct {
  @FT_UShort()
  external int x_ppem;
  @FT_UShort()
  external int y_ppem;
  @FT_Fixed()
  external int x_scale;
  @FT_Fixed()
  external int y_scale;
  @FT_Pos()
  external int ascender;
  @FT_Pos()
  external int descender;
  @FT_Pos()
  external int height;
  @FT_Pos()
  external int max_advance;
}
