import 'dart:ffi';
import 'typedefs.dart';
// pub struct FT_ListRec {
//     pub head: FT_ListNode,
//     pub tail: FT_ListNode,
// }
/// size 16
final class FT_ListRec extends Struct {
  external FT_ListNode head;
  external FT_ListNode tail;
}