/*
 * Copyright 1999-2005 Gentoo Foundation
 * Distributed under the terms of the GNU General Public License v2
 * $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-config/files/wrapper-1.4.6.c,v 1.4 2005/07/23 05:05:52 vapier Exp $
 * Author: Martin Schlemmer <azarah@gentoo.org>
 * az's lackey: Mike Frysinger <vapier@gentoo.org>
 */

#define _REENTRANT
#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/param.h>
#include <unistd.h>
#include <sys/wait.h>
#include <libgen.h>
#include <string.h>
#include <stdarg.h>
#include <errno.h>

#define GCC_CONFIG "/usr/bin/gcc-config"
#define ENVD_BASE  "/etc/env.d/05gcc"

struct wrapper_data {
	char name[MAXPATHLEN + 1];
	char fullname[MAXPATHLEN + 1];
	char bin[MAXPATHLEN + 1];
	char tmp[MAXPATHLEN + 1];
	char *path;
};

static const char *wrapper_strerror(int err, struct wrapper_data *data)
{
	/* this app doesn't use threads and strerror
	 * is more portable than strerror_r */
	strncpy(data->tmp, strerror(err), sizeof(data->tmp));
	return data->tmp;
}

static void wrapper_exit(char *msg, ...)
{
	va_list args;
	fprintf(stderr, "gcc-config error: ");
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
	char str[MAXPATHLEN + 1];
	size_t len = strlen(path) + strlen(data->name) + 2;

	snprintf(str, len, "%s/%s", path, data->name);

	/* Stat possible file to check that
	 * 1) it exist and is a regular file, and
	 * 2) it is not the wrapper itself, and
	 * 3) it is in a /gcc-bin/ directory tree
	 */
	result = stat(str, &sbuf);
	if ((result == 0) && \
	    ((sbuf.st_mode & S_IFREG) || (sbuf.st_mode & S_IFLNK)) && \
	    (strcmp(str, data->fullname) != 0) && \
	    (strstr(str, "/gcc-bin/") != 0)) {

		strncpy(data->bin, str, MAXPATHLEN);
		data->bin[MAXPATHLEN] = 0;
		result = 1;
	} else
		result = 0;

	return result;
}

