import 'dart:ffi';

import 'typedefs.dart';

// pub struct FT_Matrix {
//     pub xx: FT_Fixed,
//     pub xy: FT_Fixed,
//     pub yx: FT_Fixed,
//     pub yy: FT_Fixed,
// }

/// size 16
final class FT_Matrix extends Struct {
  @FT_Fixed()
  external int xx;

  @FT_Fixed()
  external int xy;

  @FT_Fixed()
  external int yx;

  @FT_Fixed()
  external int yy;
}