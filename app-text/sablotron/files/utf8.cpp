/* 
* The contents of this file are subject to the Mozilla Public
* License Version 1.1 (the "License"); you may not use this file
* except in compliance with the License. You may obtain a copy of
* the License at http://www.mozilla.org/MPL/
* 
* Software distributed under the License is distributed on an "AS
* IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
* implied. See the License for the specific language governing
* rights and limitations under the License.
* 
* The Original Code is the Sablotron XSLT Processor.
* 
* The Initial Developer of the Original Code is Ginger Alliance Ltd.
* Portions created by Ginger Alliance are Copyright (C) 2000 Ginger
* Alliance Ltd. All Rights Reserved.
* 
* Contributor(s): Sven Neumann <neo@netzquadrat.de>
* 
* Alternatively, the contents of this file may be used under the
* terms of the GNU General Public License Version 2 or later (the
* "GPL"), in which case the provisions of the GPL are applicable 
* instead of those above.  If you wish to allow use of your 
* version of this file only under the terms of the GPL and not to
* allow others to use your version of this file under the MPL,
* indicate your decision by deleting the provisions above and
* replace them with the notice and other provisions required by
* the GPL.  If you do not delete the provisions above, a recipient
* may use your version of this file under either the MPL or the
* GPL.
*/

//
//      utf8.cpp
//

#include <assert.h>
#include "utf8.h"

#ifdef HAVE_ICONV_H
#include <iconv.h>
#endif

/*  This MUST match the Encoding enum defined in utf8.h  */
static char* iconv_encoding[8] =
{
    "UTF8",
    "UTF16",
    "ASCII",
    "ISO-8859-1",
    "ISO-8859-2",
    "CP1250",
    "EUC-JP",
    "SHIFT-JIS"
};

int utf8SingleCharLength (const char* text)
{
  if (!(*text & 0x80)) return 1;
  if (!(*text & 0x40)) return 0;
  for (int len = 2; len < 7; len++)
      if (!(*text & (0x80 >> len))) return len;
  return 0;
}

// this ought to return the Unicode equivalent of the UTF-8 char
// (for character references like &#22331;)
//
unsigned long utf8CharCode(const char *text)
{
    int i, len = utf8SingleCharLength(text);
    if (!len) return (unsigned long) -1;
    if (len == 1) return *text;
    unsigned long code = (*text & (0xff >> (len + 1)));   // get 1st byte
    for (i = 1; i < len; i++)
        code = (code << 6) | (text[i] & 0x3f);
    return code;
}


int utf8GetChar(char *dest, const char *src)
{
    int len = utf8SingleCharLength (src);
    memcpy (dest, src, len);
    return len;
}

Bool utf8CanRecodeTo(const char *destEncoding)
{
    if (strEqNoCase(destEncoding, "UTF8") || 
        strEqNoCase(destEncoding, "UTF-8"))
        return TRUE;
    // more checks for internally supported encodings can come here
#if defined(HAVE_ICONV_H)
    iconv_t cd = iconv_open (destEncoding, "UTF-8");
    if (cd != (iconv_t)(-1))
    {
        iconv_close (cd);
        return TRUE;
    }
#endif
    return FALSE;
}

int utf8InternalRecode(char *dest, const char *src, Encoding enc)
{
    if (enc == ENC_UTF8)
        return utf8GetChar(dest, src);
    else
        return 0;
}

int utf8Recode(char* dest, const char* src, Encoding enc)
{
    int internal = utf8InternalRecode(dest, src, enc);
    if (internal)
        return internal;
#if !defined(HAVE_ICONV_H)
    return 0;
#else
    iconv_t  cd;
    size_t   inbytesleft  = utf8SingleCharLength (src);
    size_t   outbytesleft = SMALL_BUFFER_SIZE;
    char    *outbuf       = dest;
    
    cd = iconv_open (iconv_encoding[enc], "UTF-8");
    assert(cd != (iconv_t)(-1));
    while (inbytesleft && 
        iconv(cd,(char **) &src, &inbytesleft, &outbuf, &outbytesleft) != -1);
    iconv_close (cd);
    return SMALL_BUFFER_SIZE - outbytesleft;
#endif
}
