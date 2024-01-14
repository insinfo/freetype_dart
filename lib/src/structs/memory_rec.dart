import 'dart:ffi';
import 'typedefs.dart';

// pub struct FT_MemoryRec {
//     pub user: *mut c_void,
//     pub alloc: FT_Alloc_Func,
//     pub free: FT_Free_Func,
//     pub realloc: FT_Realloc_Func,
// }
/// 32
final class FT_MemoryRec extends Struct {
  external Pointer<c_void> user;
  external FT_Alloc_Func alloc;
  external FT_Free_Func free;
  external FT_Realloc_Func realloc;
}