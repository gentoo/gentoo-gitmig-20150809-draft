/*
 * gpmInt.h - server-only stuff for gpm-Linux
 *
 * Copyright (C) 1994-1999  Alessandro Rubini <rubini@linux.it>
 * Copyright (C) 1998	    Ian Zimmerman <itz@rahul.net>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
 ********/

#ifndef _GPMINT_INCLUDED
#define _GPMINT_INCLUDED

/* $Id: gpmInt.h,v 1.1 2000/11/12 21:35:07 achim Exp $ */

#include <sys/types.h>          /* time_t */

#include "gpmCfg.h"
#include "gpm.h"

#if !defined(__GNUC__)
#  define inline
#endif 

#ifdef DEBUG
#  define inline
#endif

#ifndef OPEN_MAX
#define OPEN_MAX 256
#endif

#include "wd.h" /* when debugging macros */

/*....................................... Strange requests (iff conn->pid==0)*/

#define GPM_REQ_SNAPSHOT 0
#define GPM_REQ_BUTTONS  1
#define GPM_REQ_CONFIG   2
#define GPM_REQ_NOPASTE  3

/*....................................... Structures */


/*
 * and this is the entry in the mouse-type table
 */
typedef struct Gpm_Type {
  char *name;
  char *desc;             /* a descriptive line */
  char *synonyms;         /* extra names (the XFree name etc) as a list */
  int (*fun)(Gpm_Event *state, unsigned char *data);
  struct Gpm_Type *(*init)(int fd, unsigned short flags,
			   struct Gpm_Type *type, int argc, char **argv);
  unsigned short flags;
  unsigned char proto[4];
  int packetlen;
  int howmany;            /* howmany bytes to read at a time */
  int getextra;           /* does it get an extra byte? (only mouseman) */
  int absolute;           /* flag indicating absolute pointing device */

  int (*repeat_fun)(Gpm_Event *state, int fd); /* repeat this event into fd */
                          /* itz Mon Jan 11 23:27:54 PST 1999 */
}                   Gpm_Type;

#define GPM_EXTRA_MAGIC_1 0xAA
#define GPM_EXTRA_MAGIC_2 0x55

typedef struct Gpm_Cinfo {
  Gpm_Connect data;
  int fd;
  struct Gpm_Cinfo *next;
}              Gpm_Cinfo;


/*....................................... Global variables */

/* this structure is used to hide the dual-mouse stuff */

struct mouse_features {
  char *opt_type, *opt_dev, *opt_sequence;
  int opt_baud,opt_sample,opt_delta, opt_accel, opt_scale, opt_scaley;
  int opt_time, opt_cluster, opt_three, opt_glidepoint_tap;
  char *opt_options; /* extra textual configuration */
  Gpm_Type *m_type;
  int fd;
};

extern struct mouse_features mouse_table[3], *which_mouse; /*the current one*/

typedef struct Opt_struct_type {int a,B,d,i,p,r,V,A;} Opt_struct_type;

/* this is not very clean, actually, but it works fine */
#define opt_type     (which_mouse->opt_type)
#define opt_dev      (which_mouse->opt_dev)
#define opt_sequence (which_mouse->opt_sequence)
#define opt_baud     (which_mouse->opt_baud)
#define opt_sample   (which_mouse->opt_sample)
#define opt_delta    (which_mouse->opt_delta)
#define opt_accel    (which_mouse->opt_accel)
#define opt_scale    (which_mouse->opt_scale)
#define opt_scaley   (which_mouse->opt_scaley)
#define opt_time     (which_mouse->opt_time)
#define opt_cluster  (which_mouse->opt_cluster)
#define opt_three    (which_mouse->opt_three)
#define opt_glidepoint_tap (which_mouse->opt_glidepoint_tap)
#define opt_options  (which_mouse->opt_options)

#define m_type       (which_mouse->m_type)

/* the other variables */

extern char *prgname;
extern char *opt_lut;
extern int opt_test, opt_ptrdrag;
extern int opt_kill;
extern int opt_repeater, opt_double;
extern char* opt_repeater_type;
extern int opt_kernel, opt_explicittype;
extern int opt_aged;
extern time_t opt_age_limit;
extern char *opt_special;
extern int opt_rawrep;
extern int fifofd;
extern char *consolename; /* the selected one */

extern Gpm_Type *repeated_type;
extern Gpm_Type mice[];
extern struct winsize win;
extern int maxx, maxy;
extern Gpm_Cinfo *cinfo[MAX_VC+1];

/*....................................... Prototypes */
       /* gpm.c */
int main(int argc, char **argv);

       /* gpn.c */
#define oops(s) gpm_oops(__FILE__, __LINE__,(s))
int cmdline(int argc, char **argv);
int giveInfo(int request, int fd);
       /* mice.c */
extern int M_listTypes(void);
       /* special.c */
int processSpecial(Gpm_Event *event);
int twiddler_key(unsigned long message);
int twiddler_key_init(void);

/*....................................... Dirty hacks */

#undef GPM_USE_MAGIC /* magic token foreach message? */


#ifdef GPM_USE_MAGIC
#define MAGIC_P(code) code
#else
#define MAGIC_P(code) 
#endif

#endif /* _GPMINT_INCLUDED */
