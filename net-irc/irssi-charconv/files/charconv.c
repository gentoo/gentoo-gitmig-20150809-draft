/*
   charconv plugin for irssi
   $Revision: 1.1 $
   
   Copyright (C) 2003 Martin Norbäck <martin@norpan.org>

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

/* Please note that this is very unstable code right now
   COMPILATION:
   IRSSI=/path/to/irssi/source/tree
   gcc charconv.c -Wall -g -o libcharconv.so -shared \
     -I$IRSSI/src -I$IRSSI/src/core -I$IRSSI/src/fe-common/core \
     `glib-config --cflags`

   INSTALLATION:
   cp libcharconv.so ~/.irssi/modules/

   SIMPLE USAGE (UTF-8 terminal)
   /load charconv
   /set charconv_terminal_charset UTF-8
   /set term_type UTF-8
   /charconv add * * * ISO-8859-1

   If you have an ISO-8859-1 terminal, set charconv_terminal_charset 
   to ISO-8859-1 and term_type to 8bit.

   If you want to send messages in UTF-8, do
   /charconv add * * * UTF-8

   If <channel> on <network> mandates UTF-8, do
   /charconv add * <channel> <network> UTF-8

   If <nick> on <network> uses ISO-8859-15, do
   /charconv add <nick> * <network> ISO-8859-15

   If you don't want to specify the network, just use *.

   MORE CONFIGURATION

   TRANSLITERAION:
   charconv_transliterate (default TRUE)

   FALLBACK
   charconv_fallback (default "CP1252")
*/

#define MODULE_NAME "charconv"

#include <stdio.h>
#include <glib.h>
#include <string.h>

/* This is needed because of common.h */
#define UOFF_T_LONG_LONG 1
#include <common.h>
#include <misc.h>
#include <signals.h>
#include <modules.h>
#include <settings.h>
#include <channels.h>
#include <queries.h>
#include <window-item-def.h>
#include <fe-exec.h>
#include <commands.h>
#include <levels.h>
#include <printtext.h>
#include <servers.h>
/* #include <masks.h> */
#include <iconv.h>

/* The table containing the settings
   The key is a string "name channel server" where 
   name, channel and server can be "*"
   The value is the encoding to use.
   When wildcards are used, names are matched before channels, 
   which are matched before servers, so
   name * *
   * channel *
   * * server
   will all match "name channel server", but the first one will be used.
*/
static GHashTable *charconv_settings = NULL;

static char *
normalize_name(const char *name)
{
	int i;
	char *result = g_strdup(name);
	for(i = 0; name[i] != '\0'; i++) {
		result[i] = tolower(name[i]);
		if(name[i] == ']') result[i] = '}';
		if(name[i] == '[') result[i] = '{';
		if(name[i] == '\\') result[i] = '|';
	}
	result[i] = '\0';

	return result;
}

static gboolean
remove_pair(char *key, char *value)
{
	g_free(key);
	g_free(value);

	return TRUE;
}

static void
clear_settings(void)
{
	if(charconv_settings != NULL) {
		g_hash_table_foreach_remove(charconv_settings, 
				            (GHRFunc) remove_pair, NULL);
		g_hash_table_destroy(charconv_settings);
		charconv_settings = NULL;
	}
}

static char *
settings_file_name(void)
{
	return g_strdup_printf("%s/charconv", get_irssi_dir());
}

static char *
make_key(const char *nick, const char *channel, const char *network)
{
	char *_nick     = normalize_name(nick);
	char *_channel  = normalize_name(channel);
	char *_network  = normalize_name(network);
	char *key = g_strdup_printf("%s %s %s", _nick, _channel, _network);

	g_free(_nick);
	g_free(_channel);
	g_free(_network);

	return key;
}

static void
remove_setting(const char *nick, const char *channel, const char *network)
{
	char *key;
	gpointer orig_key, value;
	gboolean found;

	key = make_key(nick, channel, network);
	found = g_hash_table_lookup_extended(charconv_settings, key, 
                                             &orig_key, &value);
	g_hash_table_remove(charconv_settings, key);
	if(found) {
		g_free(orig_key);
		g_free(value);
	} else {
		printtext(NULL, NULL, MSGLEVEL_CLIENTNOTICE,
			    "No rule found to delete");
	}

	g_free(key);
}

static void
add_setting(const char *nick, const char *channel,
            const char *network, const char *encoding)
{
	char *key;

	key = make_key(nick, channel, network);
	g_hash_table_insert(charconv_settings, key, g_strdup(encoding));
	/* key should not be freed here, it's stored in the hash table */
}

