import 'dart:ffi';

import 'package:freetype_dart/src/structs/stream_desc_.dart';

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

// c void type
typedef c_void = Void;
/// signed char
typedef c_schar = SignedChar; //i8
/// unsigned char
typedef c_uchar = UnsignedChar; //u8
/// signed short
typedef c_short = Short; //i16
/// signed short
typedef c_ushort = UnsignedShort; //u16
/// signed int
typedef c_int = Int; //i32
/// unsigned int
typedef c_uint = UnsignedInt; //u32
/// float
typedef c_float = Float; //f32
/// double
typedef c_double = Double; //f64
/// signed long long
typedef c_longlong = LongLong; //i64
/// unsigned long long
typedef c_ulonglong = UnsignedLongLong; //u64
/// size_t 
typedef size_t = Size; //usize
/// char
typedef c_char = Char; //i8
/// signed long
typedef c_long = Long; //i32
/// unsigned long
typedef c_ulong = UnsignedLong; //u32
/// wchar_t
typedef wchar_t = WChar; //u16

//typedef intmax_t = Int64; //i64
//typedef uintmax_t = Uint64; //u64
//typedef ptrdiff_t = IntPtr; //isize
//typedef intptr_t = IntPtr; //isize
//typedef uintptr_t = IntPtr; //usize
//typedef ssize_t = IntPtr; //isize
//typedef sighandler_t = IntPtr; //usize
//typedef clock_t = Int32; //i32
//typedef errno_t = c_int; // Aliasing c_int

// Basic Data Types

/// size 1 typedef unsigned char  FT_Byte;
typedef FT_Byte = c_uchar;

/// size 8 typedef const FT_Byte*  FT_Bytes;
typedef FT_Bytes = Pointer<FT_Byte>;

/// typedef signed char  FT_Char;
typedef FT_Char = c_char;

///  size 4 typedef signed int  FT_Int;
typedef FT_Int = Int;
///  size 4 typedef unsigned int  FT_UInt; 
typedef FT_UInt = UnsignedInt;
///  size 2 typedef signed short  FT_Int16; A typedef for a 16bit signed integer type.
typedef FT_Int16 = Short;
///  size 2 typedef unsigned short  FT_UInt16; A typedef for a 16bit unsigned integer type.
typedef FT_UInt16 = UnsignedShort;
///  size 4 typedef signed XXX  FT_Int32; A typedef for a 32bit signed integer type. The size depends on the configuration.
typedef FT_Int32 = Int;
///  size 4 typedef unsigned XXX  FT_UInt32;
typedef FT_UInt32 = Uint32;
/// typedef signed XXX  FT_Int64; 
/// size 8 #define FT_INT64   long long int
typedef FT_Int64 = LongLong;
/// size 8 typedef unsigned XXX  FT_UInt64;
typedef FT_UInt64 = UnsignedLongLong;
/// size 2 typedef signed short  FT_Short;
typedef FT_Short = Short;
/// size 2 typedef unsigned short  FT_UShort;
typedef FT_UShort = UnsignedShort;
/// size 8 typedef signed long    FT_Long;
typedef FT_Long = Int64;//Long;
/// size 8 typedef unsigned long  FT_ULong;
typedef FT_ULong = Int64;//UnsignedLong;
/// size 1 typedef unsigned char  FT_Bool;
typedef FT_Bool = UnsignedChar;
/// size 8 typedef size_t  FT_Offset;
typedef FT_Offset = Size;
// size 1 typedef FT_PtrDist = ptrdiff_t;
typedef FT_String = c_char;
///  size 4 typedef FT_UInt32  FT_Tag;
typedef FT_Tag = FT_UInt32;
/// size 4 typedef int  FT_Error;
typedef FT_Error = Int;
/// size 8 typedef signed long  FT_Fixed;
typedef FT_Fixed = Int64;//Long;
/// size 8 typedef void*  FT_Pointer;
typedef FT_Pointer = Pointer<Void>; // Mutable pointer to void *mut c_void;
/// typedef signed long  FT_Pos;
// TODO check size FT_Pos == Long ?
typedef FT_Pos = Int64;//Long;
/// size 2  typedef signed short  FT_FWord; 
typedef FT_FWord = Short;
/// size 2 typedef unsigned short  FT_UFWord; 
typedef FT_UFWord = UnsignedShort;
/// size 2 typedef signed short  FT_F2Dot14;
typedef FT_F2Dot14 = Short;
/// size 8 typedef signed long  FT_F26Dot6;
typedef FT_F26Dot6 = Int64;//Long;
/// size 4
typedef FT_Encoding = c_uint;
/// size 4
typedef FT_Size_Request_Type = c_uint;

abstract class FT_Size_Request_Type_ {
  static const int FT_SIZE_REQUEST_TYPE_NOMINAL = 0;
  static const int FT_SIZE_REQUEST_TYPE_REAL_DIM = 1;
  static const int FT_SIZE_REQUEST_TYPE_BBOX = 2;
  static const int FT_SIZE_REQUEST_TYPE_CELL = 3;
  static const int FT_SIZE_REQUEST_TYPE_SCALES = 4;
  static const int FT_SIZE_REQUEST_TYPE_MAX = 5;
}

typedef FT_Generic_Finalizer
    = Pointer<NativeFunction<FT_Generic_FinalizerFunction>>;

typedef FT_Generic_FinalizerFunction = Void Function(Pointer<Void> object);
typedef DartFT_Generic_FinalizerFunction = void Function(Pointer<Void> object);



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


/// An opaque handle to an FT_Slot_InternalRec structure, used to model private data of a given FT_GlyphSlot object.
final class FT_Slot_InternalRec extends Opaque {}

final class FT_Face_InternalRec extends Opaque {}

final class FT_StrokerRec extends Opaque {}



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
/// A handle to a given FreeType font driver object. A font driver is a module capable of creating faces from font files.
typedef FT_Driver = Pointer<FT_DriverRec>;
typedef FT_Renderer = Pointer<FT_RendererRec>;
/// size 8
typedef FT_Size_Internal = Pointer<FT_Size_InternalRec>;
///  typedef struct FT_SubGlyphRec_*  FT_SubGlyph;
typedef FT_SubGlyph = Pointer<FT_SubGlyphRec>;
/// size 8 An opaque handle to an FT_Slot_InternalRec structure, used to model private data of a given FT_GlyphSlot object.
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
/// size  4
typedef FT_Glyph_Format = c_uint;
