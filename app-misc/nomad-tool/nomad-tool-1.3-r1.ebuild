# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/nomad-tool/nomad-tool-1.3-r1.ebuild,v 1.8 2005/11/07 12:21:00 george Exp $

GUI_V=0.5.5

DESCRIPTION="Controls the Nomad II MG and IIc portable MP3 players"
HOMEPAGE="http://www.swiss.ai.mit.edu/~cph/nomad.ssp"
SRC_URI="http://www.swiss.ai.mit.edu/~cph/nomad/${P}.tar.gz
	http://www.its.caltech.edu/~georges/gentoo/proj/nomad-gui/nomad-gui-${GUI_V}.py.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE="tcltk"

DEPEND="=dev-libs/glib-1*"
RDEPEND="tcltk? ( dev-lang/python
				dev-lang/tcl )"

S=${WORKDIR}

src_compile() {
	make PREFIX="/usr" || die "compile failed"
}

src_install() {
	dobin nomad-tool
	dolib nomad-open
	chmod 4755 ${D}/usr/lib/nomad-open

	doman nomad-tool.1
	dodoc ChangeLog README

	#optional gui interface, needs python with tkinter
	use tcltk && (
		mv nomad-gui-${GUI_V}.py nomad-gui.py
		dobin nomad-gui.py
	)
}
