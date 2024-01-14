import 'dart:ffi';
import 'typedefs.dart';
// pub struct FT_StreamRec {
//     pub base: *mut c_uchar,
//     pub size: c_ulong,
//     pub pos: c_ulong,
//     pub descriptor: FT_StreamDesc,
//     pub pathname: FT_StreamDesc,
//     pub read: FT_Stream_IoFunc,
//     pub close: FT_Stream_CloseFunc,
//     pub memory: FT_Memory,
//     pub cursor: *mut c_uchar,
//     pub limit: *mut c_uchar,
//}
/// size 72
final class FT_StreamRec extends Struct {
  external Pointer<c_uchar> base;
  @c_ulong()
  external int size;
  @c_ulong()
  external int pos;
  external FT_StreamDesc descriptor;
  external FT_StreamDesc pathname;
  external FT_Stream_IO read;
  external FT_Stream_Close close;
  external FT_Memory memory;
  external Pointer<Char> cursor;
  external Pointer<Char> limit;
}
