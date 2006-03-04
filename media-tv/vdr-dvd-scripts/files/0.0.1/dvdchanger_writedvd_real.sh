#!/bin/sh
#
# source: http://www.hoochvdr.info
#
# $1 = filename of the iso file
#
# 04 Mar 2006; Joerg Bornkessel <hd_brummy@gentoo.org>
# addaptded to gentoo-vdr-scripts

[[ -e /etc/conf.d/vdr.cd-dvd ]] && source /etc/conf.d/vdr.cd-dvd

: ${VDR_DVDWRITER:=/dev/dvd}

DVD_RECORDCMD="growisofs"
DVDPLUS_RECORD_OPTS="-dvd-compat -Z"

unset SUDO_COMMAND
svdrpsend.pl -d localhost "MESG DVD burn initiated"
$DVD_RECORDCMD $DVDPLUS_RECORD_OPTS $VDR_DVDWRITER=$1
svdrpsend.pl -d localhost "MESG DVD burn completed"
