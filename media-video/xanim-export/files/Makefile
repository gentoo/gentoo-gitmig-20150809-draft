.SUFFIXES: .c .o

############################################################################
#
#              Makefile for XAnim Rev 2.80.0
#
#
############################################################################
# Readme Readme Readme Readme Readme Readme Readme Readme Readme Readme
############################################################################
#
# I've tried to organized and partition this Makefile so it's easier
# to configure. Feedback is appreciated.
#
# First and foremost, please read the following files:
#   
#        "README.dll"
#        "README.zlib"
#
# If your machine/OS isn't yet supported by the DLL modules, then
# you should also read these additional files:
#
#        "cinepak.readme"
#        "indeo.readme"
#        "creative.readme" 
#   
# Then goto each Section and configure, comment, uncomment the Defines
# as necessary.  Some parts might have you search for a NOTE_* later
# on in the Makefile and do something special there.
#
# Index of Sections
# ---------------    -----------------------------------------------
# -- Section I     - Name of Output File.
# -- Section IIa   - Compiler and Compiler Flags
# -- Section IIb   - Linker and Linker Flags
# -- Section IIIa  - DLL Defines/Libs
# -- Section IIIb  - ZLIB Defines/Libs
# -- Section IIIc  - Video Defines/Libs
# -- Section IV.a  - X11/OpenWindow Libs and Includes Directories.
# -- Section IV.b  - Are you running X11R6?
# -- Section V     - no longer used
# -- Section VI    - Audio Defines and Libraries.
# -- Section VII   - Machine Specific Defines and Libs(and Misc stuff)
# ----------------   -----------------------------------------------
#
# Good luck,
#
# Mark Podlipec - podlipec@baynetworks.com
#               - podlipec@ici.net
#
############

############################################################################
# -- Section I
# -- Output File (The name of the final executable)
############################################################################
#
XANIM = xanim


############################################################################
# -- Section IIa
# -- Choose your favorite C Compiler and Compiler flags
#
# NOTE: working on adding suggestions for specific machines.
############################################################################
#
######### C COMPILER
# Specify the C Compiler that you have on your machine.
#   NOTE: SunOS must use "cc" if you are using the DLL libs. I wasn't
#         able to get "gcc" to do the right thing when it comes to
#	  loading dlls(dlopen,dlsym). Stack mismatch. Might also just be
#         a setup problem on my SunOS machine.   Under Solaris, gcc worked
#         fine.
#
# CC = cc
 CC = gcc
#CC = egcs
#
######### OPTIMIZATION FLAGS
# -- Specifiy Any compiler Optimization flags that you wish to use. This
#    is highly recommended. See the man page on your compiler for details
#    but usually at least -O2 is supported.
#
#OPTIMIZE = -O2 -funroll-loops -fomit-frame-pointer -malign-loops=2 -malign-functions=2 -malign-jumps=2
#OPTIMIZE = -O2 -march=i686 -funroll-loops -fomit-frame-pointer -malign-loops=2 -malign-functions=2 -malign-jumps=2 -I/usr/local/include
OPTIMIZE = -O2
#
# Linux x86
# OPTIMIZE = -O4 -m486
#
# -- SGI Indigo with MIPS R4xxx Processor
# OPTIMIZE= -O2 -cckr -Wf,-XNh2000 -mips2
#
######### DEBUG FLAGS
#  Specify debug flags. You do not normally need to do this. Note that most
#  compilers don't like it when you mix optimization flags and debug flags.
#DEBUG = -g -Wall



############################################################################
# -- Section IIb
# -- Setup the Linker and Linker Flags.
#
# NOTE: working on adding suggestions for specific machines.
############################################################################
#
######### LINKER
#  Specify the Linker that you have on your machine. Usually you can just
#    set this to be the same as your C Compiler. This will hopefully only
#    need to be different for a limited number of machines.
#  
LD = $(CC)
#
######### LINKER FLAGS
#  Specify any Linker flags needed to allow dynamically loadable modules
#  to link against symbols inside xanim.
#
### Linux
LD_FLAGS = -rdynamic
### SunOS/Solaris use:
# LD_FLAGS =


