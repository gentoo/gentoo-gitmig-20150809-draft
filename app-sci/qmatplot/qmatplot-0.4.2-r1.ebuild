# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/qmatplot/qmatplot-0.4.2-r1.ebuild,v 1.4 2004/07/22 17:08:17 kugelfang Exp $

inherit eutils

DESCRIPTION="gnuplot-like tool for plotting data sets in either two or three dimensions"
HOMEPAGE="http://qmatplot.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""
SLOT="0"

DEPEND=">=x11-libs/qt-3
	>=app-sci/octave-2.1
	>=app-sci/scilab-2.6"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-gentoo.patch"
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
