####################################################################
#            Copyright 1999-2004 Gentoo Foundation                 #
# Distributed under the terms of the GNU General Public License v2 #
###################################################################
# chpax	prefix	description
# p	PE	do not enforce paging based non-executable pages
# E	ET	emulate trampolines
# r	RE	do not randomize mmap() base [ELF only]
# m	ME	do not restrict mprotect()
# s	SE	do not enforce segmentation based non-executable pages
# x	XE	do not randomize ET_EXEC base [ELF only]
# psem	PSE	same as PE + SE + ME, or -psem

# NOTE:  PS_EXEC_EXEMPT is {PAGE,SEGM}_EXEC_EXEMPT.  For executables
# with BOTH, you should use this, as it enables -e and -m, to make
# sure that pax doesn't cry about odd flag settings in softmode

# chpax command.  If using multiple tools, can separate by spaces.
# This one hits BOTH chpax and paxctl
CHPAX="/sbin/chpax /sbin/paxctl"

# yes to be annoyed
#VERBOSE="yes"

#########################################################################
# Here's some basic apps we'll use, that we have to apply much stuff to #
########################################################################

# I'm debating if I should do the eval here or in the actual script; I'm
# currently opting for doing it in the init.d script.
#
# To do it here, set things ="`eval echo /path/to/{some,binaries}`"

#java=/opt/blackdown-{jdk-*/{,jre/},jre-*/}bin/{java{,_vm,c},keytool,kinit,klist,ktab,orbd,policytool,rmi{d,registry},servertool,tnameserv,*}
java="/opt/*-{jdk-*/{,jre/},jre-*/}bin/*"
wine="/usr/lib/wine/bin/{wine{,build,clipsrv,dump,gcc,server,wrap,-{k,p}thread},w{mc,rc,idl}}"
x11="/usr/X11R6/bin/{XFree86,Xorg}"
xine="/usr/bin/{g,}xine"
openoffice="/opt/OpenOffice.org*/program/soffice.bin"
mozilla="/usr/lib/MozillaFirefox/firefox-bin /usr/lib/mozilla/mozilla-bin"
xmms="/usr/bin/xmms"
mplayer="/usr/bin/{g,}mplayer"

#####################################################
# Miscillaneous things that need each of these tags #
####################################################

PSE_misc="/usr/bin/blender /usr/bin/totem /usr/bin/acme \
 /usr/bin/gnome-sound-recorder /usr/games/bin/bzflag /usr/bin/xfce4-panel"

####################################
# Settings are really applied here #
###################################

PS_EXEC_EXEMPT="${PSE_misc} ${x11} ${xine} ${wine} ${java} ${openoffice} ${mplayer}"
PAGEEXEC_EXEMPT=""
TRAMPOLINE_EXEMPT=""
MPROTECT_EXEMPT="${java} ${mozilla} ${xmms}"
RANDMMAP_EXEMPT="${java} ${x11}"
SEGMEXEC_EXEMPT="${PAGEEXEC_EXEMPT}"
RANDEXEC_EXEMPT="${java} ${x11}"

# when zero flag mask is set to "yes" it will remove all pax flags from all files on reboot/stop
#ZERO_FLAG_MASK="yes"

