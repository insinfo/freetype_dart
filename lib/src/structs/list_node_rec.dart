import 'dart:ffi';
import 'typedefs.dart';
// pub struct FT_ListNodeRec {
//     pub prev: FT_ListNode,
//     pub next: FT_ListNode,
//     pub data: *mut c_void,
// }
/// 24
final class FT_ListNodeRec extends Struct {
  external FT_ListNode prev;
  external FT_ListNode next;
  external Pointer<Void> data;
}