static void 
load_settings(void)
{
	char *filename;
	FILE *file;
	int linenum;
	char line[1024];
	char **fields;

	clear_settings();

	/* Initialize hash table */
	charconv_settings = g_hash_table_new(g_str_hash, g_str_equal);

	/* Open file */
	filename = settings_file_name();
	file = fopen(filename, "r");
	if(file == NULL) {
		printtext(NULL, NULL, MSGLEVEL_CLIENTNOTICE,
			    "Couldn't open charconv settings from file \"%s\": %s",
                            filename, strerror(errno));
		return;
	}

	linenum = 0;
	while(fgets(line, sizeof(line), file)) {
		linenum++;

		/* remove \n */
		int len = strlen(line);
		if (line[len-1] == '\n') line[len-1] = '\0';

		/* split the line */
		fields = g_strsplit(line, " ", 4);
		if (strarray_length(fields) != 4) {
			printtext(NULL, NULL, MSGLEVEL_CLIENTNOTICE,
				"Couldn't parse file \"%s\" line %d",
				filename, linenum);
		} else {
			/* nick, channel, network, encoding */
			add_setting(fields[0], fields[1], fields[2], fields[3]);
		}
		g_strfreev(fields);
	}

	fclose(file);
	g_free(filename);
}

static void
write_setting(const char* key, const char* value, FILE *file)
{
	fprintf(file, "%s %s\n", key, value);
}

static void
save_settings(void)
{
	char *filename;
	FILE *file;

	filename = settings_file_name();
	file = fopen(filename, "w");
	if(file == NULL) {
		printtext(NULL, NULL, MSGLEVEL_CLIENTERROR,
			    "Couldn't save charconv settings to file \"%s\": %s",
                            filename, strerror(errno));
		return;
	}
	if(charconv_settings != NULL) {
		g_hash_table_foreach(charconv_settings,
                       	             (GHFunc) write_setting,
				     file);
	}
	fclose(file);
	g_free(filename);
}

/* Lookup nick, channel, network in table */
static const char *
lookup_encoding(const char *nick, const char *channel, const SERVER_REC *server)
{
	const char *network = server->tag;

	char *key;
	char *result = NULL;
	/* There are eight alternatives.
	   Simple algorithm, just look them up in order */

	if(nick && channel && network) {
		key = make_key(nick, channel, network);
		result = g_hash_table_lookup(charconv_settings, key);
		g_free(key);
	}
	if(!result && nick && channel) {
		key = make_key(nick, channel, "*");
		result = g_hash_table_lookup(charconv_settings, key);
		g_free(key);
	}
	if(!result && nick && network) {
		key = make_key(nick, "*", network);
		result = g_hash_table_lookup(charconv_settings, key);
		g_free(key);
	}
	if(!result && nick) {
		key = make_key(nick, "*", "*");
		result = g_hash_table_lookup(charconv_settings, key);
		g_free(key);
	}
	if(!result && channel && network) {
		key = make_key("*", channel, network);
		result = g_hash_table_lookup(charconv_settings, key);
		g_free(key);
	}
	if(!result && channel) {
		key = make_key("*", channel, "*");
		result = g_hash_table_lookup(charconv_settings, key);
		g_free(key);
	}
	if(!result && network) {
		key = make_key("*", "*", network);
		result = g_hash_table_lookup(charconv_settings, key);
		g_free(key);
	}
	if(!result) {
		key = make_key("*", "*", "*");
		result = g_hash_table_lookup(charconv_settings, key);
		g_free(key);
	}
	if(!result) {
		result = "UTF-8";
	}
	
	return result;
}

