/*
 * Copyright 2005 Gentoo Foundation
 * Distributed under the terms of the GNU General Public License v2
 * $Header: /var/cvsroot/gentoo-x86/app-portage/qfile/files/qfile.c,v 1.2 2005/06/01 11:05:56 solar Exp $
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
#include <regex.h>
#include <errno.h>
#include <libgen.h>

#ifndef PORTDIR
# define PORTDIR (getenv("PORTDIR") ? getenv("PORTDIR") : "/var/cvsroot/gentoo-x86")
#endif

typedef int (*Function) ();

Function lookup_applet(char *);

void initialize_ebuild_flat(void);
void reinitialize_ebuild_flat(void);
int rematch(char *, char *);
void qfile(char *, char *);

int q_main(int, char **);
int qsearch_main(int, char **);
int quse_main(int, char **);
int qfile_main(int, char **);
int qlist_main(int, char **);

#ifdef EBUG
# define DBG(a)  a
#else				/* !EBUG */
# define DBG(a)			/* nothing */
#endif				/* EBUG */

/* static const char *rcsid = "$Id: qfile.c,v 1.2 2005/06/01 11:05:56 solar Exp $"; */

int color = 1;
int exact = 0;
int found = 0;

/* *INDENT-OFF* */

struct applet_t {
	const char *name;
	/* int *func; */
	Function func;
	const char *opts;
} applets[] = {
	{"q", (Function) q_main, "<function> <args>"}, /* q must always be the first applet */
	{"qfile", (Function)qfile_main, "<filename>"},
	{"qlist", (Function)qlist_main, "<str>"},
	{"qsearch", (Function)qsearch_main, "<regexp>"},
	{"quse", (Function)quse_main, "<useflag>"}
};
/* *INDENT-ON* */

Function lookup_applet(char *applet)
{
   unsigned int i;
   for (i = 0; i < sizeof(applets) / sizeof(applets[0]); i++) {
      if ((strcmp(applets[i].name, applet)) == 0) {
	 DBG((fprintf
	      (stderr, "found applet %s at %p\n", applets[i].name,
	       applets[i].func)));
	 return applets[i].func;
      }
   }
   // No applet found? Search by shortname then..
   if ((strlen(applet)) - 1 > 0) {
      DBG((fprintf(stderr, "Looking up applet by short name\n")));
      for (i = 1; i < sizeof(applets) / sizeof(applets[0]); i++) {
	 if ((strcmp(applets[i].name + 1, applet)) == 0) {
	    return applets[i].func;
	 }
      }
   }
   /* still nothing? .. add short opts -q/-l etc.. */
   return 0;
}

int rematch(char *regex, char *match)
{
   regex_t preg;
   int ret;

   ret = regcomp(&preg, regex, REG_EXTENDED);
   if (ret) {
      char err[256];
      if (regerror(ret, &preg, err, sizeof(err)))
	 fprintf(stderr, "regcomp failed: %s\n", err);
      else
	 fprintf(stderr, "regcomp failed\n");
      return EXIT_FAILURE;
   }
   ret = regexec(&preg, match, 0, NULL, 0);
   regfree(&preg);

   return ret;
}

