# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gebabbel/gebabbel-0.3.ebuild,v 1.2 2008/07/08 16:51:06 gentoofan23 Exp $

EAPI="1"
inherit eutils qt4

DESCRIPTION="QT-Frontend to load and convert gps tracks with gpsbabel"
HOMEPAGE="http://gebabbel.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/Gebabbel-${PV}-Src.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="|| ( ( x11-libs/qt-core:4 x11-libs/qt-gui:4 ) >=x11-libs/qt-4.3.0:4 )
	sci-geosciences/gpsbabel"

S="${WORKDIR}/Gebabbel-${PV}"

QT4_BUILT_WITH_USE_CHECK="guiaccessibility"
src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-fix.diff"
}

src_compile() {
	qmake || die
	emake || die
}

src_install() {
	dobin bin/gebabbel || die
	dodoc CHANGELOG || die
}
