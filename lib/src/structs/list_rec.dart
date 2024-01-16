import 'dart:ffi';
import 'typedefs.dart';
// pub struct FT_ListRec {
//     pub head: FT_ListNode,
//     pub tail: FT_ListNode,
// }

// typedef struct  FT_ListRec_
// {
//   FT_ListNode  head;
//   FT_ListNode  tail;
// } FT_ListRec;

/// size 16 
/// c++ size 16
final class FT_ListRec extends Struct {
  external FT_ListNode head;
  external FT_ListNode tail;
}