import 'dart:ffi';

import 'generic.dart';
import 'size_metrics.dart';
import 'typedefs.dart';

// pub struct FT_SizeRec {
//     pub face: FT_Face,
//     pub generic: FT_Generic,
//     pub metrics: FT_Size_Metrics,
//     pub internal: FT_Size_Internal,
// }
/// size 64
final class FT_SizeRec extends Struct {
  external FT_Face face;
  external FT_Generic generic;
  external FT_Size_Metrics metrics;
  external FT_Size_Internal internal;
}