void qfile(char *path, char *fname)
{
   FILE *fp;
   DIR *dir;
   struct dirent *dentry;
   char *p, *newp;
   size_t flen = strlen(fname);
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
	 if (strncmp(base ? basename(newp) : newp, fname, flen) != 0
	     || strlen(base ? basename(newp) : newp) != flen) {
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

int qsearch_main(int argc, char **argv)
{
   FILE *fp;
   char buf[_POSIX_PATH_MAX];
   char ebuild[_POSIX_PATH_MAX];
   char last[126];
   char *p, *str, *q;

   DBG((fprintf
	(stderr, "Enter %s argc=%d argv[0]=%s argv[1]=%s\n",
	 __PRETTY_FUNCTION__, argc, argv[0],
	 argc > 1 ? argv[1] : "NULL?")));

   last[0] = 0;
   initialize_ebuild_flat();
   fp = fopen(".ebuild.x", "r");
   if (!fp)
      return 1;
   while ((fgets(ebuild, sizeof(ebuild), fp)) != NULL) {

      if ((p = strchr(ebuild, '\n')) != NULL)
	 *p = 0;
      if (!ebuild[0])
	 continue;
      str = strdup(ebuild);
      p = (char *) dirname(str);

      if ((strcmp(p, last)) != 0) {
	 FILE *newfp;
	 strncpy(last, p, sizeof(last));
	 if ((newfp = fopen(ebuild, "r")) != NULL) {
	    while ((fgets(buf, sizeof(buf), newfp)) != NULL) {
	       if ((strlen(buf) <= 13))
		  continue;
	       if ((strncmp(buf, "DESCRIPTION=", 12)) == 0) {
		  if ((q = strrchr(buf, '"')) != NULL)
		     *q = 0;
		  if (strlen(buf) <= 12)
		     break;
		  q = buf + 13;
		  if (argc > 1) {
		     if ((rematch(argv[1], q)) == 0) {
			fprintf(stdout, "%s %s\n", p, q);
		     }
		  } else {
		     fprintf(stdout, "%s %s\n", p, q);
		  }
		  break;
	       }
	    }
	    fclose(newfp);
	 } else
	    fprintf(stderr, "Error: opening %s %s\n", ebuild,
		    strerror(errno));
      }
      free(str);
   }
   fclose(fp);
   return EXIT_SUCCESS;
}

int quse_main(int argc, char **argv)
{
   FILE *fp;
   char buf[_POSIX_PATH_MAX];
   char ebuild[_POSIX_PATH_MAX];
   char *p;

   DBG((fprintf
	(stderr, "Enter %s argc=%d argv[0]=%s argv[1]=%s\n",
	 __PRETTY_FUNCTION__, argc, argv[0],
	 argc > 1 ? argv[1] : "NULL?")));

   initialize_ebuild_flat();	/* sets our pwd to $PORTDIR */
   fp = fopen(".ebuild.x", "r");
   if (!fp)
      return 1;
   while ((fgets(ebuild, sizeof(ebuild), fp)) != NULL) {
      FILE *newfp;
      if ((p = strchr(ebuild, '\n')) != NULL)
	 *p = 0;
      if ((newfp = fopen(ebuild, "r")) != NULL) {
	 while ((fgets(buf, sizeof(buf), newfp)) != NULL) {
	    if ((strncmp(buf, "IUSE=", 5)) == 0) {
	       if ((p = strrchr(&buf[6], '"')) != NULL)
		  *p = 0;
	       if (argc > 1) {
		  if ((rematch(argv[1], &buf[6])) == 0) {
		     fprintf(stdout, "%s %s\n", ebuild, &buf[6]);
		  }
	       } else {
		  fprintf(stdout, "%s %s\n", ebuild, &buf[6]);
	       }
	       break;
	    }
	 }
	 fclose(newfp);
      } else {
	 fprintf(stderr, "Error: opening %s %s\n", ebuild,
		 strerror(errno));
      }
   }
   fclose(fp);
   return 0;
}

int qfile_main(int argc, char **argv)
{
   DIR *dir;
   struct dirent *dentry;
   int i;
   char *p;
   const char *path = "/var/db/pkg";

   DBG((fprintf
	(stderr, "Enter %s argc=%d argv[0]=%s argv[1]=%s\n",
	 __PRETTY_FUNCTION__, argc, argv[0],
	 argc > 1 ? argv[1] : "NULL?")));

   if (argc <= 1) {
      printf("Usage: qfile <filename>\n");
      return 0;
   }
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
   return (found ? EXIT_SUCCESS : EXIT_FAILURE);
}

int qlist_main(int argc, char **argv)
{
   DIR *dir, *dirp;
   struct dirent *dentry, *de;
   char *cat, *p, *q;
   const char *path = "/var/db/pkg";
   struct stat st;
   char buf[_POSIX_PATH_MAX];
   char buf2[_POSIX_PATH_MAX];


   DBG((fprintf
	(stderr, "Enter %s argc=%d argv[0]=%s argv[1]=%s\n",
	 __PRETTY_FUNCTION__, argc, argv[0],
	 argc > 1 ? argv[1] : "NULL?")));

   if (chdir(path) != 0 || (dir = opendir(path)) == NULL)
      return 1;

   readdir(dir);
   readdir(dir);		/* skip . & .. */

   p = q = cat = NULL;

   if (argc > 1)
      cat = strchr(argv[1], '/');
   while ((dentry = readdir(dir))) {
      if ((strchr((char *) dentry->d_name, '-')) == 0)
	 continue;
      stat(dentry->d_name, &st);
      if (!(S_ISDIR(st.st_mode)))
	 continue;
      chdir(dentry->d_name);
      if ((dirp = opendir(".")) == NULL)
	 continue;
      readdir(dirp);
      readdir(dirp);		/* skip . & .. */
      while ((de = readdir(dirp))) {
	 if (argc > 1) {
	    if (cat != NULL) {
	       snprintf(buf, sizeof(buf), "%s/%s", dentry->d_name,
			de->d_name);
	       if ((strstr(buf, argv[1])) == 0)
		  continue;
	    } else {
	       if ((strstr(de->d_name, argv[1])) == 0)
		  continue;
	    }
	 }
	 if (argc < 2)
	    printf("%s/%s\n", dentry->d_name, de->d_name);
	 else {
	    FILE *fp;
	    snprintf(buf, sizeof(buf), "/var/db/pkg/%s/%s/CONTENTS",
		     dentry->d_name, de->d_name);
	    if ((fp = fopen(buf, "r")) == NULL)
	       continue;
	    while ((fgets(buf, sizeof(buf), fp)) != NULL) {
	       if ((p = strchr(buf, ' ')) == NULL)
		  continue;
	       ++p;
	       switch (buf[0]) {
		  case '\n':	// newline
		     break;
		  case 'd':	// dir
		     printf("%s", p);
		     break;
		  case 'o':	// obj
		  case 's':	// sym
		     strcpy(buf2, p);
		     if ((p = strchr(buf2, ' ')) != NULL)
			*p = 0;
		     printf("%s\n", buf2);
		     break;
	       }
	    }
	    fclose(fp);
	 }

      }
      closedir(dirp);
      chdir("..");
   }
   closedir(dir);
   return 0;
}

void initialize_ebuild_flat(void)
{
   if ((chdir(PORTDIR)) != 0) {
      fprintf(stderr,
	      "Error: unable chdir to what I think is your PORTDIR '%s' : %s\n",
	      PORTDIR, strerror(errno));
      return;
   }

   /* assuming --sync is used with --delete this will get recreated after every merged */
   if (access(".ebuild.x", R_OK) != 0) {
      FILE *fp;
      fprintf(stderr, "Updating ebuild quick cache\n");
      if ((fp = fopen(".ebuild.x", "w")) == NULL) {
	 fprintf(stderr, "Error opening %s/.ebuild.x %s\n", PORTDIR,
		 strerror(errno));
	 return;
      }
      fclose(fp);
      /* we use system() here for it's ability to allow for bash globbing */
      system("echo *-*/*/*.ebuild | tr ' ' '\n' > .ebuild.x");
      fputs("done..\n", stderr);
   }
}

void reinitialize_ebuild_flat(void)
{
   unlink(".ebuild.x");
   initialize_ebuild_flat();
}

int q_main(int argc, char **argv)
{
   unsigned int i;
   char *p;
   Function func;

   if (argc == 0)
      return 1;

   p = basename(argv[0]);

   if ((func = lookup_applet(p)) == 0) {
      fprintf(stderr, "q: Unknown applet '%s'\n", p);
      return 1;
   }
   if (strcmp("q", p) != 0)
      return (func) (argc, argv);

   if ((argc < 2) || ((argc > 0) && (strcmp(argv[1], "--help") == 0))) {
      if (argc > 1) {
	 printf("trying to get help on an applet %s eh?\n", argv[2]);
      }
      printf
	  ("Usage: q <function> [arguments]...\n   or: <function> [arguments]...\n\n");
      printf("Currently defined functions:\n");
      for (i = 0; i < sizeof(applets) / sizeof(applets[0]); i++)
	 printf(" - %s %s\n", applets[i].name, applets[i].opts);
      return 0;
   }
   if (((strcmp(argv[1], "--install")) == 0) && (argc >= 2)) {
      char buf[_POSIX_PATH_MAX];
      printf("Installing symlinks..\n");
      if ((readlink("/proc/self/exe", buf, sizeof(buf))) == (-1)) {
	 perror("readlink");
	 return 1;
      }
      if (chdir((char *) dirname(buf)) != 0) {
	 perror(buf);
	 return 1;
      }
      for (i = 0; i < sizeof(applets) / sizeof(applets[0]); i++)
	 symlink("q", applets[i].name);
      return 0;
   }
   if ((func = lookup_applet(argv[1])) == 0) {
      fprintf(stderr, "q: Unknown applet '%s'\n", argv[1]);
      return 1;
   }
   return (func) (argc - 1, ++argv);
}

int main(int argc, char **argv)
{
   return q_main(argc, argv);
}
