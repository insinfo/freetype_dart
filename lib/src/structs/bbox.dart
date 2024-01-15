import 'dart:ffi';
import 'typedefs.dart';
// pub struct FT_BBox {
//     pub xMin: FT_Pos,
//     pub yMin: FT_Pos,
//     pub xMax: FT_Pos,
//     pub yMax: FT_Pos,
// }

//  typedef struct  FT_BBox_
//   {
//     FT_Pos  xMin, yMin;
//     FT_Pos  xMax, yMax;

//   } FT_BBox;

/// size 16
/// c++ size 32
final class FT_BBox extends Struct {
  @FT_Pos()
  external int xMin;

  @FT_Pos()
  external int yMin;

  @FT_Pos()
  external int xMax;

  @FT_Pos()
  external int yMax;
}