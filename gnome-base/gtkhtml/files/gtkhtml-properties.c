/* -*- Mode: C; tab-width: 8; indent-tabs-mode: t; c-basic-offset: 8 -*- */
/* This file is part of the GtkHTML library

   Copyright (C) 2000 Helix Code, Inc.
   Authors:           Radek Doulik (rodo@helixcode.com)

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHcANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public License
   along with this library; see the file COPYING.LIB.  If not, write to
   the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.
*/

#include <config.h>
#include "gtkhtml.h"
#include "gtkhtml-properties.h"

GtkHTMLClassProperties *
gtk_html_class_properties_new (void)
{
	GtkHTMLClassProperties *p = g_new (GtkHTMLClassProperties, 1);

	/* default values */
	p->magic_links = TRUE;
	p->keybindings_theme = g_strdup ("emacs");

	return p;
}

void
gtk_html_class_properties_destroy (GtkHTMLClassProperties *p)
{
	g_free (p->keybindings_theme);
	g_free (p);
}

#ifdef GTKHTML_HAVE_GCONF
#define GET(t,x,prop,f,c) \
        key = g_strconcat (GTK_HTML_GCONF_DIR, x, NULL); \
        val = gconf_client_get (client, key, NULL); \
        if (val) { f; p-> ## prop = c gconf_value_get_ ## t (val); \
        gconf_value_free (val); } \
        g_free (key);

void
gtk_html_class_properties_load (GtkHTMLClassProperties *p, GConfClient *client)
{
	GConfValue *val;
	gchar *key;
	gboolean dflt;

	g_assert (client);

	GET (bool, "/magic_links", magic_links,,);
	GET (string, "/keybindings_theme", keybindings_theme,
	     g_free (p->keybindings_theme), g_strdup);
}

#define SET(t,x,prop) \
        { key = g_strconcat (GTK_HTML_GCONF_DIR, x, NULL); \
        gconf_client_set_ ## t (client, key, p-> ## prop, NULL); \
        g_free (key); }


void
gtk_html_class_properties_update (GtkHTMLClassProperties *p, GConfClient *client, GtkHTMLClassProperties *old)
{
	gchar *key;

	if (p->magic_links != old->magic_links)
		SET (bool, "/magic_links", magic_links);
	SET (string, "/keybindings_theme", keybindings_theme);
}

#else
void
gtk_html_class_properties_load (GtkHTMLClassProperties *p)
{
	gnome_config_push_prefix (GTK_HTML_GNOME_CONFIG_PREFIX);
	p->magic_links = gnome_config_get_bool ("magic_links=true");
	p->keybindings_theme = gnome_config_get_string ("keybindings_theme=ms");
	gnome_config_pop_prefix ();
	gnome_config_sync ();
}

void
gtk_html_class_properties_save (GtkHTMLClassProperties *p)
{
	gnome_config_push_prefix (GTK_HTML_GNOME_CONFIG_PREFIX);
	gnome_config_set_bool ("magic_links", p->magic_links);
	gnome_config_set_string ("keybindings_theme", p->keybindings_theme);
	gnome_config_pop_prefix ();
	gnome_config_sync ();
}
#endif

void
gtk_html_class_properties_copy (GtkHTMLClassProperties *p1,
				GtkHTMLClassProperties *p2)
{
	p1->magic_links = p2->magic_links;
	g_free (p1->keybindings_theme);
	p1->keybindings_theme = g_strdup (p2->keybindings_theme);
}

/* enums */

static GtkEnumValue _gtk_html_cursor_skip_values[] = {
  { GTK_HTML_CURSOR_SKIP_ONE,  "GTK_HTML_CURSOR_SKIP_ONE",  "one" },
  { GTK_HTML_CURSOR_SKIP_WORD, "GTK_HTML_CURSOR_SKIP_WORD", "word" },
  { GTK_HTML_CURSOR_SKIP_PAGE, "GTK_HTML_CURSOR_SKIP_WORD", "page" },
  { GTK_HTML_CURSOR_SKIP_ALL,  "GTK_HTML_CURSOR_SKIP_ALL",  "all" },
  { 0, NULL, NULL }
};

GtkType
gtk_html_cursor_skip_get_type ()
{
	static GtkType cursor_skip_type = 0;

	if (!cursor_skip_type)
		cursor_skip_type = gtk_type_register_enum ("GTK_HTML_CURSOR_SKIP", _gtk_html_cursor_skip_values);

	return cursor_skip_type;
}

