
/*
 * xa_audio.h
 *
 * Copyright (C) 1994-1998,1999 by Mark Podlipec.
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


#include "xanim.h"
#include <Intrinsic.h>
#include <StringDefs.h>
#include <Shell.h>

#include "xa_x11.h"
#include "xa_ipc.h"
#include "xa_ipc_cmds.h"
#include "xa_export.h"

extern xaULONG xa_forkit;

/* Rather than spend time figuring out which ones are common
 * across machine types, just redo them all each time.
 * Eventually I'll simplify.
 */


/*********************** SPARC INCLUDES ********************************/
#ifdef XA_SPARC_AUDIO
/* Sun 4.1 -I/usr/demo/SOUND/multimedia ??? */
#include <errno.h>
#include <fcntl.h>
#include <stropts.h>
#ifdef SVR4         /* was SOLARIS */
#include <sys/audioio.h>
#else
#include <sun/audioio.h>
#endif
#include <sys/file.h>
#include <sys/stat.h>
#endif

/*********************** DEC Multimedia Services INCLUDES = **************/
#ifdef XA_MMS_AUDIO
/*
#ifdef BYTE
#undef BYTE
#endif
#ifdef WORD
#undef WORD
#endif
#ifdef LONG
#undef LONG
#endif
#ifdef UWORD
#undef UWORD
#endif
#ifdef SHORT
#undef SHORT
#endif
*/
#include <mme/mme_api.h>
#ifdef XA_MMS_160
#include <mme/mmsystem.h>
#endif
#endif


/*********************** IBM S6000 INCLUDES ******************************/
#ifdef XA_AIX_AUDIO
#include <errno.h>
#include <fcntl.h>
#include <sys/audio.h>
#include <stropts.h>
#include <sys/types.h>
#include <sys/file.h>
#include <sys/stat.h>
#include <sys/param.h>
#endif

/*********************** NEC EWS INCLUDES ******************************/
#ifdef XA_EWS_AUDIO
#include <errno.h>
#include <sys/audio.h>
#endif

/*********************** SONY NEWS INCLUDES ****************************/
#ifdef XA_SONY_AUDIO
#include <errno.h>
#ifdef SVR4
#include <sys/sound.h>
#else /* SVR4 */
#include <newsiodev/sound.h>
#endif
#endif /* XA_SONY_AUDIO */

/*********************** NetBSD INCLUDES *******************************/
#ifdef XA_NetBSD_AUDIO
#include <errno.h>
#include <fcntl.h>
#include <sys/audioio.h>
#include <sys/file.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <sys/ioccom.h>
#endif


/*********************** LINUX INCLUDES ********************************/
#ifdef XA_LINUX_AUDIO
#include <errno.h>
#include <fcntl.h>
#include <sys/time.h>
/* POD NOTE: possibly <machine/soundcard.h> ???*/

#if defined(__bsdi__) && _BSDI_VERSION < 199510
#include <i386/isa/sblast.h>
#define SNDCTL_DSP_SYNC DSP_IOCTL_FLUSH
#define SNDCTL_DSP_STEREO DSP_IOCTL_STEREO
#define SNDCTL_DSP_SPEED DSP_IOCTL_SPEED
  /* #define SNDCTL_DSP_SAMPLESIZE */
  /* #define SNDCTL_DSP_GETBLKSIZE this value is ignored anyway */
#define SOUND_MIXER_READ_DEVMASK MIXER_IOCTL_READ_PARAMS
#define SOUND_MIXER_PCM 10 /* to make sure it's ignored */
#define SOUND_MIXER_VOLUME MIXER_IOCTL_SET_LEVELS
#define MIXER_WRITE(n) n
#define _FILE_DSP "/dev/sb_dsp"
#define _FILE_MIXER "/dev/sb_mixer"
#else
#define _FILE_DSP "/dev/dsp"
#define _FILE_MIXER "/dev/mixer"
#ifdef __FreeBSD__
#include <machine/soundcard.h>
#else
#include <sys/soundcard.h>
#endif
#endif  /* end __bsdi__ */

#endif /* end LINUX */

/*********************** SGI INCLUDES **********************************/
#ifdef XA_SGI_AUDIO
#include <errno.h>
#include <fcntl.h>
#include <stropts.h>
#include <sys/time.h>
#include <audio.h>
#include <math.h>
#endif

/*********************** HP INCLUDES ***********************************/
#ifdef XA_HP_AUDIO
#include <fcntl.h>
#include <time.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>
#ifdef XA_HP10
#include <Alib.h>
#include <CUlib.h>
#else /* HPUX 9.x */
#include <audio/Alib.h>
#include <audio/CUlib.h>
#endif
#endif

#ifdef XA_HPDEV_AUDIO
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <time.h>
#include <errno.h>
#include <sys/audio.h>
#endif


/*********************** AF(AudioFile) INCLUDES ************************/
#ifdef XA_AF_AUDIO
#include <AF/audio.h>
#include <AF/AFlib.h>
#include <AF/AFUtils.h>
#endif

/*********************** NAS(Network Audio System) INCLUDES *************/
#ifdef XA_NAS_AUDIO
#undef xaBYTE
#include <audio/audiolib.h>
#include <audio/soundlib.h>
#include <audio/Xtutil.h>
#endif

/*********************** TOWNS Linux INCLUDES **************************/
#ifdef XA_TOWNS_AUDIO
#include <linux/fmmidi.h>
#endif

/*********************** TOWNS Linux 8 bit PCM INCLUDES *****************/
#ifdef XA_TOWNS8_AUDIO
#endif


/*********************** END   INCLUDES ********************************/

