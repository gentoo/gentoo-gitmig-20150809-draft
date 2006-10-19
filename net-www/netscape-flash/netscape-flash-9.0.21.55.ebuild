# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-flash/netscape-flash-9.0.21.55.ebuild,v 1.1 2006/10/19 00:58:48 tester Exp $

inherit nsplugins

myPV=101806

S=${WORKDIR}/flash-player-plugin-${PV}/
DESCRIPTION="Adobe Flash Player"
SRC_URI="http://download.macromedia.com/pub/labs/flashplayer9_update/FP9_plugin_beta_${myPV}.tar.gz"
HOMEPAGE="http://www.adobe.com/"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 -ppc -sparc ~x86"
LICENSE="Macromedia"

DEPEND="!net-www/gplflash
	amd64? ( app-emulation/emul-linux-x86-baselibs
			app-emulation/emul-linux-x86-gtklibs
			 app-emulation/emul-linux-x86-xlibs )
	x86? ( x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXt
		=x11-libs/gtk+-2*
		media-libs/freetype
		media-libs/fontconfig )"

RESTRICT="nostrip"

#QA_TEXTRELS="opt/netscape/plugins/libflashplayer.so"

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
	has_multilib_profile && ABI="x86"
}

src_install() {
	exeinto /opt/netscape/plugins
	doexe libflashplayer.so

	inst_plugin /opt/netscape/plugins/libflashplayer.so

	dodoc readme.txt
}
