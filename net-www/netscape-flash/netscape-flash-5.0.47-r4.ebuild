# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-flash/netscape-flash-5.0.47-r4.ebuild,v 1.2 2002/04/27 23:34:20 bangert Exp $

S=${WORKDIR}/flash_linux
DESCRIPTION="Macromedia Shockwave Flash Player"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/${P}.tar.gz"
HOMEPAGE="http://www.macromedia.com"

src_install() {                               
  cd ${S}
  exeinto /opt/netscape/plugins
  insinto /opt/netscape/plugins
  doexe libflashplayer.so
  doins ShockwaveFlash.class
  dodoc README ReadMe.htm
  
  if [ "`use mozilla`" ] ; then
    dodir /usr/lib/mozilla/plugins
    dosym /opt/netscape/plugins/libflashplayer.so \
          /usr/lib/mozilla/plugins/libflashplayer.so 
    dosym /opt/netscape/plugins/ShockwaveFlash.class \
          /usr/lib/mozilla/plugins/ShockwaveFlash.class 
  fi
}
