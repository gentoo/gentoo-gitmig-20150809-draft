# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-flash/netscape-flash-5.0.48.ebuild,v 1.4 2002/07/17 01:40:22 seemant Exp $

S=${WORKDIR}/flash_linux
DESCRIPTION="Macromedia Shockwave Flash Player"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.macromedia.com"
SLOT="0"
KEYWORDS="x86"
LICENSE="Macromedia"

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
