//mingw-w64-x86_64-freetype-2.13.2-1 
//pacman -S mingw-w64-x86_64-freetype
// pacman -Ss mingw-w64-x86_64-freetype
// pacman -U https://repo.msys2.org/mingw/mingw64/mingw-w64-x86_64-freetype-2.12.1-1-any.pkg.tar.zst
// apt install gcc build-essential
// apt-get install libfreetype6 libfreetype6-dev
// dpkg -s libfreetype6 | grep Version
//Version: 2.12.1+dfsg-5
// apt install pkg-config
// /usr/share -name "*.ttf"
// /usr/share/fonts/truetype/dejavu/DejaVuSans.ttf
// /usr/lib/x86_64-linux-gnu/libfreetype.so.6
// gcc -o example1 example1.c -I/usr/include/freetype2 -L/usr/lib/x86_64-linux-gnu -lfreetype -lm
// ./example1 /usr/share/fonts/truetype/dejavu/DejaVuSans.ttf A
// is 64 bits se result for 02 | od -An -t x1 -j 4 -N 1 example1 
/* example1.c                                                      */
/*                                                                 */
/* This small program shows how to print a rotated string with the */
/* FreeType 2 library.                                             */


#include <stdio.h>
#include <string.h>
#include <math.h>

#include <ft2build.h>
#include FT_FREETYPE_H

#include <freetype/ftglyph.h>
#include <freetype/ftsystem.h>

#define WIDTH   32
#define HEIGHT  24
const int fontSize = 11;
const int startX = 10;
const int startY = 10;

/* origin is the upper left corner */
unsigned char image[HEIGHT][WIDTH];


/* Replace this function with something useful. */

void
draw_bitmap( FT_Bitmap*  bitmap,
             FT_Int      x,
             FT_Int      y)
{
  FT_Int  i, j, p, q;
  FT_Int  x_max = x + bitmap->width;
  FT_Int  y_max = y + bitmap->rows;


  /* for simplicity, we assume that `bitmap->pixel_mode' */
  /* is `FT_PIXEL_MODE_GRAY' (i.e., not a bitmap font)   */

  for ( i = x, p = 0; i < x_max; i++, p++ )
  {
    for ( j = y, q = 0; j < y_max; j++, q++ )
    {
      if ( i < 0      || j < 0       ||
           i >= WIDTH || j >= HEIGHT )
        continue;

      image[j][i] |= bitmap->buffer[q * bitmap->width + p];
    }
  }
}


void
show_image( void )
{
  int  i, j;


  for ( i = 0; i < HEIGHT; i++ )
  {
    for ( j = 0; j < WIDTH; j++ )
      putchar( image[i][j] == 0 ? ' '
                                : image[i][j] < 128 ? '+'
                                                    : '*' );
    putchar( '\n' );
  }
}


int
main( int     argc,
      char**  argv )
{
  FT_Library    library;
  FT_Face       face;

  FT_GlyphSlot  slot;
  FT_Matrix     matrix;                 /* transformation matrix */
  FT_Vector     pen;                    /* untransformed origin  */
  FT_Error      error;

  char*         filename;
  char*         text;

  double        angle;
  int           target_height;
  int           n, num_chars;


  if ( argc != 3 )
  {
    fprintf ( stderr, "usage: %s font sample-text\n", argv[0] );
    exit( 1 );
  }

  filename      = argv[1];                           /* first argument     */
  text          = argv[2];                           /* second argument    */
  num_chars     = strlen( text );
  angle         = ( 0.0 / 360 ) * 3.14159 * 2;      /* use 25 degrees     */
  target_height = HEIGHT;

  error = FT_Init_FreeType( &library );              /* initialize library */
  /* error handling omitted */

  error = FT_New_Face( library, filename, 0, &face );/* create face object */
  /* error handling omitted */

  /* use 50pt at 100dpi  set character size */
  //error = FT_Set_Char_Size( face, fontSize * 64, 0, 100, 0 );  
  error = FT_Set_Char_Size(face, 0, fontSize * 64 + 32, 0, 0);          
  /* error handling omitted */

  /* cmap selection omitted;                                        */
  /* for simplicity we assume that the font contains a Unicode cmap */

  slot = face->glyph;

  /* set up matrix */
  matrix.xx = (FT_Fixed)( cos( angle ) * 0x10000L );
  matrix.xy = (FT_Fixed)(-sin( angle ) * 0x10000L );
  matrix.yx = (FT_Fixed)( sin( angle ) * 0x10000L );
  matrix.yy = (FT_Fixed)( cos( angle ) * 0x10000L );

  /* the pen position in 26.6 cartesian space coordinates; */
  /* start at (300,200) relative to the upper left corner  */
  pen.x = startX * 64;
  pen.y = ( target_height - startY ) * 64;

  for ( n = 0; n < num_chars; n++ )
  {
    /* set transformation */
    FT_Set_Transform( face, &matrix, &pen );

    /* load glyph image into the slot (erase previous one) */
    error = FT_Load_Char( face, text[n], FT_LOAD_RENDER );
    if ( error )
      continue;                 /* ignore errors */

    /* now, draw to our target surface (convert position) */
    draw_bitmap( &slot->bitmap,
                 slot->bitmap_left,
                 target_height - slot->bitmap_top );

    /* increment pen position */
    pen.x += slot->advance.x;
    pen.y += slot->advance.y;
  }

  show_image();

     
  
  FT_Done_Face    ( face );
  FT_Done_FreeType( library );

  printf("after FT_Done_FreeType\r\n");

  return 0;
}

/* EOF */