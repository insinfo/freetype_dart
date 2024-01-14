import 'dart:ffi';
import 'typedefs.dart';

// pub struct FT_Bitmap {
//     pub rows: c_int,
//     pub width: c_int,
//     pub pitch: c_int,
//     pub buffer: *mut c_uchar,
//     pub num_grays: c_short,
//     pub pixel_mode: c_char,
//     pub palette_mode: c_char,
//     pub palette: *mut c_void,
// }
/// size 40
final class FT_Bitmap extends Struct {
  @c_int()
  external int rows;
  @c_int()
  external int width;
  @c_int()
  external int pitch;
  external Pointer<c_uchar> buffer;
  @c_short()
  external int num_grays;
  @c_char()
  external int pixel_mode;
  @c_char()
  external int palette_mode;
  external Pointer<c_void> palette;
}

extension FT_BitmapEx on FT_Bitmap {
  List<int> get bufferAsList {
    final pitch = this.pitch;
    final rows = this.rows;
    final bufferPointer = this.buffer;
    final buffer = bufferPointer.asTypedList((pitch * rows).toInt());
    return buffer;
  }
}
