/*
 * recode.c - a character set converter
 * $Id: recode.c,v 1.1 2003/11/22 01:27:02 zul Exp $
 *
 * Copyright (c) 2003 Jean-Yves Lefort
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of Jean-Yves Lefort nor the names of its contributors
 *    may be used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
 * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * requirements:
 *
 *	irssi 0.8.6 (built using --with-glib2)
 *	irssi 0.8.6 sources
 *      GLib 2.0 or superior
 *
 * compile:
 *
 *	export IRSSI=~/src/irssi-0.8.6
 *	gcc -g -shared -DHAVE_CONFIG_H -I$IRSSI -I$IRSSI/src -I$IRSSI/src/core -I$IRSSI/src/fe-common/core `pkg-config --cflags glib-2.0` -o ~/.irssi/modules/librecode.so recode.c
 *
 * usage:
 *
 *	/load recode
 *
 *		Load the converter into irssi.
 *
 *		If the terminal type is UTF-8, text which isn't
 *		encoded in UTF-8 will be converted from
 *		recode_fallback.
 *
 *		If the terminal type isn't UTF-8, valid UTF-8 text
 *		will be converted to the terminal encoding.
 *
 * settings:
 *
 *	recode_fallback
 *
 *		If the terminal type is UTF-8 and a message is not
 *		valid UTF-8, recode will attempt to convert it from
 *		this character set.
 */

#include <glib.h>
#include <string.h>

/* irssi includes */
#include "common.h"
#include "signals.h"
#include "modules.h"
#include "formats.h"
#include "levels.h"
#include "printtext.h"
#include "settings.h"

/*** cpp *********************************************************************/

#define MODULE_NAME			"recode/core"

/*** module formats **********************************************************/

enum {
  RECODE_TXT_MODULE_NAME,

  RECODE_TXT_CONVERSION_ERROR
};

static FORMAT_REC recode_formats[] = {
  { MODULE_NAME, "Character set converter", 0 },
  
  { "recode_conversion_error", "$0 {error (unable to convert from $1 to $2: $3)}", 4, { FORMAT_STRING, FORMAT_STRING, FORMAT_STRING, FORMAT_STRING } },
  
  { NULL, NULL, 0 }
};

/*** functions ***************************************************************/

static void recode_print_text_cb (TEXT_DEST_REC	*dest,
				  char		*text,
				  char		*stripped);

/*** implementation **********************************************************/

void
recode_init (void)
{
  theme_register(recode_formats);

  settings_add_str("misc", "recode_fallback", "ISO8859-15");

  signal_add("print text", (SIGNAL_FUNC) recode_print_text_cb);

  module_register("recode", "core");
}

void
recode_deinit (void)
{
  signal_remove("print text", (SIGNAL_FUNC) recode_print_text_cb);

  settings_remove("recode_fallback");

  theme_unregister();
}

static void
recode_print_text_cb (TEXT_DEST_REC *dest, char *text, char *stripped)
{
  const char *charset;
  const char *from = NULL;
  gboolean utf8;

  charset = settings_get_str("term_type");
  if (*charset)
    /* we use the same test as irssi, so we use the deprecated g_strcasecmp() */
    utf8 = ! g_strcasecmp(charset, "utf-8");
  else
    utf8 = g_get_charset(&charset);

  if (utf8)
    {
      if (! g_utf8_validate(text, -1, NULL))
	from = settings_get_str("recode_fallback");
    }
  else
    {
      if (g_utf8_validate(text, -1, NULL))
	from = "UTF-8";
    }

  if (from)
    {
      GError *err = NULL;
      char *converted;

      converted = g_convert(text,
			    strlen(text),
			    charset,
			    from,
			    NULL,
			    NULL,
			    &err);
      if (! converted)
	{
	  converted = format_get_text(MODULE_NAME,
				      dest->window,
				      dest->server,
				      dest->target,
				      RECODE_TXT_CONVERSION_ERROR,
				      text,
				      from,
				      charset,
				      err->message);
	  g_error_free(err);
	}

      signal_continue(3, dest, converted, stripped);
      g_free(converted);
    }
}
