# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-flash/netscape-flash-6.0b.ebuild,v 1.1 2002/10/21 17:27:15 vapier Exp $

S=${WORKDIR}/flashplayer_installer
DESCRIPTION="Macromedia Shockwave Flash Player"
SRC_URI="http://www.macromedia.com/software/flashplayer/special/beta/installers/linux/plugin/install_flash_player_6_linux.tar.gz"
HOMEPAGE="http://www.macromedia.com/"

SLOT="0"
KEYWORDS="x86 -ppc sparc sparc64"
LICENSE="Macromedia"

src_install() {                               
	exeinto /opt/netscape/plugins
	insinto /opt/netscape/plugins
	doexe libflashplayer.so
	doins flashplayer.xpt

	if [ "`use mozilla`" ] ; then
		dodir /usr/lib/mozilla/plugins
		dosym /opt/netscape/plugins/libflashplayer.so \
			/usr/lib/mozilla/plugins/libflashplayer.so 
		dosym /opt/netscape/plugins/flashplayer.xpt \
			/usr/lib/mozilla/plugins/flashplayer.xpt
	fi
}
