# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/pstplus/pstplus-1.4.1.ebuild,v 1.2 2009/12/21 18:35:04 ssuominen Exp $

EAPI=1

inherit eutils qt4

DESCRIPTION="A PSTricks GUI"
HOMEPAGE="http://www.xm1math.net/pstplus/"
SRC_URI="http://www.xm1math.net/pstplus/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-core:4"
RDEPEND="${DEPEND}
	virtual/latex-base
	|| (
		dev-texlive/texlive-pstricks
		app-text/ptex
	)
	app-text/psutils
	sci-visualization/gnuplot
	virtual/ghostscript
	media-libs/netpbm"

src_compile() {
	eqmake4 pstplus.pro || die "qmake failed"
	emake || die "emake failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "make install failed"

	dodoc utilities/AUTHORS || die "dodoc failed"

	newicon utilities/pstplus48x48.png pstplus.png
	make_desktop_entry pstplus Pstplus "pstplus" Office
}

pkg_postinst() {
	elog "Examples are available at:"
	elog "/usr/share/${PN}/"
}
