import 'dart:ffi';

import 'bitmap_glyph_rec.dart';
import 'char_map_rec.dart';
import 'face_rec.dart';
import 'glyph_rec.dart';
import 'glyph_slot_rec.dart';
import 'list_node_rec.dart';
import 'memory_rec.dart';
import 'outline_glyph_rec.dart';
import 'size_rec.dart';
import 'size_request_rec.dart';
import 'stream_rec_.dart';
import 'tt_os2.dart';
import 'tt_postscript.dart';

// c types
typedef c_void = Void;
typedef c_schar = Int8; //i8
typedef c_uchar = Uint8; //u8
typedef c_short = Int16; //i16
typedef c_ushort = Uint16; //u16
typedef c_int = Int32; //i32
typedef c_uint = Uint32; //u32
typedef c_float = Float; //f32
typedef c_double = Double; //f64
typedef c_longlong = Int64; //i64
typedef c_ulonglong = Uint64; //u64
typedef intmax_t = Int64; //i64
typedef uintmax_t = Uint64; //u64

typedef size_t = Size; //usize
typedef ptrdiff_t = IntPtr; //isize
typedef intptr_t = IntPtr; //isize
typedef uintptr_t = IntPtr; //usize
typedef ssize_t = IntPtr; //isize
typedef sighandler_t = IntPtr; //usize

typedef c_char = Int8; //i8
typedef c_long = Int32; //i32
typedef c_ulong = Uint32; //u32
typedef wchar_t = Uint16; //u16

typedef clock_t = Int32; //i32

typedef errno_t = c_int; // Aliasing c_int

// Basic Data Types
typedef FT_Byte = c_uchar;
typedef FT_Bytes = Pointer<FT_Byte>; //*const FT_Byte;
typedef FT_Char = c_char;
typedef FT_Int = c_int;
typedef FT_UInt = c_uint;
typedef FT_Int16 = c_short;
typedef FT_UInt16 = c_ushort;
typedef FT_Int32 = Int32;
typedef FT_UInt32 = Uint32;
typedef FT_Int64 = Int64;
typedef FT_UInt64 = Uint64;
typedef FT_Short = c_short;
typedef FT_UShort = c_ushort;
typedef FT_Long = c_long;
typedef FT_ULong = c_ulong;
typedef FT_Bool = c_uchar;
typedef FT_Offset = size_t;
typedef FT_PtrDist = ptrdiff_t;
typedef FT_String = c_char;
typedef FT_Tag = FT_UInt32;
typedef FT_Error = c_int;
typedef FT_Fixed = c_long;
typedef FT_Pointer = Pointer<Void>; // Mutable pointer to void *mut c_void;
typedef FT_Pos = c_long;
typedef FT_FWord = c_short;
typedef FT_UFWord = c_ushort;
typedef FT_F2Dot14 = c_short;
typedef FT_F26Dot6 = c_long;
typedef FT_Encoding = c_uint;

typedef FT_Size_Request_Type = c_uint;

typedef FT_Generic_Finalizer
    = Pointer<NativeFunction<FT_Generic_FinalizerFunction>>;

typedef FT_Generic_FinalizerFunction = Void Function(Pointer<Void> object);
typedef DartFT_Generic_FinalizerFunction = void Function(Pointer<Void> object);

final class FT_StreamDesc_ extends Union {
  @Long()
  external int value;
  external Pointer<Void> pointer;
}

/// I / O   M A N A G E M E N T
typedef FT_StreamDesc = FT_StreamDesc_;

typedef FT_Stream_IO = Pointer<NativeFunction<FT_Stream_IOFunction>>;

typedef FT_Stream_IOFunction = UnsignedLong Function(FT_Stream stream,
    UnsignedLong offset, Pointer<Char> buffer, UnsignedLong count);

//pub type FT_Stream_IoFunc = extern "C" fn(FT_Stream, c_ulong, *mut c_uchar, c_ulong) -> c_ulong;
typedef DartFT_Stream_IOFunction = int Function(
    FT_Stream stream, int offset, Pointer<Char> buffer, int count);