##########################################################################
# -- Section IIIa
# -- Setup DLL Flags if supported on your platform. 
# -- NOTE: Please read "README.dll"
#
# So far I've only tested this on Linux_x86, SunOS_Sparc and Solaris_Sparc
#
# NOTE: not all machines need the XA_DLL_LIB define.
##########################################################################
#
XA_DLL_DEF = -DXA_DLL -DXA_PRINT
#### Use this only if the above doesn't work.
#XA_DLL_DEF = -DXA_DLL
#
#### You may need this library.
XA_DLL_LIB = -ldl
#
# If you'd like to change the default directory that XAnim searches while
# looking for dlls, then change the directory below. 
#
XA_DLL_PATH = /usr/X11R6/lib/xanim/mods-export


##########################################################################
# -- Section IIIb
# -- If you have ZLIB, compile in support for Quicktime 3.0 
# -- compressed headers. NOTE: Please read "README.zlib"
#
##########################################################################
#
# -- Uncomment these if you have the library libz.* on your machine.
XA_ZLIB_DEF = -DXA_ZLIB
XA_ZLIB_LIB = -lz
#
# -- If the file libz.* is not in a directory that is normally 
#    searched by your linker, then you need to uncomment the 
#    following define and change "/home/zlib/incs" to be the
#    full path of the directory on your machine that actually
#    contains zlib include files:
#
# XA_ZLIB_INCS = -I/home/zlib/incs
#
#    And you have to uncomment the following define and 
#    change "/home/zlib/libs" to be the full path of the
#    directory on your machine that actually contains zlib
#    library file:
#
# XA_ZLIB_LDIR = -L/home/zlib/libs
#

##########################################################################
# -- Section IIIc
# -- Video Support Defines.  These are okay to leave blank if you
# -- don't know what to do, BUT in that case you should really 
# -- read the following files:
# --
# --     "cinepak.readme"
# --     "indeo.readme"
# --     "creative.readme" 
# --
# -- Latest files are available from the following sites:
# --
# --    http://xanim.va.pubnix.com/home.html
# --    http://smurfland.cit.buffalo.edu/xanim/home.html
# --	http://xanim.resnet.gatech.edu
# --    http://www.tm.informatik.uni-frankfurt.de/xanim/
# --
##########################################################################
#
# -- NOTE: If XAnim supports dynamically loadable modules for your machine 
#    and you have the XA_DLL_* uncommented above then you do NOT want to
#    uncomment any of these.
#
# -- Modify the following ONLY after you have read the appropriate readmes
# -- AND have downloaded the proper decompression modules AND have verified
# -- that they are the correct size in bytes as listed in the readmes.
# --
# --    Cinepak		CVID	cinepak.readme
# --    Indeo 3.x	IV32	indeo.readme
# --    Creative   	CYUV	creative.readme
# 
# Again don't use these if you are using the dynamically loadable modules.
#
# XA_IV32_DEF = -DXA_IV32 
# XA_CVID_DEF = -DXA_CVID
# XA_CYUV_DEF = -DXA_CYUV
#
XA_IV32_LIB = mods/xa2.1_iv32_linuxELFg21.o
XA_CVID_LIB = mods/xa2.0_cvid_linuxELFg21.o
XA_CYUV_LIB = mods/xa1.0_cyuv_linuxELFg21.o
#
###########################
# NOTE: SGI Machines Only: 
#    if your linker core dumps then you'll need to uncomment the following
#    define as a workaround.
#
# XA_SGI1 = -old_ld -32
#


############################################################################
# -- Section IIId
# -- NO NEED TO MODIFY ANYTHING IN THIS SECTION
#
XA_DLL_DEFS  = $(XA_DLL_DEF) -DXA_DLL_PATH=\"$(XA_DLL_PATH)\"
XA_ZLIB_DEFS = $(XA_ZLIB_DEF) $(XA_ZLIB_INCS)
XA_ZLIB_LIBS = $(XA_ZLIB_LDIR) $(XA_ZLIB_LIB)

XA_VID_DEFS = $(XA_IV32_DEF) $(XA_CVID_DEF) $(XA_CYUV_DEF) \
		$(XA_DLL_DEFS) $(XA_ZLIB_DEFS)
