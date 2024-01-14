import 'dart:ffi';
import 'structs/typedefs.dart';

// manual Bindings
class FeetypeBindings {
  final DynamicLibrary dylib;
  final Pointer<T> Function<T extends NativeType>(String symbolName) _lookup;

  FeetypeBindings(this.dylib) : _lookup = dylib.lookup;

  /// Initialize a new FreeType library object.  The set of modules that are
  /// registered by this function is determined at build time.
  late final FT_Init_FreeType =
      _lookup<NativeFunction<FT_Error Function(Pointer<FT_Library> library)>>(
              'FT_Init_FreeType')
          .asFunction<int Function(Pointer<FT_Library> library)>();

  late final FT_Done_FreeType =
      _lookup<NativeFunction<Int Function(FT_Library library)>>(
              'FT_Done_FreeType')
          .asFunction<int Function(FT_Library library)>();

  late final FT_Set_Default_Properties =
      _lookup<NativeFunction<Void Function(FT_Library library)>>(
              'FT_Set_Default_Properties')
          .asFunction<void Function(FT_Library library)>();

  late final FT_Property_Get = _lookup<
          NativeFunction<
              FT_Error Function(
                FT_Library library,
                Pointer<FT_String> module_name,
                Pointer<FT_String> property_name,
                Pointer<Void> value,
              )>>('FT_Property_Get')
      .asFunction<
          int Function(
            FT_Library library,
            Pointer<FT_String> module_name,
            Pointer<FT_String> property_name,
            Pointer<Void> value,
          )>();

  late final FT_Property_Set = _lookup<
          NativeFunction<
              FT_Error Function(
                FT_Library library,
                Pointer<FT_String> module_name,
                Pointer<FT_String> property_name,
                Pointer<Void> value,
              )>>('FT_Property_Set')
      .asFunction<
          int Function(
            FT_Library library,
            Pointer<FT_String> module_name,
            Pointer<FT_String> property_name,
            Pointer<Void> value,
          )>();

  late final FT_New_Library = _lookup<
          NativeFunction<
              FT_Error Function(FT_Memory memory,
                  Pointer<FT_Library> alibrary)>>('FT_New_Library')
      .asFunction<
          int Function(FT_Memory memory, Pointer<FT_Library> alibrary)>();

  late final FT_Done_Library =
      _lookup<NativeFunction<FT_Error Function(FT_Library library)>>(
              'FT_Done_Library')
          .asFunction<int Function(FT_Library library)>();

  late final FT_Reference_Library =
      _lookup<NativeFunction<FT_Error Function(FT_Library library)>>(
              'FT_Reference_Library')
          .asFunction<int Function(FT_Library library)>();

  late final FT_Add_Default_Modules =
      _lookup<NativeFunction<Void Function(FT_Library library)>>(
              'FT_Add_Default_Modules')
          .asFunction<void Function(FT_Library library)>();

  late final FT_New_Face = _lookup<
          NativeFunction<
              FT_Error Function(
                FT_Library library,
                Pointer<c_char> filepathname,
                FT_Long face_index,
                Pointer<FT_Face> aface,
              )>>('FT_New_Face')
      .asFunction<
          int Function(
            FT_Library library,
            Pointer<c_char> filepathname,
            int face_index,
            Pointer<FT_Face> aface,
          )>();

  late final FT_Set_Char_Size = _lookup<
          NativeFunction<
              FT_Error Function(
                FT_Face face,
                FT_F26Dot6 char_width,
                FT_F26Dot6 char_height,
                FT_UInt horz_resolution,
                FT_UInt vert_resolution,
              )>>('FT_Set_Char_Size')
      .asFunction<
          int Function(
            FT_Face face,
            int char_width,
            int char_height,
            int horz_resolution,
            int vert_resolution,
          )>();

  late final FT_Load_Char = _lookup<
          NativeFunction<
              FT_Error Function(
                FT_Face face,
                FT_ULong char_code,
                FT_Int32 load_flags,
              )>>('FT_Load_Char')
      .asFunction<
          int Function(
            FT_Face face,
            int char_code,
            int load_flags,
          )>();


}
