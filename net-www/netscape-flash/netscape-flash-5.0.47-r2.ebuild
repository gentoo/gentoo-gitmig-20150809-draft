# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-flash/netscape-flash-5.0.47-r2.ebuild,v 1.2 2001/12/07 21:14:22 drobbins Exp $

S=${WORKDIR}/flash_linux
DESCRIPTION="Macromedia Shockwave Flash Player"
MANUAL_SRC_URI="http://download.macromedia.com/pub/shockwave/flash/english/linux/5.0r47/flash_linux.tar.gz"
HOMEPAGE="http://www.macromedia.com"

dyn_fetch() {
	[ ! -e ${DISTDIR}/flash_linux.tar.gz ] && failed_digest
}

failed_digest() {
	einfo "Please download this manually into ${DISTDIR}"
	einfo "`echo ${MANUAL_SRC_URI}`"
	exit 1 
}

src_install() {                               
  dodir /opt/netscape/plugins
  exeinto /opt/netscape/plugins
  doexe ShockwaveFlash.class libflashplayer.so
  dodoc README
  
  if [ "`use mozilla`" ] ; then
  	dodir /usr/lib/mozilla/plugins
  	dosym /opt/netscape/plugins/libflashplayer.so \
		/usr/lib/mozilla/plugins/libflashplayer.so 
  	dosym /opt/netscape/plugins/ShockwaveFlash.class \
		/usr/lib/mozilla/plugins/ShockwaveFlash.class 
  fi
}