XA_VID_LIBS = $(XA_IV32_LIB) $(XA_CVID_LIB) $(XA_CYUV_LIB) \
		$(XA_DLL_LIB) $(XA_ZLIB_LIBS)	\
		$(XA_SGI1)
XA_VID_DEPS = $(XA_IV32_LIB) $(XA_CVID_LIB) $(XA_CYUV_LIB)
#
###
XA_AUD_DEFS = -DXA_GSM
XA_AUD_LIBS =
XA_AUD_DEPS =
XA_AUD_CFILES = xa_gsm.c
XA_AUD_OFILES = xa_gsm.o
###
XA_MOD_DEFS = $(XA_VID_DEFS) $(XA_AUD_DEFS)
XA_MOD_LIBS = $(XA_VID_LIBS) $(XA_AUD_LIBS)
XA_MOD_DEPS = $(XA_VID_DEPS) $(XA_AUD_DEPS)
XA_MOD_CFILES = $(XA_AUD_CFILES)
XA_MOD_OFILES = $(XA_AUD_OFILES)
#

############################################################################
# -- Section IV.a
# -- X11/Openwindow Specific Defines
# 
# NOTE: The location of the X11 libs and includes are extremely variable, 
#       even across the same type of machines. Quite literally, they can
#       be put almost anywhere. Very annoying. What every happened to
#       /usr/lib/X11 and /usr/include/X11? Yeah, I know...
#
# IMPORTANT!! If you are using X11R6 see Section IV.b
############################################################################
# 
# -- X11 Includes directory
# --      You need to find out what directory the X11 includes are located
# --      in on your  machine and then include that directory AND the 
# --      directory above it in the INCLUDE define(prefixed by -I).
# --      You can look for the file "Xlib.h"
# --	  Here's some typical directories:
# --              /usr/include/X11
# --              /usr/include/X11R5
# --              /usr/X11R5/include/X11
# --              /usr/local/X11R5/include/X11
# --              /X11R5/include/X11
# --              /sapphire/tmp/test/X11R6/include/X11
#
# -- X11 Library directory
# --      You need to find out what directory the X11 libraries are located
# --      in on your  machine and then include that directory in the
# --      XLIBDIR define(prefixed by -L).  
# --      You can look for the files "libX11.*" (ie libX11.a, libX11.so, etc)
# --	  Here's some typical directories:
# --              /usr/lib/X11
# --              /usr/lib/X115
# --              /usr/X115/lib/X11
# --              /usr/local/X115/lib/X11
# --              /X115/lib/X11
#
# -- Are you running X11R6???
#	Then you need to uncomment XA_X11R6_LIBS below:
# XA_X11R6_LIBS = -lSM -lICE
#
#
###-- SunOS/Solaris running Openwindows(You should look into getting X11)
# INCLUDE = -I/usr/openwin/include -I/usr/openwin/include/X11
# XLIBDIR = -L/usr/openwin/lib
#
###-- Linux using X11R6
INCLUDE =  -I/usr/X11R6/include -I/usr/X11R6/include/X11
XLIBDIR = -L/usr/X11R6/lib
#
###-- My SunOS machine running X11R5
# INCLUDE = -I/usr/X11R5/include -I/usr/X11R5/include/X11
# XLIBDIR = -L/usr/X11R5/lib  -lnsl
#
###-- My SunOS machine running X11R6
# INCLUDE = -I/usr/X11R6/include -I/usr/X11R6/include/X11
# XLIBDIR = -L/usr/X11R6/lib  -lnsl
#
###-- Win32 
#-- This depends on where you installed the Cygnus X11 includes and libs.
#-- IMPORTANT: See all NOTE_9's further down in the Makefile.
# INCLUDE = -I/cygnus/b19/x11r6.4/include -I/cygnus/b19/x11r6.4/include/X11
# XLIBDIR = -L/cygnus/b19/x11r6.4/lib
#
# TODO: add more machine/OS specific examples here. Feel free to send
# in suggestions.
#



############################################################################
# -- Section IV.b
# -- If you are running X11R6, then you also need to uncomment 
# -- this define.
############################################################################
XA_X11R6_LIBS = -lSM -lICE
#


