# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-flash/netscape-flash-5.0.47-r1.ebuild,v 1.1 2001/10/23 15:17:04 karltk Exp $

A=flash_linux.tar.gz
S=${WORKDIR}/Linux
DESCRIPTION="Macromedia Shockwave Flash Player"
SRC_URI="http://download.macromedia.com/pub/shockwave/flash/english/linux/5.0r47/flash_linux.tar.gz"
HOMEPAGE="http://macromedia.com"

src_install() {                               
  dodir /opt/netscape/plugins
  exeinto /opt/netscape/plugins
  doexe ShockwaveFlash.class libflashplayer.so
  dodoc README.Linux
  
  if [ "`use mozilla`" ] ; then
  	dodir /usr/lib/mozilla/plugins
  	dosym /opt/netscape/plugins/libflashplayer.so /usr/lib/mozilla/plugins/libflashplayer.so 
  	dosym /opt/netscape/plugins/ShockwaveFlash.class /usr/lib/mozilla/plugins/ShockwaveFlash.class 
  fi
}
