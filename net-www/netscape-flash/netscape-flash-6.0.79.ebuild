# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-flash/netscape-flash-6.0.79.ebuild,v 1.6 2005/08/11 20:25:42 flameeyes Exp $

inherit nsplugins

#until a new package of gflashplayer is released
OLD_V="6.0.69"

IUSE="gtk"

S=${WORKDIR}/install_flash_player_6_linux
DESCRIPTION="Macromedia Shockwave Flash Player"
SRC_URI="mirror://macromedia/${P}.tar.gz
	gtk? ( mirror://macromedia/gflashplayer-${OLD_V}.tar.gz )"
HOMEPAGE="http://www.macromedia.com/"

SLOT="0"
KEYWORDS="x86 -ppc -sparc"
LICENSE="Macromedia"

DEPEND="!net-www/gplflash
	>=sys-libs/lib-compat-1.1
	gtk? ( =x11-libs/gtk+-1.2* )"

RESTRICT="nostrip"

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
	has_multilib_profile && ABI="x86"
}

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
