/*
 * Copyright 2003-2005 Gentoo Foundation
 * Distributed under the terms of the GNU General Public License v2
 * $Header: /var/cvsroot/gentoo-x86/app-portage/qfile/files/qfile.c,v 1.1 2005/05/10 12:41:51 solar Exp $
 *
 * 2005 Ned Ludd <solar@gentoo.org>
 *
 ********************************************************************
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston,
 * MA 02111-1307, USA.
 *
 */

#define _GNU_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <dirent.h>
#include <getopt.h>

/* static const char *rcsid = "$Id: qfile.c,v 1.1 2005/05/10 12:41:51 solar Exp $"; */

int color = 1;
int exact = 0;
int found = 0;

void qfile(char *path, char *fname)
{
   FILE *fp;
   DIR *dir;
   struct dirent *dentry;
   char *p, *newp;
   int flen = strlen(fname);
   int base = 0;
   char buffer[1024];

   if (chdir(path) != 0 || (dir = opendir(path)) == NULL)
      return;

   if (!strchr(fname, '/'))
      base = 1;
   else
      base = 0;

   readdir(dir);
   readdir(dir);		/* skip . & .. */
   while ((dentry = readdir(dir))) {
      if ((asprintf(&p, "%s/%s/CONTENTS", path, dentry->d_name)) == (-1))
	 continue;
      if ((fp = fopen(p, "r")) == NULL) {
	 free(p);
	 continue;
      }
      free(p);
      while ((fgets(buffer, sizeof(buffer), fp)) != NULL) {
	 if ((p = strchr(buffer, ' ')) == NULL)
	    continue;
	 *p++;
	 newp = strdup(p);
	 if (!newp)
	    continue;
	 if ((p = strchr(newp, ' ')) != NULL)
	    *p++ = 0;
	 if (strncmp(!base ? newp : basename(newp), fname, flen) != 0
	     || strlen(!base ? newp : basename(newp)) != flen) {
	    free(newp);
	    continue;
	 }
	 /* If the d_name is something like foo-3DVooDoo-0.0-r0 doing non
	  * exact matches would fail to display the name properly.
	  * /var/cvsroot/gentoo-x86/app-dicts/canna-2ch/
	  * /var/cvsroot/gentoo-x86/net-dialup/intel-536ep/
	  * /var/cvsroot/gentoo-x86/net-misc/cisco-vpnclient-3des/
	  * /var/cvsroot/gentoo-x86/sys-cluster/openmosix-3dmon-stats/
	  * /var/cvsroot/gentoo-x86/sys-cluster/openmosix-3dmon/
	  */
	 if (!exact && (p = strchr(dentry->d_name, '-')) != NULL) {
	    ++p;
	    if (*p >= '0' && *p <= '9') {
	       --p;
	       *p = 0;
	    } else {
	       /* tricky tricky.. I wish to advance to the second - */
	       /* and repeat the first p strchr matching */
	       char *q = strdup(p);
	       if (!q) {
		  free(newp);
		  continue;
	       }
	       if ((p = strchr(q, '-')) != NULL) {
		  int l = 0;
		  ++p;
		  if (*p >= '0' && *p <= '9') {
		     --p;
		     *p = 0;
		     ++p;
		     l = strlen(dentry->d_name) - strlen(p) - 1;
		     dentry->d_name[l] = 0;
		  }
	       }
	       free(q);
	    }
	 }

	 if (color)
	    printf("\e[0;01m%s/\e[36;01m%s\e[0m (%s)\n", basename(path),
		   dentry->d_name, newp);
	 else
	    printf("%s/%s (%s)\n", basename(path), dentry->d_name, newp);

	 free(newp);
	 fclose(fp);
	 closedir(dir);
	 found++;
	 return;
      }
      fclose(fp);
   }
   closedir(dir);
   return;
}

int main(int argc, char **argv)
{
   DIR *dir;
   struct dirent *dentry;
   int i;
   char *p, *path = "/var/db/pkg";

   if ((chdir(path) == 0) && ((dir = opendir(path)))) {
      readdir(dir);
      readdir(dir);		/* skip . & .. */
      while ((dentry = readdir(dir))) {
	 for (i = 1; i < argc; i++) {
	    if (argv[i][0] != '-') {
	       if ((asprintf(&p, "%s/%s", path, dentry->d_name)) != (-1)) {
		  qfile(p, argv[i]);
		  free(p);
	       }
	    } else {
	       if (((strcmp(argv[i], "-nc")) == 0)
		   || ((strcmp(argv[i], "-C")) == 0))
		  color = 0;

	       if (((strcmp(argv[i], "-e")) == 0)
		   || ((strcmp(argv[i], "-exact")) == 0))
		  exact = 1;
	    }
	 }
      }
      closedir(dir);
   }
   exit(found ? EXIT_SUCCESS : EXIT_FAILURE);
}
