/*  devfsd.h

    Header file for  devfsd  (devfs daemon for Linux).

    Copyright (C) 1998-2000  Richard Gooch

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
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

    Richard Gooch may be reached by email at  rgooch@atnf.csiro.au
    The postal address is:
      Richard Gooch, c/o ATNF, P. O. Box 76, Epping, N.S.W., 2121, Australia.
*/

#define SYSLOG(level, format, args...) \
    {if (syslog_is_open) syslog (level, format, ##args); \
     else fprintf (stderr, format, ## args);}


/*  Public data  */
extern flag syslog_is_open;  /*  File: devfsd.c  */

#define RTLD_NEXT	((void *) -1l)