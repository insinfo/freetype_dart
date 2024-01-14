// pub struct TT_OS2 {
//     pub version: FT_UShort,
//     pub xAvgCharWidth: FT_Short,
//     pub usWeightClass: FT_UShort,
//     pub usWidthClass: FT_UShort,
//     pub fsType: FT_UShort,
//     pub ySubscriptXSize: FT_Short,
//     pub ySubscriptYSize: FT_Short,
//     pub ySubscriptXOffset: FT_Short,
//     pub ySubscriptYOffset: FT_Short,
//     pub ySuperscriptXSize: FT_Short,
//     pub ySuperscriptYSize: FT_Short,
//     pub ySuperscriptXOffset: FT_Short,
//     pub ySuperscriptYOffset: FT_Short,
//     pub yStrikeoutSize: FT_Short,
//     pub yStrikeoutPosition: FT_Short,
//     pub sFamilyClass: FT_Short,
//     pub panose: [FT_Byte; 10],
//     pub ulUnicodeRange1: FT_ULong, /* Bits 0-31   */
//     pub ulUnicodeRange2: FT_ULong, /* Bits 32-63  */
//     pub ulUnicodeRange3: FT_ULong, /* Bits 64-95  */
//     pub ulUnicodeRange4: FT_ULong, /* Bits 96-127 */
//     pub achVendID: [FT_Char; 4],
//     pub fsSelection: FT_UShort,
//     pub usFirstCharIndex: FT_UShort,
//     pub usLastCharIndex: FT_UShort,
//     pub sTypoAscender: FT_Short,
//     pub sTypoDescender: FT_Short,
//     pub sTypoLineGap: FT_Short,
//     pub usWinAscent: FT_UShort,
//     pub usWinDescent: FT_UShort,
//     /* only version 1 tables */
//     pub ulCodePageRange1: FT_ULong, /* Bits 0-31  */
//     pub ulCodePageRange2: FT_ULong, /* Bits 32-63 */
//     /* only version 2 tables */
//     pub sxHeight: FT_Short,
//     pub sCapHeight: FT_Short,
//     pub usDefaultChar: FT_UShort,
//     pub usBreakChar: FT_UShort,
//     pub usMaxContext: FT_UShort,
// }

import 'dart:ffi';
/// size 100
final class TT_OS2 extends Opaque {}