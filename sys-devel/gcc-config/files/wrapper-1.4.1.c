/*
 * Copyright 1999-2003 Gentoo Technologies, Inc.
 * Distributed under the terms of the GNU General Public License v2
 * Author: Martin Schlemmer <azarah@gentoo.org>
 * $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-config/files/wrapper-1.4.1.c,v 1.2 2003/04/12 21:19:26 azarah Exp $
 */

#define _REENTRANT
#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/param.h>
#include <unistd.h>
#include <wait.h>
#include <libgen.h>
#include <string.h>
#include <stdarg.h>
#include <errno.h>

#define GCC_CONFIG	"/usr/bin/gcc-config"

#ifndef CC_PROFILE
# define ENVD_FILE	"/etc/env.d/05gcc"
#else
# define ENVD_FILE	"/etc/env.d/gcc/" CC_PROFILE
#endif

struct wrapper_data {
	char name[MAXPATHLEN + 1];
	char fullname[MAXPATHLEN + 1];
	char bin[MAXPATHLEN + 1];
	char tmp[MAXPATHLEN + 1];
	
	char *path;
};

static const char *wrapper_strerror(int err, struct wrapper_data *data)
{
	strerror_r(err, data->tmp, sizeof(data->tmp));
	return data->tmp;
}

static void wrapper_exit(char *msg, ...)
{   
	va_list args;
	va_start(args, msg);
	vfprintf(stderr, msg, args);
	va_end(args);
	exit(1);
}

/* check_for_target checks in path for the file we are seeking 
 * it returns 1 if found (with data->bin setup), 0 if not and
 * negative on error
 */
static int check_for_target(char *path, struct wrapper_data *data) 
{
	struct stat sbuf;
	int result = 0;
	char *str = data->tmp;
	size_t len = strlen(path) + strlen(data->name) + 2;

	snprintf(str, len, "%s/%s", path, data->name);

	/* Stat possible file to check that
	 * 1) it exist and is a regular file, and
	 * 2) it is not the wrapper itself, and
	 * 3) it is in a /gcc-bin/ directory tree
	 */
	result = stat(str, &sbuf);
	if ((0 == result) && (sbuf.st_mode & S_IFREG) && 
	    (0 != strcmp(str, data->fullname)) && 
	    (0 != strstr(str, "/gcc-bin/"))) {
		
		strncpy(data->bin, str, MAXPATHLEN);
		data->bin[MAXPATHLEN] = 0;
		result = 1;
	}
	else
		result = 0;
		
	return result;
}

static int find_target_in_path(struct wrapper_data *data)
{
	char *token = NULL, *str = data->tmp, *state;
	
	if (NULL == data->path) return 0;

	/* Make a copy since strtok_r will modify path */
	snprintf(str, MAXPATHLEN + 1, "%s", data->path);
	
	token = strtok_r(str, ":", &state);

	/* Find the first file with suitable name in PATH.  The idea here is
	 * that we do not want to bind ourselfs to something static like the
	 * default profile, or some odd environment variable, but want to be
	 * able to build something with a non default gcc by just tweaking
	 * the PATH ... */
	while ((NULL != token) && (strlen(token) > 0)) {
		
		if (check_for_target(token, data))
			return 1;
		
		token = strtok_r(NULL, ":", &state);
	}
	
	return 0;
}

/* find_target_in_envd parses /etc/env.d/05gcc, and tries to
 * extract PATH, which is set to the current profile's bin
 * directory ...
 */
static int find_target_in_envd(struct wrapper_data *data)
{
	FILE *envfile = NULL;
	char *token = NULL, *str = data->tmp, *state;

	if (NULL == data->path) return 0;

	envfile = fopen(ENVD_FILE, "r");
	if (NULL == envfile)
		return 0;

	while (0 != fgets(str, MAXPATHLEN, envfile)) {
		
		/* Keep reading ENVD_FILE until we get a line that
		 * starts with 'PATH='
		 */
		if (((str) && (strlen(str) > strlen("PATH=")) &&
			0 == strncmp("PATH=", str, strlen("PATH=")))) {
			
			token = strtok_r(str, "=", &state);
			if ((NULL != token) && (strlen(token) > 0))
				/* The second token should be the value of PATH .. */
				token = strtok_r(NULL, "=", &state);
			else {
				fclose(envfile);
				return 0;
			}
			
			if ((NULL != token) && (strlen(token) > 0)) {
				
				str = token;
				/* A bash variable may be unquoted, quoted with " or
				 * quoted with ', so extract the value without those ..
				 */
				token = strsep(&str, "\n\"\'");

				while (NULL != token) {
					
					if (check_for_target(token, data)) {

						fclose(envfile);
						return 1;
					}

					token = strsep(&str, "\n\"\'");
				}
			}
			
		}
		str = data->tmp;
	}

	fclose(envfile);

	return 0;
}