/* Will return NULL if conversion failed */
static char *
charconv_convert(const char *fromcode, const char *tocode, const char *msg)
{
	iconv_t cd;
	char *orig_msg, *orig_msg_ptr, *new_msg, *new_msg_ptr;
	char *tocode_translit;
	int inbytesleft, outbytesleft;

	/* If empty message, yes this can happen, return */
	if(strlen(msg) == 0) return g_strdup(msg);

	if(settings_get_bool("charconv_transliterate"))
		tocode_translit = g_strdup_printf("%s//TRANSLIT", tocode);
	else
		tocode_translit = g_strdup(tocode);

	cd = iconv_open(tocode_translit, fromcode);
	g_free(tocode_translit);

	if(cd == (iconv_t)(-1)) {
		printtext(NULL, NULL, MSGLEVEL_CLIENTNOTICE,
		          "Cannot convert from %s to %s: %s",
			  fromcode, tocode, strerror(errno));
		return NULL;
	}
	/* This is just a lot of pointers because of iconv's silly interface */
	orig_msg = g_strdup(msg);
	orig_msg_ptr = orig_msg;
	inbytesleft = strlen(orig_msg);
	outbytesleft = 4*inbytesleft;
	new_msg = g_malloc(outbytesleft);
	new_msg_ptr = new_msg;
	iconv(cd, &orig_msg_ptr, &inbytesleft, &new_msg_ptr, &outbytesleft);
	*new_msg_ptr = '\0';
	g_free(orig_msg);
	if(inbytesleft != 0) {
		g_free(new_msg);
		return NULL;
	}

	if(settings_get_bool("charconv_debug")) {
        	char *result = g_strdup_printf("[%s] %s", tocode, new_msg);
		g_free(new_msg);
		return(result);
	}

	iconv_close(cd);
	return new_msg;
}

/* Recode a received message from nick/channel */
static char *
charconv_receive(const char *msg, const char *nick, 
               const char *channel, const SERVER_REC *server)
{
	const char *tocode = settings_get_str("charconv_terminal_charset");
	const char *fromcode = lookup_encoding(nick,channel,server);
	/* First try converting from UTF-8 */
	const char *fromcode_default = "UTF-8";
	char *result = charconv_convert(fromcode_default, tocode, msg);
	if (result == NULL) {
		/* Then try the charset from user settings */
		if (g_strcasecmp(fromcode_default, fromcode) != 0) {
			result = charconv_convert(fromcode, tocode, msg);
		}
	}
        if (result == NULL) {
		const char *fallback = 
			settings_get_str("charconv_fallback");
		/* Fall back
		   FIXME: Stupid re-strcmp (we already compared fromcode_default
		          and fromcode). */
		if (g_strcasecmp(fromcode_default, fallback) != 0 &&
			g_strcasecmp(fromcode, fallback) != 0) {
			result = charconv_convert(fallback, tocode, msg);
		}
	}
	if (result == NULL) {
		/* conversion failed */
		printtext(NULL, NULL, MSGLEVEL_CLIENTNOTICE,
		          "Character conversion failed: %s",
			  strerror(errno));
		return g_strdup(msg);
	}
	return result;
}

/* Recode a sent message from nick/channel */
static char *
charconv_send(const char *msg, const char *nick, 
            const char *channel, const SERVER_REC *server)
{
	const char *tocode = lookup_encoding(nick,channel,server);
	const char *fromcode = settings_get_str("charconv_terminal_charset");
	char *result = charconv_convert(fromcode, tocode, msg);
	if (result == NULL) {
		/* Conversion failed, should we fallback even when sending?
		   No! Let the receiver worry about that. */
		return g_strdup(msg);
	}
	return result;
}

static void
message_public(const SERVER_REC *server,
	       const char *msg,
	       const char *nick,
	       const char *addr,
	       const char *target)
{
	char *new_msg;
	new_msg = charconv_receive(msg, nick, target, server);
	signal_continue(5, server, new_msg, nick, addr, target);
	g_free(new_msg);
}

static void
message_private(const SERVER_REC *server,
	        const char *msg,
	        const char *nick,
	        const char *addr)
{
	char *new_msg;
	new_msg = charconv_receive(msg, nick, NULL, server);
	signal_continue(4, server, new_msg, nick, addr);
	g_free(new_msg);
}

static void
message_own_public(const SERVER_REC *server,
	           const char *msg,
	           const char *target)
{
	char *new_msg;
	new_msg = charconv_receive(msg, NULL, target, server);
	signal_continue(3, server, new_msg, target);
	g_free(new_msg);
}

static void
message_own_private(const SERVER_REC *server,
	            const char *msg,
	            const char *target,
		    const char *orig_target)
{
	char *new_msg;
	new_msg = charconv_receive(msg, target, NULL, server);
	signal_continue(3, server, new_msg, target);
	g_free(new_msg);
}

static void
message_part(const SERVER_REC *server,
	     const char *channel,
	     const char *nick,
             const char *address,
             const char *reason)
{
	char *new_reason;
	new_reason = charconv_receive(reason, nick, channel, server);
	signal_continue(5, server, channel, nick, address, new_reason);
	g_free(new_reason);
}