static GtkEnumValue _gtk_html_command_values[] = {
  { GTK_HTML_COMMAND_UNDO,  "GTK_HTML_COMMAND_UNDO",  "undo" },
  { GTK_HTML_COMMAND_REDO,  "GTK_HTML_COMMAND_REDO",  "redo" },
  { GTK_HTML_COMMAND_COPY,  "GTK_HTML_COMMAND_COPY",  "copy" },
  { GTK_HTML_COMMAND_CUT,   "GTK_HTML_COMMAND_CUT",   "cut" },
  { GTK_HTML_COMMAND_PASTE, "GTK_HTML_COMMAND_PASTE", "paste" },
  { GTK_HTML_COMMAND_CUT_LINE, "GTK_HTML_COMMAND_CUT_LINE", "cut-line" },

  { GTK_HTML_COMMAND_INSERT_PARAGRAPH, "GTK_HTML_COMMAND_INSERT_PARAGRAPH", "insert-paragraph" },
  { GTK_HTML_COMMAND_DELETE, "GTK_HTML_COMMAND_DELETE", "delete" },
  { GTK_HTML_COMMAND_DELETE_BACK, "GTK_HTML_COMMAND_DELETE_BACK", "delete-back" },
  { GTK_HTML_COMMAND_SET_MARK, "GTK_HTML_COMMAND_SET_MARK", "set-mark" },
  { GTK_HTML_COMMAND_DISABLE_SELECTION, "GTK_HTML_COMMAND_DISABLE_SELECTION", "disable-selection" },
  { GTK_HTML_COMMAND_TOGGLE_BOLD, "GTK_HTML_COMMAND_TOGGLE_BOLD", "toggle-bold" },
  { GTK_HTML_COMMAND_TOGGLE_ITALIC, "GTK_HTML_COMMAND_TOGGLE_ITALIC", "toggle-italic" },
  { GTK_HTML_COMMAND_TOGGLE_UNDERLINE, "GTK_HTML_COMMAND_TOGGLE_BOLD", "toggle-underline" },
  { GTK_HTML_COMMAND_TOGGLE_STRIKEOUT, "GTK_HTML_COMMAND_TOGGLE_BOLD", "toggle-strikeout" },
  { GTK_HTML_COMMAND_SIZE_MINUS_2, "GTK_HTML_COMMAND_SIZE_MINUS_2", "size-minus-2" },
  { GTK_HTML_COMMAND_SIZE_MINUS_1, "GTK_HTML_COMMAND_SIZE_MINUS_1", "size-minus-1" },
  { GTK_HTML_COMMAND_SIZE_PLUS_0, "GTK_HTML_COMMAND_SIZE_PLUS_0", "size-plus-0" },
  { GTK_HTML_COMMAND_SIZE_PLUS_1, "GTK_HTML_COMMAND_SIZE_PLUS_1", "size-plus-1" },
  { GTK_HTML_COMMAND_SIZE_PLUS_2, "GTK_HTML_COMMAND_SIZE_PLUS_2", "size-plus-2" },
  { GTK_HTML_COMMAND_SIZE_PLUS_3, "GTK_HTML_COMMAND_SIZE_PLUS_3", "size-plus-3" },
  { GTK_HTML_COMMAND_SIZE_PLUS_4, "GTK_HTML_COMMAND_SIZE_PLUS_4", "size-plus-4" },
  { GTK_HTML_COMMAND_SIZE_INCREASE, "GTK_HTML_COMMAND_SIZE_INCREASE", "size-inc" },
  { GTK_HTML_COMMAND_SIZE_DECREASE, "GTK_HTML_COMMAND_SIZE_DECREASE", "size-dec" },
  { GTK_HTML_COMMAND_ALIGN_LEFT, "GTK_HTML_COMMAND_ALIGN_LEFT", "align-left" },
  { GTK_HTML_COMMAND_ALIGN_CENTER, "GTK_HTML_COMMAND_ALIGN_CENTER", "align-center" },
  { GTK_HTML_COMMAND_ALIGN_RIGHT, "GTK_HTML_COMMAND_ALIGN_RIGHT", "align-right" },
  { GTK_HTML_COMMAND_INDENT_INC, "GTK_HTML_COMMAND_INDENT_INC", "indent-more" },
  { GTK_HTML_COMMAND_INDENT_DEC, "GTK_HTML_COMMAND_INDENT_DEC", "indent-less" },
  { GTK_HTML_COMMAND_PARAGRAPH_STYLE_NORMAL, "GTK_HTML_COMMAND_PARAGRAPH_STYLE_NORMAL", "style-normal" },
  { GTK_HTML_COMMAND_PARAGRAPH_STYLE_H1, "GTK_HTML_COMMAND_PARAGRAPH_STYLE_H1", "style-header1" },
  { GTK_HTML_COMMAND_PARAGRAPH_STYLE_H2, "GTK_HTML_COMMAND_PARAGRAPH_STYLE_H2", "style-header2" },
  { GTK_HTML_COMMAND_PARAGRAPH_STYLE_H3, "GTK_HTML_COMMAND_PARAGRAPH_STYLE_H3", "style-header3" },
  { GTK_HTML_COMMAND_PARAGRAPH_STYLE_H4, "GTK_HTML_COMMAND_PARAGRAPH_STYLE_H4", "style-header4" },
  { GTK_HTML_COMMAND_PARAGRAPH_STYLE_H5, "GTK_HTML_COMMAND_PARAGRAPH_STYLE_H5", "style-header5" },
  { GTK_HTML_COMMAND_PARAGRAPH_STYLE_H6, "GTK_HTML_COMMAND_PARAGRAPH_STYLE_H6", "style-header6" },
  { GTK_HTML_COMMAND_PARAGRAPH_STYLE_ADDRESS, "GTK_HTML_COMMAND_PARAGRAPH_STYLE_ADDRESS", "style-address" },
  { GTK_HTML_COMMAND_PARAGRAPH_STYLE_PRE, "GTK_HTML_COMMAND_PARAGRAPH_STYLE_PRE", "style-pre" },
  { GTK_HTML_COMMAND_PARAGRAPH_STYLE_ITEMDOTTED, "GTK_HTML_COMMAND_PARAGRAPH_STYLE_ITEMDOTTED", "style-itemdot" },
  { GTK_HTML_COMMAND_PARAGRAPH_STYLE_ITEMROMAN, "GTK_HTML_COMMAND_PARAGRAPH_STYLE_ITEMROMAN", "style-itemroman" },
  { GTK_HTML_COMMAND_PARAGRAPH_STYLE_ITEMDIGIT, "GTK_HTML_COMMAND_PARAGRAPH_STYLE_ITEMDIGIT", "style-itemdigit" },
  { GTK_HTML_COMMAND_MODIFY_SELECTION_UP, "GTK_HTML_COMMAND_MODIFY_SELECTION_UP", "selection-move-up" },
  { GTK_HTML_COMMAND_MODIFY_SELECTION_DOWN, "GTK_HTML_COMMAND_MODIFY_SELECTION_DOWN", "selection-move-down" },
  { GTK_HTML_COMMAND_MODIFY_SELECTION_LEFT, "GTK_HTML_COMMAND_MODIFY_SELECTION_LEFT", "selection-move-left" },
  { GTK_HTML_COMMAND_MODIFY_SELECTION_RIGHT, "GTK_HTML_COMMAND_MODIFY_SELECTION_RIGHT", "selection-move-right" },
  { GTK_HTML_COMMAND_MODIFY_SELECTION_BOL, "GTK_HTML_COMMAND_MODIFY_SELECTION_BOL", "selection-move-bol" },
  { GTK_HTML_COMMAND_MODIFY_SELECTION_EOL, "GTK_HTML_COMMAND_MODIFY_SELECTION_EOL", "selection-move-eol" },
  { GTK_HTML_COMMAND_MODIFY_SELECTION_BOD, "GTK_HTML_COMMAND_MODIFY_SELECTION_BOD", "selection-move-bod" },
  { GTK_HTML_COMMAND_MODIFY_SELECTION_EOD, "GTK_HTML_COMMAND_MODIFY_SELECTION_EOD", "selection-move-eod" },
  { GTK_HTML_COMMAND_MODIFY_SELECTION_PAGEUP, "GTK_HTML_COMMAND_MODIFY_SELECTION_PAGEUP", "selection-move-pageup" },
  { GTK_HTML_COMMAND_MODIFY_SELECTION_PAGEDOWN, "GTK_HTML_COMMAND_MODIFY_SELECTION_PAGEDOWN", "selection-move-pagedown" },
  { GTK_HTML_COMMAND_CAPITALIZE_WORD, "GTK_HTML_COMMAND_CAPITALIZE_WORD", "capitalize-word" },
  { GTK_HTML_COMMAND_UPCASE_WORD, "GTK_HTML_COMMAND_UPCASE_WORD", "upcase-word" },
  { GTK_HTML_COMMAND_DOWNCASE_WORD, "GTK_HTML_COMMAND_DOWNCASE_WORD", "downcase-word" },
#ifdef GTKHTML_HAVE_PSPELL

  { GTK_HTML_COMMAND_SPELL_SUGGEST, "GTK_HTML_COMMAND_SPELL_SUGGEST", "spell-suggest" },
  { GTK_HTML_COMMAND_SPELL_PERSONAL_DICTIONARY_ADD, "GTK_HTML_COMMAND_SPELL_PERSONAL_DICTIONARY_ADD", "spell-personal-add" },
  { GTK_HTML_COMMAND_SPELL_SESSION_DICTIONARY_ADD, "GTK_HTML_COMMAND_SPELL_SESSION_DICTIONARY_ADD", "spell-session-add" },
#endif
  { 0, NULL, NULL }
};

GtkType
gtk_html_command_get_type ()
{
	static GtkType command_type = 0;

	if (!command_type)
		command_type = gtk_type_register_enum ("GTK_HTML_COMMAND", _gtk_html_command_values);

	return command_type;
}
