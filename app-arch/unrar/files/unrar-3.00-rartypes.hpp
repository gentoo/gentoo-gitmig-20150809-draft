#ifndef _RAR_TYPES_
#define _RAR_TYPES_

typedef unsigned char    byte;   //8 bits
typedef unsigned short   ushort; //preferably 16 bits, but can be more
typedef unsigned int     uint;   //32 bits or more

typedef unsigned int     uint32; //32 bits exactly
#define PRESENT_INT32

#ifdef _WIN_32
typedef wchar_t wchar;
#elif defined(__GNUC__)
#if __GNUC__ < 3 || (__GNUC__ == 3 && __GNUC_MINOR__ < 1)
typedef __wchar_t wchar;
#else
typedef wchar_t wchar;
#endif
#else
typedef ushort wchar;
#endif

#define SHORT16(x) (sizeof(ushort)==2 ? (ushort)(x):((x)&0xffff))

#endif