static void
message_quit(const SERVER_REC *server,
	     const char *nick,
             const char *address,
             const char *reason)
{
	char *new_reason;
	new_reason = charconv_receive(reason, nick, NULL, server);
	signal_continue(4, server, nick, address, new_reason);
	g_free(new_reason);
}


static void
message_kick(const SERVER_REC *server,
	     const char *channel,
	     const char *nick,
	     const char *kicker,
             const char *address,
             const char *reason)
{
	char *new_reason;
	new_reason = charconv_receive(reason, kicker, channel, server);
	signal_continue(6, server, channel, nick, kicker, address, new_reason);
	g_free(new_reason);
}


static void
message_topic(const SERVER_REC *server,
	      const char *channel,
	      const char *topic,
	      const char *nick,
	      const char *address)
{
	char *new_topic;
	new_topic = charconv_receive(topic, nick, channel, server);
	signal_continue(5, server, channel, new_topic, nick, address);
	g_free(new_topic);
}

static void
message_irc_own_action(const SERVER_REC *server,
		       const char *msg,
		       const char *channel)
{
	char *new_msg;
	new_msg = charconv_receive(msg, NULL, channel, server);
	signal_continue(3, server, new_msg, channel);
	g_free(new_msg);
}

static void
message_irc_action(const SERVER_REC *server,
	           const char *msg,
		   const char *nick,
		   const char *addr,
		   const char *target)
{
	char *new_msg;
	new_msg = charconv_receive(msg, nick, target, server);
	signal_continue(5, server, new_msg, nick, addr, target);
	g_free(new_msg);
}

static void
message_irc_own_notice(const SERVER_REC *server,
	               const char *msg,
	               const char *channel)
{
	char *new_msg;
	new_msg = charconv_receive(msg, NULL, channel, server);
	signal_continue(3, server, new_msg, channel);
	g_free(new_msg);
}

static void
add_option(const char *key, const char *value, GString *buffer)
{
	gchar *option_string;

	option_string = g_strdup_printf("-%s %s ", key, value);
	g_string_append(buffer, option_string);
	g_free(option_string);
}

static GString *
optlist_to_string(GHashTable *optlist)
{
	GString *buffer = g_string_new("");
	g_hash_table_foreach(optlist, (GHFunc) add_option, buffer);
	return buffer;
}


static void
command_msg(const char *args,
	    const SERVER_REC *server,
            const void *windowitem)
{
	GHashTable *optlist;
	char *target, *msg, *new_msg, *new_args;
	GString *new_opts;
	void *free_arg;
        int is_channel = 0;

        /* Get message parameters */
        if(!cmd_get_params(args, 
                           &free_arg, 
                           2 | 
                           PARAM_FLAG_OPTIONS | 
			   PARAM_FLAG_UNKNOWN_OPTIONS | 
			   PARAM_FLAG_GETREST, 
			   "msg", &optlist, &target, &msg))
		return;
        if (g_hash_table_lookup(optlist, "channel") != NULL) {
		is_channel = 1;
	}
        new_msg = charconv_send(msg, 
                              is_channel ? NULL : target, 
                              is_channel ? target : NULL,
			      server);
        new_opts = optlist_to_string(optlist);
  	new_args = g_strdup_printf("%s %s %s", new_opts->str, target, new_msg);
	signal_continue(3, new_args, server, windowitem);

	cmd_params_free(free_arg);
	g_free(new_msg);
	g_free(new_args);
}

static void
command_charconv(const char *data, void *server, void *item)
{
	command_runsub("charconv", data, server, item);
}

static void
command_charconv_add(const char *data,
	           const void *server,
	           const void *windowitem)
{
	void *free_arg;
	char *nick, *channel, *network, *encoding;

        cmd_get_params(data, &free_arg, 4, &nick, &channel, &network, &encoding);
	if(*nick == '\0' || *channel == '\0' || 
           *network == '\0' || *encoding == '\0') {
		cmd_return_error(CMDERR_NOT_ENOUGH_PARAMS);
	}
	
	add_setting(nick, channel, network, encoding);
		
	cmd_params_free(free_arg);
}

static void
print_setting(const char* key, const char* value)
{
	printtext(NULL, NULL, MSGLEVEL_CLIENTCRAP, "%s %s", key, value);
}

static void
command_charconv_list(const char *data,
		    const void *server,
		    const void *windowItem)
{
	if(charconv_settings != NULL) {
		g_hash_table_foreach(charconv_settings, 
                                     (GHFunc) print_setting, NULL);
	}
}

