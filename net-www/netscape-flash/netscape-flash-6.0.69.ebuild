# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-flash/netscape-flash-6.0.69.ebuild,v 1.1 2002/12/16 10:48:25 seemant Exp $

inherit nsplugins

IUSE=""

S=${WORKDIR}/install_flash_player_6_linux
DESCRIPTION="Macromedia Shockwave Flash Player"
SRC_URI="mirror://macromedia/${P}.tar.gz"
HOMEPAGE="http://www.macromedia.com/"

SLOT="0"
KEYWORDS="x86 -ppc -sparc"
LICENSE="Macromedia"

DEPEND="virtual/glibc"

src_install() {
	exeinto /opt/netscape/plugins
	doexe libflashplayer.so

	insinto /opt/netscape/plugins
	doins flashplayer.xpt

	inst_plugin /opt/netscape/plugins/libflashplayer.so
	inst_plugin /opt/netscape/plugins/flashplayer.xpt

	dodoc readme.txt
	dohtml ReadMe.htm
}