############################################################################
# -- Section VI
# -- Audio Defines
#
# NOTE: If your machine doesn't have audio OR isn't supported yet then
#       comment out ALL of the XA_AUDIO_* defines and you can still compile
#       XAnim for just video.  Setting the XA_AUDIO_* to nothing has the
#       same affect.
#
# NOTE: Some machines will have to add -DXA_SELECT to the XA_AUDIO_DEFS.
#       let me know if you find this to be the case.
############################################################################
#
# -- You don't have OR don't want Audio support -------------------------------
# -- NOTE_9 Since xanim doesn't yet support Win32 audio, this is necessary.
#XA_AUDIO_DEFS =
#
### -- Linux PCs --------------------------------------------------------------
XA_AUDIO_DEFS = -DXA_LINUX_AUDIO
XA_AUDIO_LIBS = -lc
#
# -- Linux PC's with OLD Rev sound drivers ------------------------------------
#XA_AUDIO_DEFS = -DXA_LINUX_AUDIO -DXA_LINUX_OLDER_SND
#XA_AUDIO_LIBS = -lc
#
# -- Sparc SunOS 4.1.x --------------------------------------------------------
# XA_AUDIO_DEFS = -DXA_SPARC_AUDIO
# 
# -- Sparc Solaris/SunOS 5.x --------------------------------------------------
# XA_AUDIO_DEFS = -DXA_SPARC_AUDIO -DSVR4 -DXA_SELECT
#
# -- S/6000 - AIX 4.1 (3.2.5??) -----------------------------------------------
# XA_AUDIO_DEFS = -DXA_AIX_AUDIO -DXA_SELECT
#
# -- SGI Irix------------------------------------------------------------------
# XA_AUDIO_DEFS = -DXA_SGI_AUDIO -DSYSV -DSVR4
# XA_AUDIO_LIBS = -laudio
#
# -- DEC Multimedia Services Support ------------------------------------------
# XA_AUDIO_DEFS = -DXA_MMS_AUDIO
# XA_AUDIO_LIBS = -lmme
#
# -- DEC Multimedia Services Support With Volume Control-----------------------
# XA_AUDIO_DEFS = -DXA_MMS_AUDIO -DMMS_VOL
# XA_AUDIO_LIBS = -lmme
#
# -- DEC Multimedia Services Support --------------------------------------
# --   This might be necessary for Digital Unix 3.2C and MME 1.60 DK
# XA_AUDIO_DEFS = -DXA_MMS_AUDIO -DXA_MMS_160 -DDEC
# XA_AUDIO_LIBS = -lmme
#
# -- NEC EWS Workstations -----------------------------------------------------
# XA_AUDIO_DEFS = -DXA_EWS_AUDIO
#
# -- SONY Workstations NEWS-5000 NEWS-OS 4.2 ----------------------------------
# XA_AUDIO_DEFS = -DXA_SONY_AUDIO
#
# -- NetBSD-current (as of 30/April 1995)--------------------------------------
# XA_AUDIO_DEFS = -DXA_NetBSD_AUDIO
#
# -- QNX 4.2 PC's -------------------------------------------------------------
# XA_AUDIO_DEFS = -DXA_LINUX_AUDIO -DXA_SELECT
# XA_AUDIO_LIBS = -lc
# 
# -- Also FreeBSD, and BSDI with SBlast-BSD-1.5 (development stages)-----------
# XA_AUDIO_DEFS = -DXA_LINUX_AUDIO
# XA_AUDIO_LIBS = -lc
#
# -- TOWNS Linux 16 bit PCM -----------------------------------------------
# XA_AUDIO_DEFS = -DXA_TOWNS_AUDIO
# XA_MACH_LIBS = -lc
#
# -- TOWNS Linux 8 bit PCM -----------------------------------------------
# XA_AUDIO_DEFS = -DXA_TOWNS8_AUDIO
# XA_MACH_LIBS = -lc
#
# -- HP 9000/700 Direct access to Audio Device---------------------------------
# -- This is a direct access to the HP's audio device and works much smoother
# -- than going through the Aserver(which has some serious problems).
# -- NOTE: You need to kill AServer before using this audio device since
# --       AServer will otherwise prevent xanim from opening it.
# XA_AUDIO_DEFS = -DXA_HPDEV_AUDIO 
# XA_AUDIO_LIBS = 
#
# -- HP 9000/700 AServer audio layers -----------------------------------------
# -- This isn't well developed yet(haven't had enough time on an HP yet).
# -- Plus AServer is currently *NOT* adequate for syncing audio and video.
# -- It adds too much of a delay in the processing of audio and so
# -- I don't recommend using it. But if you insist, consider yourself 
# -- forewarned.
# --
# -- HP/UX 9.x AServer
# XA_AUDIO_DEFS = -DXA_HP_AUDIO
# XA_AUDIO_LIBS = -lAlib
# --
# -- HP/UX 10.x AServer
# XA_AUDIO_DEFS = -DXA_HP_AUDIO -DXA_HP10
# XA_AUDIO_LIBS = -L/opt/audio/lib -lAlib
# XA_AUDIO_INCS = -I/opt/audio/include
#
# ------ AF (AudioFile) Support -----------------------------------------------
# -- You need to indicate where the AF libraries libAFUtil.a and libAF.a
# -- are located. Typically this is /usr/local/lib, but not always. Talk
# -- to the person who installed them on your machine to find out where
# -- they were put.  Same with the AF/include directory.
#
# -- NOTE: SOME VENDORS have an a library called AudioFile, AFile or AF
# -- that has to do with audio file formats and is NOT the same thing as
# -- AudioFile above. Again, talk to the person who installed AudioFile
# -- on your system. Otherwise, assume you don't have it.
#
# XA_AUDIO_DEFS = -DXA_AF_AUDIO
# XA_AUDIO_LIBS = -L/usr/local/lib -lAFUtil -lAF
# XA_AUDIO_INCS = -I/usr/local/include
#
# ------ NAS (Network Audio System) Support -----------------------------------
# -- You need to indicate where the NAS library libaudio.a is located.
# -- Typically this is /usr/local/lib, but not always.  Talk to the
# -- person who installed them on your machine to find out where they
# -- were put. Otherwise, assume you don't have NAS installed.
# -- Same with the /usr/local/include/audio directory.
#
# XA_AUDIO_DEFS = -DXA_NAS_AUDIO
# XA_AUDIO_LIBS = -L/usr/local/lib/audio -laudio
# XA_AUDIO_INCS = -I/usr/local/include/audio
#
# NOTE: /pain/audio is just where I keep all my audio stuff and is
# just here for my convenience. (pain because the disk died once already :)
# XA_AUDIO_DEFS = -DXA_NAS_AUDIO
# XA_AUDIO_LIBS = -L/pain/audio/nas/lib/audio -laudio
# XA_AUDIO_INCS = -I/pain/audio/nas/usr/include
#
############

