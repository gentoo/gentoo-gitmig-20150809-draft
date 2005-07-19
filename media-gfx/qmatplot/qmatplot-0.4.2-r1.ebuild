# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qmatplot/qmatplot-0.4.2-r1.ebuild,v 1.5 2005/07/19 11:30:40 dholm Exp $

inherit eutils

DESCRIPTION="gnuplot-like tool for plotting data sets in either two or three dimensions"
HOMEPAGE="http://qmatplot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""
SLOT="0"

DEPEND="=x11-libs/qt-3*
	>=sci-mathematics/octave-2.1
	>=sci-mathematics/scilab-2.6"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${P}-gcc34.patch
}

src_compile() {
	addwrite "${QTDIR}/etc/settings"
	econf || die "configure failed"
	emake QSETTINGSDIR="${QTDIR}/etc/settings/" || die "make failed"
}

src_install() {
	make QSETTINGSDIR="${D}/${QTDIR}/etc/settings/" DESTDIR="${D}" install || die "install failed"
	dodoc ChangeLog AUTHORS
}
