/*
 * Copyright 1999-2003 Gentoo Technologies, Inc.
 * Distributed under the terms of the GNU General Public License v2
 * Author: Martin Schlemmer <azarah@gentoo.org>
 * $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc-config/files/wrapper.c,v 1.6 2004/07/18 04:44:54 dragonheart Exp $
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


int main(int argc, char **argv) {
	struct stat sbuf;
	FILE *inpipe = NULL;
	char wrapperbin[MAXPATHLEN + 1], wrapfullname[MAXPATHLEN + 1];
	char *wrappername = NULL;
	char *buffer = NULL, *token = NULL, *tmpstr = NULL, *state = NULL;
	int ret = 0;

	wrapperbin[0] = '\0';

	/* What should we find ? */
	wrappername = strdupa(basename(argv[0]));

	/* cc calls gcc ... */
	if (0 == strcmp(wrappername, "cc"))
		sprintf(wrappername, "%s", "gcc");

	/* What is the full name of our wrapper? */
	snprintf(wrapfullname, strlen("/usr/bin/") + strlen(wrappername) + 1,
		"%s%s", "/usr/bin/", wrappername);

	/* If PATH is not set, just set token to NULL, else we get
	 * a segfault.  Thanks to Eric Andresen <ndiin1@cox.net> for
	 * reporting this. */
	if (NULL != getenv("PATH")) {
		
		buffer = strdup((char *)getenv("PATH"));
		token = strtok_r(buffer, ":", &state);
	} else
		token = NULL;
	
	/* Find the first file with suitable name in PATH.  The idea here is
	 * that we do not want to bind ourselfs to something static like the
	 * default profile, or some odd environment variable, but want to be
	 * able to build something with a non default gcc by just tweaking
	 * the PATH ... */
	while ((NULL != token) && (strlen(token) > 0)) {

		tmpstr = (char *)malloc(strlen(token) + strlen(wrappername) + 2);
		snprintf(tmpstr, strlen(token) + strlen(wrappername) + 2,
			"%s/%s", token, wrappername);

		/* Does it exist and is a file? */
		ret = stat(tmpstr, &sbuf);
		/* It exists, and are not our wrapper, and its in a dir containing
		 * gcc-bin ... */
		if ((0 == ret) && (sbuf.st_mode & S_IFREG) && 
		    (0 != strcmp(tmpstr, wrapfullname)) && (0 != strstr(tmpstr, "/gcc-bin/"))) {

			strncpy(wrapperbin, tmpstr, MAXPATHLEN);
				
			if (tmpstr) {
				free(tmpstr);
				tmpstr = NULL;
			}

			break;
		}
		
		token = strtok_r(NULL, ":", &state);
	}

	if (buffer) {
		free(buffer);
		buffer = NULL;
	}

	/* Did we get a valid binary to execute? */
	if (wrapperbin[0] == '\0') {

		/* It is our wrapper, so get the CC path, and execute the real binary in
		 * there ... */
		inpipe = popen("/usr/bin/gcc-config --get-bin-path", "r");
		if (NULL == inpipe) {
			
			fprintf(stderr, "Could not run /usr/bin/gcc-config!\n");
			exit(1);
		}

		buffer = (char *)malloc(MAXPATHLEN + 1);

		if (fgets(buffer, MAXPATHLEN, inpipe) == 0) {

			fprintf(stderr, "Could not get compiler binary path!\n");

			if (buffer) {
				free(buffer);
				buffer = NULL;
			}

			pclose(inpipe);

			exit(1);
		}

		sscanf(buffer, "%s", wrapperbin);
		strncat(wrapperbin, "/", MAXPATHLEN - strlen(wrapperbin));
		strncat(wrapperbin, wrappername, MAXPATHLEN - strlen(wrapperbin));

		pclose(inpipe);

		if (buffer) {
			free(buffer);
			buffer = NULL;
		}
	}

	/* Set argv[0] to the correct binary, else gcc do not find internal
	 * headers, etc (bug #8132). */
	argv[0] = wrapperbin;

	/* Ok, do it ... */
	if (execv(wrapperbin, argv) < 0) {
		fprintf(stderr, "Could not run/locate %s!\n", wrappername);
		exit(1);
	}

	return 0;
}

