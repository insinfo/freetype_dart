import 'dart:ffi';


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

//  typedef struct  FT_Bitmap_
//   {
//     unsigned int    rows;
//     unsigned int    width;
//     int             pitch;
//     unsigned char*  buffer;
//     unsigned short  num_grays;
//     unsigned char   pixel_mode;
//     unsigned char   palette_mode;
//     void*           palette;
//   } FT_Bitmap;

/// size 40
final class FT_Bitmap extends Struct {
  @UnsignedInt()
  external int rows;
  @UnsignedInt()
  external int width;
  @Int()
  external int pitch;
  external Pointer<UnsignedChar> buffer;
  @Short()
  external int num_grays;
  @UnsignedChar()
  external int pixel_mode;
  @UnsignedChar()
  external int palette_mode;
  external Pointer<Void> palette;
}

extension FT_BitmapEx on FT_Bitmap {
  List<int> get bufferAsList {
    final pitch = this.pitch;
    final rows = this.rows;
   
    final buffer = this.buffer.cast<Int8>().asTypedList((pitch * rows).toInt());
    return buffer;
  }
}
