#!/bin/sh
#
# $Header: /var/cvsroot/gentoo-x86/media-tv/vdr-dvd-scripts/files/0.0.1/dvdchanger_writedvd_real.sh,v 1.2 2006/04/03 18:46:25 hd_brummy Exp $
#
# 04 Mar 2006; Joerg Bornkessel <hd_brummy@gentoo.org>
# addaptded to gentoo-vdr-scripts

[[ -e /etc/conf.d/vdr.cd-dvd ]] && source /etc/conf.d/vdr.cd-dvd

ISO_FILE=`echo ${@} | sed 's:\ IMAGE::g'`

#logger -t burnscript burn ${ISO_FILE} --

: ${VDR_DVDWRITER:=/dev/dvd}

DVD_RECORDCMD="growisofs"
DVDPLUS_RECORD_OPTS="-use-the-force-luke=tty -dvd-compat -Z"

unset SUDO_COMMAND
svdrpsend.pl -d localhost "MESG DVD burn initiated"
$DVD_RECORDCMD $DVDPLUS_RECORD_OPTS $VDR_DVDWRITER="${ISO_FILE}"
svdrpsend.pl -d localhost "MESG DVD burn completed"
