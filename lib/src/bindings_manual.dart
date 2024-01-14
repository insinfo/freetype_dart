import 'dart:ffi';
import 'structs/constants.dart';
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

  /// [face]  handle to face object         
  /// [char_width] char_width in 1/64 of points   
  /// [char_height]  char_height in 1/64 of points  
  /// [horz_resolution]   horizontal device resolution   
  /// [vert_resolution]   vertical device resolution     
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

  late final FT_Set_Pixel_Sizes = _lookup<
          NativeFunction<
              FT_Error Function(
                FT_Face face,
                FT_UInt pixel_width,
                FT_UInt pixel_height,
              )>>('FT_Set_Pixel_Sizes')
      .asFunction<
          int Function(
            FT_Face face,
            int pixel_width,
            int pixel_height,
          )>();

  late final FT_Get_Char_Index = _lookup<
          NativeFunction<
              FT_Error Function(
                FT_Face face,
                FT_ULong charcode,
              )>>('FT_Get_Char_Index')
      .asFunction<
          int Function(
            FT_Face face,
            int charcode,
          )>();

  late final FT_Load_Glyph = _lookup<
          NativeFunction<
              FT_Error Function(
                FT_Face face,
                FT_UInt glyph_index,
                FT_Int32 load_flags,
              )>>('FT_Load_Glyph')
      .asFunction<
          int Function(
            FT_Face face,
            int glyph_index,
            int load_flags,
          )>();

  late final FT_Render_Glyph = _lookup<
          NativeFunction<
              FT_Error Function(
                FT_GlyphSlot slot,
                FT_Render_Mode render_mode,
              )>>('FT_Render_Glyph')
      .asFunction<
          int Function(
            FT_GlyphSlot slot,
            int render_mode,
          )>();

  late final FT_Done_Face =
      _lookup<NativeFunction<FT_Error Function(FT_Face face)>>(
              'FT_Render_Glyph')
          .asFunction<int Function(FT_Face face)>();

  late final FT_Get_First_Char = _lookup<
          NativeFunction<
              FT_ULong Function(
                FT_Face face,
                Pointer<FT_UInt> agindex,
              )>>('FT_Get_First_Char')
      .asFunction<
          int Function(
            FT_Face face,
            Pointer<FT_UInt> agindex,
          )>();

  late final FT_Get_Next_Char = _lookup<
          NativeFunction<
              FT_ULong Function(
                FT_Face face,
                FT_ULong char_code,
                Pointer<FT_UInt> agindex,
              )>>('FT_Get_Next_Char')
      .asFunction<
          int Function(
            FT_Face face,
            int char_code,
            Pointer<FT_UInt> agindex,
          )>();

  late final FT_Select_Charmap = _lookup<
          NativeFunction<
              FT_ULong Function(
                FT_Face face,
                FT_Encoding encoding,
              )>>('FT_Select_Charmap')
      .asFunction<
          int Function(
            FT_Face face,
            int encoding,
          )>();

  late final FT_Get_Glyph_Name = _lookup<
          NativeFunction<
              FT_ULong Function(
                FT_Face face,
                FT_UInt glyph_index,
                FT_Pointer buffer,
                FT_UInt buffer_max,
              )>>('FT_Get_Glyph_Name')
      .asFunction<
          int Function(
            FT_Face face,
            int glyph_index,
            FT_Pointer buffer,
            int buffer_max,
          )>();
}