//pub type FT_Stream_CloseFunc = extern "C" fn(FT_Stream);
typedef FT_Stream_Close = Pointer<NativeFunction<FT_Stream_CloseFunction>>;
typedef FT_Stream_CloseFunction = Void Function(FT_Stream stream);
typedef DartFT_Stream_CloseFunction = void Function(FT_Stream stream);

/// M E M O R Y   M A N A G E M E N T

typedef FT_Alloc_Func = Pointer<NativeFunction<FT_Alloc_FuncFunction>>;
typedef FT_Alloc_FuncFunction = Pointer<Void> Function(
    FT_Memory memory, Long size);
typedef DartFT_Alloc_FuncFunction = Pointer<Void> Function(
    FT_Memory memory, int size);

typedef FT_Free_Func = Pointer<NativeFunction<FT_Free_FuncFunction>>;
typedef FT_Free_FuncFunction = Void Function(
    FT_Memory memory, Pointer<Void> block);
typedef DartFT_Free_FuncFunction = void Function(
    FT_Memory memory, Pointer<Void> block);

//pub type FT_Realloc_Func = extern "C" fn(FT_Memory, c_long, c_long, *mut c_void) -> *mut c_void;
typedef FT_Realloc_Func = Pointer<NativeFunction<FT_Realloc_FuncFunction>>;

typedef FT_Realloc_FuncFunction = Pointer<Void> Function(
    FT_Memory memory, Long cur_size, Long new_size, Pointer<Void> block);

typedef DartFT_Realloc_FuncFunction = Pointer<Void> Function(
    FT_Memory memory, int cur_size, int new_size, Pointer<Void> block);

// Internal Types
final class FT_LibraryRec extends Opaque {}
final class FT_ModuleRec extends Opaque {}
final class FT_DriverRec extends Opaque {}
final class FT_RendererRec extends Opaque {}
final class FT_Size_InternalRec extends Opaque {}
final class FT_SubGlyphRec extends Opaque {}
final class FT_Slot_InternalRec extends Opaque {}
final class FT_Face_InternalRec extends Opaque {}
final class FT_StrokerRec extends Opaque {}
final class FT_DriverRec_ extends Opaque {}

//typedef *mut = Pointer;

// typedef FT_LibraryRec = c_void;
// typedef FT_ModuleRec = c_void;
// typedef FT_DriverRec = c_void;
// typedef FT_RendererRec = c_void;
// typedef FT_Size_InternalRec = c_void;
// typedef FT_SubGlyphRec = c_void;
// typedef FT_Slot_InternalRec = c_void;
// typedef FT_Face_InternalRec = c_void;
// typedef FT_StrokerRec = c_void;

// Objects
typedef FT_Library = Pointer<FT_LibraryRec>;
typedef FT_Face = Pointer<FT_FaceRec>;
typedef FT_Size = Pointer<FT_SizeRec>;
typedef FT_GlyphSlot = Pointer<FT_GlyphSlotRec>;
typedef FT_CharMap = Pointer<FT_CharMapRec>;
typedef FT_Module = Pointer<FT_ModuleRec>;
typedef FT_Driver = Pointer<FT_DriverRec>;
typedef FT_Renderer = Pointer<FT_RendererRec>;
typedef FT_Size_Internal = Pointer<FT_Size_InternalRec>;
typedef FT_SubGlyph = Pointer<FT_SubGlyphRec>;
typedef FT_Slot_Internal = Pointer<FT_Slot_InternalRec>;
typedef FT_Size_Request = Pointer<FT_Size_RequestRec>;
typedef FT_Face_Internal = Pointer<FT_Face_InternalRec>;
typedef FT_Stream = Pointer<FT_StreamRec>;
typedef FT_Memory = Pointer<FT_MemoryRec>;
typedef FT_ListNode = Pointer<FT_ListNodeRec>;
typedef FT_Glyph = Pointer<FT_GlyphRec>;
typedef FT_BitmapGlyph = Pointer<FT_BitmapGlyphRec>;
typedef FT_OutlineGlyph = Pointer<FT_OutlineGlyphRec>;
typedef FT_Stroker = Pointer<FT_StrokerRec>;
typedef TT_OS2_Internal = Pointer<TT_OS2>;
typedef TT_Postscript_Internal = Pointer<TT_Postscript>;

typedef FT_Glyph_Format = c_uint;
