####################################################################
#         Copyright 1999-2004 Gentoo Technologies, Inc.            #
# Distributed under the terms of the GNU General Public License v2 #
####################################################################
#
# p	do not enforce paging based non-executable pages
# e	do not emulate trampolines
# r	do not randomize mmap() base [ELF only]
# m	do not restrict mprotect()
# s	do not enforce segmentation based non-executable pages
# x	do not randomize ET_EXEC base [ELF only]
# z	zero flag mask

JAVA=/opt/blackdown-jdk-*/jre/{java,java_vm,keytool,kinit,klist,ktab,orbd,policytool,rmid,rmiregistry,servertool,tnameserv}
WINE=/usr/lib/wine/bin/wine/{wine,winebuild,wineclipsrv,winedump,winegcc,wineserver,winewrap}

# most things that need pageexec need segmexec and or vice versa so we set both.
PAGEEXEC_EXEMPT="/usr/X11R6/bin/XFree86 /usr/bin/xmms /usr/bin/mplayer /opt/OpenOffice*/program/soffice.bin \
 /usr/bin/blender /usr/bin/gxine /usr/bin/totem /usr/bin/acme $JAVA $WINE"

TRAMPOLINE_EXEMPT=""
MPROTECT_EXEMPT=""
RANDMMAP_EXEMPT=""
SEGMEXEC_EXEMPT="${PAGEEXEC_EXEMPT}"
RANDEXEC_EXEMPT="${JAVA}"

# when zero flag mask is set to "yes" it will remove all pax flags from all files on reboot/stop
ZERO_FLAG_MASK=yes
