import 'dart:ffi';
import 'typedefs.dart';
// pub struct FT_Generic {
//     pub data: *mut c_void,
//     pub finalizer: FT_Generic_Finalizer,
// }
/// size 16
final class FT_Generic extends Struct {
  external Pointer<c_void> data;
  external FT_Generic_Finalizer finalizer;
}