############################################################################
# -- Section VII
# Machine Specific Defines and Libs
############################################################################
#
# -- Sun Sparc running SunOS 4.x and OpenWindows ------------------------------
# See  NOTE_5  below(alternative XLIBS define).
#
# -- Some Revs of Sun Solaris Machines need the following ---------------------
# XA_MACH_LIBS = -lsocket -lnsl -lgen
#
# -- Unisys SVR4 machines based on Intel arch.
# See NOTE_7 below(alternative XLIBS define)
#
# -- HP machines --------------------------------------------------------------
# -- NEED this to increase the macro symbol table(default is 128000).
# XA_MACH_DEFS = -Wp,-H150000
#
# -- PC DOS Machines running Quarterdeck's DESQview X--------------------------
# XA_MACH_DEFS  = -DMSDOS
#
# -- i486 box Interactive UNIX V2.2.1 -----------------------------------------
# -- might need to uncomment out the define below:
# XA_MACH_LIBS = -linet
#
# -- IBM AIX ------------------------------------------------------------------
# These machines don't have the X11 Shared memory extension.
# See  NOTE_6 below(comment out the XA_SHARED define).
#
#
# ---- Misc Defines for various machines -----------------------------------
#
#   -- NO_INSTALL_CMAP prevents XAnim from specifically installing a cmap.
#   --  this causes problems on some PC versions of X11
# XA_CMAP = -DNO_INSTALL_CMAP
# 
#   -- XA_XTPOINTER typedefs XtPointer as void*  if your system doesn't
#   -- typedef it already. (X11R4 or below might need this)
# XA_XTPTR = -DXA_XTPOINTER
#  
#   -- X11 Shared Memory
#   -- Allow use of shared memory if specified on cmd line. Comment this out
#   -- if get compiler errors about not finding XShm.h or the following
#   -- symbols(XShmCreateImage,XShmAttach,XShmDetach,XShmPutImage,etc).
#   -- NOTE_6: IBM AIX machines need to comment this out UNLESS YOU HAVE
#   --         SPECIFICALLY installed the Xshm extension on your AIX machine.
#   -- NOTE_9: WIN32 machines need to comment this out.
XA_SHARED = -DXSHM
#
#   -- X11 Multiple Buffers  (may or may not help with large images)
#   -- Allow use of hardware/software double buffering in the server, if
#   -- specified on cmd line. Comment this out if you get compiler errors
#   -- about not finding multibuf.h or the
#   -- following symbols(XmbufDisplayBuffers, XmbufQueryExtension,
#   --  XmbufCreateBuffers).
#   -- NOTE_8: HP-UX machines need to comment this out.
# XA_MULTIBUF = -DXMBUF
#
############
#
############################################################################
# END OF SECTIONS - No need to look below unless a NOTE told you to.
############################################################################
#
XA_MISC_DEFS = $(XA_CMAP) $(XA_XTPTR) $(XA_SHARED) $(XA_MULTIBUF) $(XA_MACH_DEFS)
#
#####################################
#  FINAL CFLAGS and OTHER_LIBS
#

