# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/nomad-tool/nomad-tool-1.3-r1.ebuild,v 1.2 2004/03/24 17:44:26 eradicator Exp $

GUI_V=0.5.5

DESCRIPTION="Controls the Nomad II MG and IIc portable MP3 players"
HOMEPAGE="http://www.swiss.ai.mit.edu/~cph/nomad.php"
SRC_URI="http://www.swiss.ai.mit.edu/~cph/nomad/${P}.tar.gz
	http://www.its.caltech.edu/~georges/gentoo/proj/nomad-gui/nomad-gui-${GUI_V}.py.bz2"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"
IUSE="tcltk"

DEPEND=""


src_compile() {
	cd ${WORKDIR}
	make PREFIX="/usr" || die "compile failed"
}

src_install() {
	cd ${WORKDIR}
	dobin nomad-tool
	dolib nomad-open
	chmod 4755 ${D}/usr/lib/nomad-open

	doman nomad-tool.1
	dodoc ChangeLog COPYING README

	#optional gui interface, needs python with tkinter
	use tcltk && (
		mv nomad-gui-${GUI_V}.py nomad-gui.py
		dobin nomad-gui.py
	)
}
