
/*
 * xa_ipc.h
 *
 * Copyright (C) 1995-1998,1999 by Mark Podlipec. 
 * All rights reserved.
 *
 * This software may be freely used, copied and redistributed without
 * fee for non-commerical purposes provided that this copyright
 * notice is preserved intact on all copies.
 * 
 * There is no warranty or other guarantee of fitness of this software.
 * It is provided solely "as is". The author disclaims all
 * responsibility and liability with respect to this software's usage
 * or its effect upon hardware or computer systems.
 *
 */
/****************
 * Rev History
 *
 * 03Jun95 - Created
 *
 *******************************/


#include <errno.h>
#include "xa_export.h"

/* POD: Make this as big as possible without breaking pipes */
/* #define XA_IPC_CHUNK 16384 */

#ifdef XA_SOCKET
#define XA_IPC_CHUNK 4096    /* or higher?? */
#else  /* PIPE */
#define XA_IPC_CHUNK 256
#endif

/*                               */
#define XA_IPC_ERR		0x00000
#define XA_IPC_OK		0x00001
#define XA_IPC_TOD		0x00002
#define XA_IPC_BOFL		0x00003
/*                               */
#define XA_IPC_HELLO		0x00010
/*                               */
#define XA_IPC_FILE		0x00100
#define XA_IPC_UNFILE		0x00101
#define XA_IPC_FNAME		0x00102
#define XA_IPC_PLAY_FILE	0x00103
#define XA_IPC_N_FILE		0x00104
#define XA_IPC_P_FILE		0x00105
#define XA_IPC_SND_INIT		0x00106
#define XA_IPC_SND_ADD		0x00107
#define XA_IPC_SND_BUF		0x00108
#define XA_IPC_RST_TIME		0x00109
#define XA_IPC_VID_TIME		0x0010a
#define XA_IPC_MERGEFILE	0x0010b
/*                               */
#define XA_IPC_AUD_EXPORT	0x001ff
#define XA_IPC_AUD_SETUP	0x00200
#define XA_IPC_AUD_INIT		0x00201
#define XA_IPC_AUD_KILL		0x00202
#define XA_IPC_AUD_PREP		0x00203
#define XA_IPC_AUD_ON		0x00204
#define XA_IPC_AUD_OFF		0x00205
#define XA_IPC_AUD_PORT		0x00206
#define XA_IPC_AUD_STOG		0x00207
#define XA_IPC_AUD_HTOG		0x00208
#define XA_IPC_AUD_LTOG		0x00209

#define XA_IPC_AUD_ENABLE	0x0020a
#define XA_IPC_AUD_MUTE		0x0020b
#define XA_IPC_AUD_VOL 		0x0020c
#define XA_IPC_AUD_RATE		0x0020d
#define XA_IPC_AUD_DEV 		0x0020e
#define XA_IPC_AUD_FFLAG	0x0020f
#define XA_IPC_AUD_BFLAG	0x00210
/*                               */
#define XA_IPC_GET_CFREQ	0x00300
#define XA_IPC_GET_BSIZE	0x00301
#define XA_IPC_GET_STATUS	0x00302
#define XA_IPC_GET_PRESENT	0x00303
/*                               */
#define XA_IPC_SET_AUDBUFF	0x00400
#define XA_IPC_SET_KLUDGE2	0x00401
#define XA_IPC_SET_KLUDGE900	0x00402
/*                               */
#define XA_IPC_EXIT		0x0FFFF
/*                               */
#define XA_IPC_ACK_OK		0x10001
#define XA_IPC_ACK_ERR		0x10002
#define XA_IPC_ACK_BYE		0x10003

typedef struct
{
  xaULONG cmd;
   xaLONG time;
  xaULONG len;
  xaULONG id;
  xaULONG value;
} XA_IPC_HDR;

#define XA_FD_READ  0
#define XA_FD_WRITE 1
#define XA_IAM_VIDEO 1
#define XA_IAM_AUDIO 2

typedef struct STRUCT_XA_AUD_HDR
{
  xaULONG num;
  char *filename;
  xaULONG max_faud_size;
  XA_SND *first_snd;    /* ptr to first sound chunk */
  XA_SND *last_snd;     /* ptr to last sound chunk */
  void (*init_aud)();
  struct STRUCT_XA_AUD_HDR *next;
  struct STRUCT_XA_AUD_HDR *prev;
} XA_AUD_HDR;

