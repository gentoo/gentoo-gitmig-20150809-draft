# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-flash/netscape-flash-9.0.21.78.ebuild,v 1.2 2007/01/17 20:14:24 antarus Exp $

inherit nsplugins

myPV=112006

S=${WORKDIR}/flash-player-plugin-${PV}/
SPLAYER=${WORKDIR}/flash-player-standalone-${PV}/
DESCRIPTION="Adobe Flash Player"
SRC_URI="http://download.macromedia.com/pub/labs/flashplayer9_update/FP9_plugin_beta_${myPV}.tar.gz
	http://download.macromedia.com/pub/labs/flashplayer9_update/FP9_standalone_beta_${myPV}.tar.gz"
HOMEPAGE="http://www.adobe.com/"

IUSE=""
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
LICENSE="Macromedia"

DEPEND="!net-www/gplflash
	amd64? ( app-emulation/emul-linux-x86-baselibs
			app-emulation/emul-linux-x86-gtklibs
			app-emulation/emul-linux-x86-soundlibs
			 app-emulation/emul-linux-x86-xlibs )
	x86? ( x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXt
		=x11-libs/gtk+-2*
		media-libs/freetype
		media-libs/fontconfig )"

RESTRICT="strip"

#QA_TEXTRELS="opt/netscape/plugins/libflashplayer.so"

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
	has_multilib_profile && ABI="x86"
}

src_install() {
	dobin ${SPLAYER}/gflashplayer

	exeinto /opt/netscape/plugins
	doexe libflashplayer.so

	inst_plugin /opt/netscape/plugins/libflashplayer.so

	dodoc readme.txt
}
