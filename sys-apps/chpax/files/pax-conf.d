####################################################################
#         Copyright 1999-2004 Gentoo Technologies, Inc.            #
# Distributed under the terms of the GNU General Public License v2 #
####################################################################
# chpax	prefix	description
# p	PE	do not enforce paging based non-executable pages
# E	ET	emulate trampolines
# r	RE	do not randomize mmap() base [ELF only]
# m	ME	do not restrict mprotect()
# s	SE	do not enforce segmentation based non-executable pages
# x	XE	do not randomize ET_EXEC base [ELF only]

CHPAX=/sbin/chpax
#CHPAX=/sbin/paxctl

PE_wine=/usr/lib/wine/bin/{wine{,build,clipsrv,dump,gcc,server,wrap,-{k,p}thread},w{mc,rc,idl}}
PE_blkdwn_java=/opt/blackdown-{jdk-*/{,jre/},jre-*/}bin/{java{_vm},keytool,kinit,klist,ktab,orbd,policytool,rmi{d,registry},servertool,tnameserv}
PE_openoffice=/opt/OpenOffice.org*/program/soffice.bin

PE_misc="/usr/X11R6/bin/XFree86 /usr/bin/xmms /usr/bin/mplayer /usr/bin/blender \
	/usr/bin/gxine /usr/bin/xine /usr/bin/totem /usr/bin/acme \
	/usr/bin/xfce4-panel /usr/bin/gnome-sound-recorder /usr/games/bin/bzflag"

RE_blkdwn_java="${PE_blkdwn_java}"
RE_wine="${PE_wine}"
ME_blkdwn_java="${PE_blkdwn_java}"
XE_blkdwn_java="${PE_blkdwn_java}"
XE_wine="${RE_wine}"

####################################
# Settings are really applied here #
####################################

PAGEEXEC_EXEMPT="${PE_misc} ${PE_wine} ${PE_blkdwn_java} ${PE_gnome} ${PE_openoffice}"
TRAMPOLINE_EXEMPT=""
MPROTECT_EXEMPT="${ME_blkdwn_java}"
RANDMMAP_EXEMPT="${RE_wine}"
SEGMEXEC_EXEMPT="${PAGEEXEC_EXEMPT}"
RANDEXEC_EXEMPT="${XE_blkdwn_java} ${XE_wine}"

# when zero flag mask is set to "yes" it will remove all pax flags from all files on reboot/stop
ZERO_FLAG_MASK=no
