# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-flash/netscape-flash-6.0.69-r1.ebuild,v 1.1 2002/12/18 13:55:27 seemant Exp $

inherit nsplugins

IUSE="gtk"

S=${WORKDIR}/install_flash_player_6_linux
DESCRIPTION="Macromedia Shockwave Flash Player"
SRC_URI="mirror://macromedia/${P}.tar.gz
	gtk? mirror://macromedia/gflashplayer-${PV}.tar.gz"
HOMEPAGE="http://www.macromedia.com/"

SLOT="0"
KEYWORDS="~x86 -ppc -sparc"
LICENSE="Macromedia"

DEPEND=">=sys-libs/lib-compat-1.1
	gtk? ( =x11-libs/gtk+-1.2* )"

src_install() {
	exeinto /opt/netscape/plugins
	doexe libflashplayer.so

	insinto /opt/netscape/plugins
	doins flashplayer.xpt

	inst_plugin /opt/netscape/plugins/libflashplayer.so
	inst_plugin /opt/netscape/plugins/flashplayer.xpt

	dodoc readme.txt
	dohtml ReadMe.htm

	# Optionally install the standalone GTK flash player
	if use gtk
	then
		cd ${S}_sa
		docinto gflashplayer
		dodoc readme.txt
		dohtml ReadMe.htm
		dobin gflashplayer flashplayer-installer
	fi
}
