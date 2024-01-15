import 'dart:ffi';
import 'typedefs.dart';

// pub struct FT_MemoryRec {
//     pub user: *mut c_void,
//     pub alloc: FT_Alloc_Func,
//     pub free: FT_Free_Func,
//     pub realloc: FT_Realloc_Func,
// }

//  struct  FT_MemoryRec_
//   {
//     void*            user;
//     FT_Alloc_Func    alloc;
//     FT_Free_Func     free;
//     FT_Realloc_Func  realloc;
//   };

/// 32
final class FT_MemoryRec extends Struct {
  external Pointer<Void> user;
  external FT_Alloc_Func alloc;
  external FT_Free_Func free;
  external FT_Realloc_Func realloc;
}