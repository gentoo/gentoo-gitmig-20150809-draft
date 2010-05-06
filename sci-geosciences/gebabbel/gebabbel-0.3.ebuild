# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gebabbel/gebabbel-0.3.ebuild,v 1.5 2010/05/06 11:42:57 ssuominen Exp $

EAPI=2
inherit eutils qt4

MY_PN=${PN/g/G}
MY_P=${MY_PN}-${PV}

DESCRIPTION="QT-Frontend to load and convert gps tracks with gpsbabel"
HOMEPAGE="http://gebabbel.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}-Src.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4[accessibility]"
RDEPEND="${DEPEND}
	sci-geosciences/gpsbabel"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix.diff \
		"${FILESDIR}"/${P}-gcc45.patch
}

src_configure() {
	eqmake4 ${MY_PN}.pro
}

src_install() {
	dobin bin/${PN} || die "dobin failed"
	dodoc CHANGELOG || die "dodoc failed"
}