XA_DEFS = $(XA_MISC_DEFS) $(XA_MOD_DEFS) $(XA_AUDIO_DEFS) -DXA_PETUNIA -DXA_KPCD -DXA_EXPORT -DXA_EXPORT_QT
XA_LIBS = $(XA_X11R6_LIBS) $(XA_MACH_LIBS) $(XA_MOD_LIBS) $(XA_AUDIO_LIBS) -lpthread quicktime/quicktime/libquicktime.a -ljpeg -lpng -lz
XA_INCS = $(INCLUDE) $(XA_VIDEO_INCS) $(XA_AUDIO_INCS) -Iquicktime/quicktime
CFLAGS	=  $(DEBUG) $(OPTIMIZE)

#####################################
# FINAL LIBS
#
XLIBS	= $(XA_LIBS) -lXext -lXt -lX11 -lm -lc
#
# NOTE_5: If you are using OpenWindows with SunOS4.1.3 then use the following:
#XLIBS  = $(XA_LIBS) -lXext -lXt -lX11 -lm -lXext
#
# NOTE_7: If you are using Unisys SVR4 then use the following:
#XLIBS = $(XA_LIBS) -lXext -lXt -lX11 -lm -lc -lnsl  -lsocket -lgen -L/usr/ucblib -lucb
#
# NOTE_9: If you are using CYG-WIN32 then use the following:
#XLIBS = -lXext -lXt -lX11 -lm $(XA_LIBS)


# xa_pfx.c TEMP REMOVED
CFILES = xanim.c xa_show.c xa_x11.c xa_fli.c xa_iff.c  \
	xa_gif.c xa_txt.c unpacker.c xa_utils.c xa_act.c \
	xa_set.c xa_cmap.c xa_rle.c xa_wav.c xa_au.c xa_8svx.c \
	xa_avi.c xa_qt.c xa_qt_decs.c xa_audio.c xa_ipc.c xa_color.c \
	xa_jpg.c xa_mpg.c xa_dl.c xa_jmov.c xa_movi.c xa_raw.c \
	xa_replay.c xa_j6i.c xa_g72x.c xa_g721.c	\
	xa_dumfx.c xa_acodec.c xa_input.c xa_formats.c \
	xa_vid_codec.c \
	xa1.0_kpcd.c	\
	$(XA_MOD_CFILES)


