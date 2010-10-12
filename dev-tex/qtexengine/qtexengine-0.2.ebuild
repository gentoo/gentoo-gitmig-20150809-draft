# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/qtexengine/qtexengine-0.2.ebuild,v 1.3 2010/10/12 12:05:13 jlec Exp $

EAPI=2
inherit eutils qt4

MY_PN=QTeXEngine

DESCRIPTION="TeX support for Qt"
HOMEPAGE="http://soft.proindependent.com/qtexengine/"
SRC_URI="mirror://berlios/qtiplot/${MY_PN}-${PV}-opensource.zip"

KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
SLOT="0"
LICENSE="GPL-3"
IUSE=""

RDEPEND="x11-libs/qt-gui:4"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${MY_PN}

PATCHES=( "${FILESDIR}/${P}-interpolate.patch"
	"${FILESDIR}/${P}-dynlib.patch" )

src_configure() {
	eqmake4 QTeXEngine.pro
}

src_compile() {
	emake sub-src-all || die
}

src_install() {
	dolib.so lib${MY_PN}.so* || die
	insinto /usr/include
	doins src/${MY_PN}.h || die
	dodoc CHANGES.txt
	dohtml -r ./doc/html/*
}