static int find_target_in_path(struct wrapper_data *data)
{
	char *token = NULL, *state;
	char str[MAXPATHLEN + 1];

	if (data->path == NULL) return 0;

	/* Make a copy since strtok_r will modify path */
	snprintf(str, MAXPATHLEN + 1, "%s", data->path);

	token = strtok_r(str, ":", &state);

	/* Find the first file with suitable name in PATH.  The idea here is
	 * that we do not want to bind ourselfs to something static like the
	 * default profile, or some odd environment variable, but want to be
	 * able to build something with a non default gcc by just tweaking
	 * the PATH ... */
	while ((token != NULL) && strlen(token)) {
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
static int find_target_in_envd(struct wrapper_data *data, int cross_compile)
{
	FILE *envfile = NULL;
	char *token = NULL, *state;
	char str[MAXPATHLEN + 1];
	char *strp = str;
	char envd_file[MAXPATHLEN + 1];

	if (!cross_compile) {
		snprintf(envd_file, MAXPATHLEN, "%s", ENVD_BASE);
	} else {
		char *ctarget, *end = strrchr(data->name, '-');
		if (end == NULL)
			return 0;
		ctarget = strdup(data->name);
		ctarget[end - data->name] = '\0';
		snprintf(envd_file, MAXPATHLEN, "%s-%s", ENVD_BASE, ctarget);
		free(ctarget);
	}
	envfile = fopen(envd_file, "r");
	if (envfile == NULL)
		return 0;

	while (0 != fgets(strp, MAXPATHLEN, envfile)) {
		/* Keep reading ENVD_FILE until we get a line that
		 * starts with 'PATH='
		 */
		if (((strp) && (strlen(strp) > strlen("PATH=")) &&
		    !strncmp("PATH=", strp, strlen("PATH=")))) {

			token = strtok_r(strp, "=", &state);
			if ((token != NULL) && strlen(token))
				/* The second token should be the value of PATH .. */
				token = strtok_r(NULL, "=", &state);
			else
				goto bail;

			if ((token != NULL) && strlen(token)) {
				strp = token;
				/* A bash variable may be unquoted, quoted with " or
				 * quoted with ', so extract the value without those ..
				 */
				token = strtok(strp, "\n\"\'");

				while (token != NULL) {
					if (check_for_target(token, data)) {
						fclose(envfile);
						return 1;
					}

					token = strtok(NULL, "\n\"\'");
				}
			}
		}
		strp = str;
	}

bail:
	fclose(envfile);
	return (cross_compile ? 0 : find_target_in_envd(data, 1));
}

static void find_wrapper_target(struct wrapper_data *data)
{
	FILE *inpipe = NULL;
	char str[MAXPATHLEN + 1];

	if (find_target_in_path(data))
		return;

	if (find_target_in_envd(data, 0))
		return;

	/* Only our wrapper is in PATH, so
	   get the CC path using gcc-config and
	   execute the real binary in there... */
	inpipe = popen(GCC_CONFIG " --get-bin-path", "r");
	if (inpipe == NULL)
		wrapper_exit(
			"Could not open pipe: %s\n",
			wrapper_strerror(errno, data));

	if (fgets(str, MAXPATHLEN, inpipe) == 0)
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
	char dname_data[MAXPATHLEN + 1], str[MAXPATHLEN + 1];
	char *str2 = dname_data, *dname = dname_data;
	size_t len = 0;

	if (data->bin == NULL)
		return;

	snprintf(str2, MAXPATHLEN + 1, "%s", data->bin);

	if ((dname = dirname(str2)) == NULL)
		return;

	if (data->path == NULL)
		return;

	/* Make a copy since strtok_r will modify path */
	snprintf(str, MAXPATHLEN + 1, "%s", data->path);

	token = strtok_r(str, ":", &state);

	/* Check if we already appended our bin location to PATH */
	if ((token != NULL) && strlen(token)) {
		if (!strcmp(token, dname))
			return;
	}

	len = strlen(dname) + strlen(data->path) + 2 + strlen("PATH") + 1;

	newpath = (char *)malloc(len);
	if (newpath == NULL)
		wrapper_exit("out of memory\n");
	memset(newpath, 0, len);

	snprintf(newpath, len, "PATH=%s:%s", dname, data->path);
	putenv(newpath);
}

#define MAXNEWFLAGS 32
#define MAXFLAGLEN  127

static char **getNewArgv(char **argv, const char *newflagsStr) {
	char **newargv;
	char newflags[MAXNEWFLAGS][MAXFLAGLEN + 1];
	unsigned newflagsCount = 0;
	unsigned argc;
	unsigned i;
	char **p;

	unsigned s, f; /* start/finish of each flag. f points to
	                * the char AFTER the end (ie the space/\0
	                */

	/* Tokenize the flag list */
	for(s=0; s < strlen(newflagsStr); s=f+1) {
		/* Put s at the start of the next flag */
		while(newflagsStr[s] == ' ' || 
		      newflagsStr[s] == '\t')
			s++;
		if(s == strlen(newflagsStr))
			break;

		f = s + 1;
		while(newflagsStr[f] != ' ' && 
		      newflagsStr[f] != '\t' &&
		      newflagsStr[f] != '\0')
			f++;

		/* Detect overrun */
		if(MAXFLAGLEN < f - s || MAXNEWFLAGS == newflagsCount)
			return NULL;

		strncpy(newflags[newflagsCount], newflagsStr + s, f - s);
		newflags[newflagsCount][f - s]='\0';
		newflagsCount++;
	}

	/* Calculate original argc and see if it contains -m{abi,32,64} */
	for(argc=0, p=argv; *p; p++, argc++) {
		if(newflagsCount && (strncmp(*p, "-m32", 4) == 0 ||
		                     strncmp(*p, "-m64", 4) == 0 ||
		                     strncmp(*p, "-mabi", 5) == 0)) {
			/* Our command line sets the ABI, warn the user about this and ignore 
			 * newArgs by setting newflagsCount to 0.
			 */
			newflagsCount = 0;
		}
	}

	/* Allocate our array Make room for the original, new ones, and the
           NULL terminator */
	newargv = (char **)malloc(sizeof(char *) * (argc + newflagsCount + 1));
	if(!newargv)
		return NULL;

	/* Build argv */
	newargv[0] = argv[0];

	/* The newFlags come first since we want the environment to override them. */
	for(i=1; i - 1 < newflagsCount; i++) {
		newargv[i] = newflags[i - 1];
	}

	/* We just use the existing argv[i] as the start. */
	for(; i - newflagsCount < argc; i++) {
		newargv[i] = argv[i - newflagsCount];
	}

	/* And now cap it off... */
	newargv[i] = NULL;

	return newargv;
}

int main(int argc, char *argv[])
{
	struct wrapper_data *data;
	size_t size;
	char *path;
	int result = 0;
	char **newargv = argv;

	data = alloca(sizeof(*data));
	if (data == NULL)
		wrapper_exit("%s wrapper: out of memory\n", argv[0]);
	memset(data, 0, sizeof(*data));

	path = getenv("PATH");
	if (path != NULL) {
		data->path = strdup(getenv("PATH"));
		if (data->path == NULL)
			wrapper_exit("%s wrapper: out of memory\n", argv[0]);
	}

	/* What should we find ? */
	strcpy(data->name, basename(argv[0]));

	/* cc calls "/full/path/to/gcc" ... */
	if (!strcmp(data->name, "cc"))
		strcpy(data->name, "gcc");
	if (!strcmp(data->name, "f77"))
		data->name[0] = 'g';

	/* What is the full name of our wrapper? */
	size = sizeof(data->fullname);
	result = snprintf(data->fullname, size, "/usr/bin/%s", data->name);
	if ((result == -1) || (result > size))
		wrapper_exit("invalid wrapper name: \"%s\"\n", data->name);

	find_wrapper_target(data);

	modify_path(data);

	if (data->path)
		free(data->path);
	data->path = NULL;

	/* Set argv[0] to the correct binary, else gcc can't find internal headers
	 * http://bugs.gentoo.org/show_bug.cgi?id=8132 */
	argv[0] = data->bin;

	/* If this is g{cc,++}{32,64}, we need to add -m{32,64}
	 * otherwise  we need to add ${CFLAGS_${ABI}}
	 */
	size = strlen(data->bin) - 2;
	if(!strcmp(data->bin + size, "32") ) {
		*(data->bin + size) = '\0';
		newargv = getNewArgv(argv, "-m32");
	} else if (!strcmp(data->bin + size, "64") ) {
		*(data->bin + size) = '\0';
		newargv = getNewArgv(argv, "-m64");
	} else if(getenv("ABI")) {
		char *envar = (char *)malloc(sizeof(char) * (strlen("CFLAGS_") + strlen(getenv("ABI")) + 1 ));
		if(!envar)
			wrapper_exit("%s wrapper: out of memory\n", argv[0]);

		/* We use CFLAGS_${ABI} for gcc, g++, g77, etc as they are
		 * the same no matter which compiler we are using.
		 */
		sprintf(envar, "CFLAGS_%s", getenv("ABI"));

		if(getenv(envar)) {
			newargv = getNewArgv(argv, getenv(envar));
			if(!newargv)
				wrapper_exit("%s wrapper: out of memory\n", argv[0]);
		}

		free(envar);
	}

	/* Ok, do it ... */
	if (execv(data->bin, newargv) < 0)
		wrapper_exit("Could not run/locate \"%s\"\n", data->name);

	return 0;
}