static void
command_charconv_remove(const char *data,
		      const void *server,
		      const void *windowItem)
{
	void *free_arg;
	char *nick, *channel, *network;

        cmd_get_params(data, &free_arg, 3, &nick, &channel, &network);
	if(*nick == '\0' || *channel == '\0' || *network == '\0') {
		cmd_return_error(CMDERR_NOT_ENOUGH_PARAMS);
	}
	
	remove_setting(nick, channel, network);
		
	cmd_params_free(free_arg);
}

void 
charconv_init(void)
{
	/* Handle incoming messages */
        signal_add("message public",      (SIGNAL_FUNC) message_public);
        signal_add("message private",     (SIGNAL_FUNC) message_private);
	signal_add("message own_public",  (SIGNAL_FUNC) message_own_public);
	signal_add("message own_private", (SIGNAL_FUNC) message_own_private);
	signal_add("message part",        (SIGNAL_FUNC) message_part);
	signal_add("message quit",        (SIGNAL_FUNC) message_quit);
	signal_add("message kick",        (SIGNAL_FUNC) message_kick);
	signal_add("message topic",       (SIGNAL_FUNC) message_topic);
	/* signal_add("message irc op_public", (SIGNAL_FUNC) message_irc_op_public); */
	/* signal_add("message irc own_wall", (SIGNAL_FUNC) message_irc_own_wall); */
	signal_add("message irc own_action", (SIGNAL_FUNC) message_irc_own_action);
	signal_add("message irc action", (SIGNAL_FUNC) message_irc_action);
	signal_add("message irc own_notice", (SIGNAL_FUNC) message_irc_own_notice);
	/* signal_add("message irc notice", (SIGNAL_FUNC) message_irc_notice); */
	/* signal_add("message irc own_ctcp", (SIGNAL_FUNC) message_irc_own_ctcp); */
	/* signal_add("message irc ctcp", (SIGNAL_FUNC) message_irc_ctcp); */

	/* Handle outgoing messages */
	signal_add("command msg", (SIGNAL_FUNC) command_msg);

	/* Save/load settings when user saves/reload */
	signal_add("setup saved", (SIGNAL_FUNC) save_settings);
	signal_add("setup reread", (SIGNAL_FUNC) load_settings);

	command_bind("charconv", NULL, (SIGNAL_FUNC) command_charconv);
	command_bind("charconv add", NULL, (SIGNAL_FUNC) command_charconv_add);
	command_bind("charconv list", NULL, (SIGNAL_FUNC) command_charconv_list);
	command_bind("charconv remove", NULL, (SIGNAL_FUNC) command_charconv_remove);
	settings_add_bool("charconv", "charconv_debug", FALSE);
	settings_add_str("charconv", "charconv_terminal_charset", "UTF-8");
	settings_add_bool("charconv", "charconv_transliterate", TRUE);
	settings_add_str("charconv", "charconv_fallback", "CP1252");

	load_settings();

	module_register("charconv", "core");
}

void charconv_deinit(void)
{
        signal_remove("message public",      (SIGNAL_FUNC) message_public);
        signal_remove("message private",     (SIGNAL_FUNC) message_private);
	signal_remove("message own_public",  (SIGNAL_FUNC) message_own_public);
	signal_remove("message own_private", (SIGNAL_FUNC) message_own_private);
	signal_remove("message part",        (SIGNAL_FUNC) message_part);
	signal_remove("message quit",        (SIGNAL_FUNC) message_quit);
	signal_remove("message kick",        (SIGNAL_FUNC) message_kick);
	signal_remove("message topic",       (SIGNAL_FUNC) message_topic);
	signal_remove("message irc own_action", (SIGNAL_FUNC) message_irc_own_action);
	signal_remove("message irc action", (SIGNAL_FUNC) message_irc_action);
	signal_remove("message irc own_notice", (SIGNAL_FUNC) message_irc_own_notice);

	signal_remove("command msg",         (SIGNAL_FUNC) command_msg);

	signal_remove("setup saved",         (SIGNAL_FUNC) save_settings);
	signal_remove("setup reread",        (SIGNAL_FUNC) load_settings);

	command_unbind("charconv",             (SIGNAL_FUNC) command_charconv);
	command_unbind("charconv add",         (SIGNAL_FUNC) command_charconv_add);
	command_unbind("charconv list",        (SIGNAL_FUNC) command_charconv_list);
	command_unbind("charconv remove",      (SIGNAL_FUNC) command_charconv_remove);

	save_settings();
	clear_settings();
}