OFILES = xanim.o xa_show.o xa_x11.o xa_fli.o xa_iff.o  \
	xa_gif.o xa_txt.o unpacker.o xa_utils.o xa_act.o \
	xa_set.o xa_cmap.o xa_rle.o xa_wav.o xa_au.o xa_8svx.o \
	xa_avi.o xa_qt.o xa_qt_decs.o xa_audio.o xa_ipc.o xa_color.o \
	xa_jpg.o xa_mpg.o xa_dl.o xa_jmov.o xa_movi.o xa_raw.o \
	xa_replay.o xa_j6i.o xa_g72x.o xa_g721.o	\
	xa_dumfx.o xa_acodec.o xa_input.o xa_formats.o \
	xa_vid_codec.o \
	xa1.0_kpcd.o	xa_export.o xa_export_ppm.o xa_export_jpg.o	\
	$(XA_MOD_OFILES)

xanim: $(OFILES) $(XA_MOD_DEPS)
	$(LD) $(LD_FLAGS) -o $(XANIM) $(OFILES) $(XLIBDIR) $(XLIBS)

.c.o:
	$(CC) -I. $(CFLAGS) $(XA_DEFS) $(XA_INCS) -c $*.c

clean:
	rm -f $(OFILES) core

xaclean:
	rm -f $(OFILES) core

txtmerge:	
	$(CC) $(CFLAGS) -o txtmerge txtmerge.c


# DO NOT DELETE THIS LINE
xanim.o:  xanim.h xa_config.h xa_x11.h xanim.c
xa1.0_kpcd.o: xa1.0_kpcd.c
unpacker.o: unpacker.c
xa_acodec.o:  xanim.h xa_acodec.c
xa_act.o: xanim.h xa_config.h xa_act.c
xa_au.o: xanim.h xa_config.h xa_au.c
xa_audio.o:  xanim.h xa_config.h xa_audio.h xa_audio.c
xa_avi.o:  xanim.h xa_config.h xa_avi.h xa_codecs.h xa_xmpg.h xa_avi.c
xa_cmap.o: xanim.h xa_config.h xa_cmap.c
xa_color.o: xanim.h xa_color.c
xa_dl.o: xanim.h xa_config.h xa_dl.h xa_dl.c
xa_dumfx.o: xanim.h xa_dumfx.c
xa_fli.o: xanim.h xa_config.h xa_fli.h xa_fli.c
xa_formats.o: xanim.h xa_formats.c
xa_gif.o: xanim.h xa_config.h xa_gif.h xa_gif.c
xa_iff.o: xanim.h xa_config.h xa_iff.h xa_iff.c
xa_input.o: xanim.h xa_input.c
xa_ipc.o:  xanim.h xa_config.h xa_ipc.h xa_ipc.c
xa_jmov.o: xanim.h xa_config.h xa_jmov.h xa_jmov.c
xa_jpg.o: xanim.h xa_config.h xa_jpg.h xa_jpg.c
xa_j6i.o: xanim.h xa_j6i.h xa_j6i.c
xa_movi.o: xanim.h xa_config.h xa_movi.h xa_movi.c
xa_mpg.o: xanim.h xa_config.h xa_mpg.h xa_xmpg.h xa_mpg.c xa_jpg.c
xa_qt.o:  xanim.h xa_config.h xa_qt.h xa_codecs.h xa_qt.c
xa_qt_decs.o:  xanim.h xa_config.h xa_qt.h xa_qt_decs.c
xa_vid_codec.o:  xa_avi.h xa_qt.h xa_codecs.h xavid.h xavid_mod.h
xa_vid_codec.o: xa_vid_codec.c
xa_replay.o: xanim.h xa_config.h xa_replay.h xa_replay.c
xa_rle.o: xanim.h xa_config.h xa_rle.h xa_rle.c
xa_set.o: xanim.h xa_config.h xa_iff.h xa_iff.c xa_set.h xa_set.c
xa_raw.o: xanim.h xa_raw.h xa_raw.c
xa_show.o:  xanim.h xa_show.c
xa_txt.o: xanim.h xa_config.h xa_txt.c
xa_utils.o: xanim.h xa_config.h xa_utils.c
xa_wav.o: xanim.h xa_config.h xa_avi.h xa_wav.c
xa_8svx.o: xanim.h xa_8svx.h xa_8svx.c
xa_x11.o:  xanim.h xa_config.h xa_x11.h xa_x11.c
xa_gsm.o: xanim.h xa_gsm_state.h xa_gsm.h xa_gsm.c

