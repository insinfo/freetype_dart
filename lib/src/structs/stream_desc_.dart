import 'dart:ffi';

  // typedef union  FT_StreamDesc_
  // {
  //   long   value;
  //   void*  pointer;
  // } FT_StreamDesc;

final class FT_StreamDesc_ extends Union {
  @Long()
  external int value;
  external Pointer<Void> pointer;
}