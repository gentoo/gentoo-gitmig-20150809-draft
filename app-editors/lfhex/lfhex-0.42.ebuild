# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/lfhex/lfhex-0.42.ebuild,v 1.1 2008/11/16 17:35:56 dragonheart Exp $

EAPI="1"

inherit qt4 toolchain-funcs

DESCRIPTION="A fast, efficient hex-editor with support for large files and comparing binary files"
HOMEPAGE="http://stoopidsimple.com/lfhex"
SRC_URI="http://stoopidsimple.com/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

RDEPEND="|| ( x11-libs/qt-gui:4
		<x11-libs/qt-4.4:4 )
		>=x11-libs/libXt-1.0.0"

DEPEND="sys-devel/flex
	sys-devel/bison
	${RDEPEND}"
S="${WORKDIR}"/${P}/src

src_compile() {
#	eqmake4 lfhex.pro
	eqmake4 || die "eqmake4 failed"
	emake || die "emake failed"
}

src_install() {
	dobin lfhex
	dodoc ../README
}
