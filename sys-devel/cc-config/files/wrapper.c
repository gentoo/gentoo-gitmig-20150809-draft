/*
 * Copyright 1999-2003 Gentoo Technologies, Inc.
 * Distributed under the terms of the GNU General Public License v2
 * Author: Martin Schlemmer <azarah@gentoo.org>
 * $Header: /var/cvsroot/gentoo-x86/sys-devel/cc-config/files/wrapper.c,v 1.3 2004/07/18 04:43:22 dragonheart Exp $
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

	buffer = strdup((char *)getenv("PATH"));
	token = strtok_r(buffer, ":", &state);
	
	/* Find the first file with suitable name in PATH */
	while ((NULL != token) && (strlen(token) > 0)) {

		tmpstr = (char *)malloc(strlen(token) + strlen(wrappername) + 2);
		snprintf(tmpstr, strlen(token) + strlen(wrappername) + 2,
			"%s/%s", token, wrappername);

		/* Does it exist and is a file? */
		ret = stat(tmpstr, &sbuf);
		/* It exists, and are not our wrapper, and its not in /usr/bin ... */
		if ((0 == ret) && (sbuf.st_mode & S_IFREG) && 
		    (0 != strcmp(tmpstr, wrapfullname)) && (0 == strstr(tmpstr, "/usr/bin"))) {

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
		inpipe = popen("/usr/bin/cc-config --get-bin-path", "r");
		if (NULL == inpipe) {
			
			fprintf(stderr, "Could not run /usr/bin/cc-config!\n");
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

	/* Ok, do it ... */
	if (execv(wrapperbin, argv) < 0) {
		fprintf(stderr, "Could not run/locate %s!\n", wrappername);
		exit(1);
	}

	return 0;
}

