# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/pstplus/pstplus-1.2.ebuild,v 1.1 2008/01/26 13:40:51 aballier Exp $

inherit eutils qt4

DESCRIPTION="A PSTricks GUI"
HOMEPAGE="http://www.xm1math.net/pstplus/"
SRC_URI="http://www.xm1math.net/pstplus/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="$(qt4_min_version 4.3)"

RDEPEND="${DEPEND}
	virtual/latex-base
	|| (
		dev-texlive/texlive-pstricks
		app-text/tetex
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
