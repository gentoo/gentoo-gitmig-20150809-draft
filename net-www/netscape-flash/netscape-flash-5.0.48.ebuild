# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-flash/netscape-flash-5.0.48.ebuild,v 1.3 2002/07/14 20:25:23 aliz Exp $

S=${WORKDIR}/flash_linux
DESCRIPTION="Macromedia Shockwave Flash Player"
SRC_URI="http://www.ibiblio.org/gentoo/distfiles/${P}.tar.gz"
HOMEPAGE="http://www.macromedia.com"
SLOT="0"
KEYWORDS="x86"

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
