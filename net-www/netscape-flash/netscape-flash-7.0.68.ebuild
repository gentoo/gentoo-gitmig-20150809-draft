# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-flash/netscape-flash-7.0.68.ebuild,v 1.5 2007/01/31 10:41:54 armin76 Exp $

inherit nsplugins

S=${WORKDIR}/install_flash_player_7_linux
DESCRIPTION="Macromedia Shockwave Flash Player"
SRC_URI="mirror://macromedia/rpmsource/flash-plugin-${PV}.tar.gz"
HOMEPAGE="http://www.macromedia.com/"

IUSE=""
SLOT="0"
KEYWORDS="-* amd64 x86"
LICENSE="Macromedia"

DEPEND="amd64? ( app-emulation/emul-linux-x86-baselibs
			 app-emulation/emul-linux-x86-xlibs )"

RESTRICT="strip"

QA_TEXTRELS="opt/netscape/plugins/libflashplayer.so"

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

	dodoc Readme.txt
	dohtml Readme.htm
}
