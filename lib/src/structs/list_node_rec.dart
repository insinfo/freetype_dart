import 'dart:ffi';
import 'typedefs.dart';
// pub struct FT_ListNodeRec {
//     pub prev: FT_ListNode,
//     pub next: FT_ListNode,
//     pub data: *mut c_void,
// }

//  typedef struct  FT_ListNodeRec_
//   {
//     FT_ListNode  prev;
//     FT_ListNode  next;
//     void*        data;

//   } FT_ListNodeRec;

/// 24
final class FT_ListNodeRec extends Struct {
  external FT_ListNode prev;
  external FT_ListNode next;
  external Pointer<Void> data;
}