static void find_wrapper_target(struct wrapper_data *data) 
{
	FILE *inpipe = NULL;
	char *str = data->tmp;

#ifndef CC_PROFILE
	if (find_target_in_path(data))
		return;
#endif

	if (find_target_in_envd(data))
		return;

	/* Only our wrapper is in PATH, so 
	   get the CC path using gcc-config and 
	   execute the real binary in there... */
#ifndef CC_PROFILE
	inpipe = popen(GCC_CONFIG " --get-bin-path", "r");
#else
	inpipe = popen(GCC_CONFIG " --get-bin-path " CC_PROFILE, "r");
#endif
	if (NULL == inpipe)
		wrapper_exit(
			"Could not open pipe for gcc-config: %s\n",
			wrapper_strerror(errno, data));

	if (0 == fgets(str, MAXPATHLEN, inpipe))
		wrapper_exit(
			"Could not get compiler binary path: %s\n",
			wrapper_strerror(errno, data));

	strncpy(data->bin, str, sizeof(data->bin) - 1);
	data->bin[strlen(data->bin) - 1] = '/';
	strncat(data->bin, data->name, sizeof(data->bin) - 1);
	data->bin[MAXPATHLEN] = 0;

	pclose(inpipe);
}

/* This function modifies PATH to have gcc's bin path appended */
static void modify_path(struct wrapper_data *data)
{
	char *newpath = NULL, *token = NULL, *state;
	char dname_data[MAXPATHLEN + 1];
	char *str = data->tmp, *str2 = dname_data, *dname = dname_data;
	size_t len = 0;

	if (NULL == data->bin)
		return;

	snprintf(str2, MAXPATHLEN + 1, "%s", data->bin);

	if (NULL == (dname = dirname(str2)))
		return;

	if (NULL == data->path)
		return;

	/* Make a copy since strtok_r will modify path */
	snprintf(str, MAXPATHLEN + 1, "%s", data->path);

	token = strtok_r(str, ":", &state);

	/* Check if we already appended our bin location to PATH */
	if ((NULL != token) && (strlen(token) > 0)) {
		if (0 == strcmp(token, dname))
			return;
	}

	len = strlen(dname) + strlen(data->path) + 2;

	newpath = (char *)malloc(len);
	if (NULL == newpath)
		wrapper_exit("wrapper: out of memory\n");
	memset(newpath, 0, len);

	snprintf(newpath, len, "%s:%s", dname, data->path);
	setenv("PATH", newpath, 1);

	if (newpath)
		free(newpath);
	newpath = NULL;
}

int main(int argc, char **argv) 
{
	struct wrapper_data *data;
	size_t size;
	char *path;
	int result = 0;

	data = alloca(sizeof(*data));
	if (NULL == data) 
		wrapper_exit("%s wrapper: out of memory\n", argv[0]);
	memset(data, 0, sizeof(*data));

	path = getenv("PATH");
	if (NULL != path) {
		data->path = strdup(getenv("PATH"));
		if (NULL == data->path) 
			wrapper_exit("%s wrapper: out of memory\n", argv[0]);
	}
		
	/* What should we find ? */
	strcpy(data->name, basename(argv[0]));

	/* cc calls "/full/path/to/gcc" ... */
	if (0 == strcmp(data->name, "cc"))
		strcpy(data->name, "gcc");

	/* What is the full name of our wrapper? */
	size = sizeof(data->fullname);
	result = snprintf(data->fullname, size, "/usr/bin/%s", data->name);
	if ((-1 == result) || (result > size))
		wrapper_exit("invalid wrapper name: \"%s\"\n", data->name);

	find_wrapper_target(data);

	modify_path(data);

	if (data->path)
		free(data->path);
	data->path = NULL;

	/* Set argv[0] to the correct binary, else gcc do not find internal
	 * headers, etc (bug #8132). */
	argv[0] = data->bin;

	/* Ok, do it ... */
	if (execv(data->bin, argv) < 0)
		wrapper_exit("Could not run/locate \"%s\"\n", data->name);
	
	return 0;
}

