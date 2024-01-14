import 'dart:ffi';
import 'typedefs.dart';

// pub struct FT_Size_RequestRec {
//     pub size_request_type: FT_Size_Request_Type, // type
//     pub width: FT_Long,
//     pub height: FT_Long,
//     pub horiResolution: FT_UInt,
//     pub vertResolution: FT_UInt,
// }
/// size 20
final class FT_Size_RequestRec extends Struct {
  @FT_Size_Request_Type()
  external int type;

  @FT_Long()
  external int width;

  @FT_Long()
  external int height;

  @FT_UInt()
  external int horiResolution;

  @FT_UInt()
  external int vertResolution;
}
