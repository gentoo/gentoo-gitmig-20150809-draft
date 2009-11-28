# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/lfhex/lfhex-0.42.ebuild,v 1.3 2009/11/28 21:43:36 scarabeus Exp $

EAPI="2"

inherit base qt4

DESCRIPTION="A fast, efficient hex-editor with support for large files and comparing binary files"
HOMEPAGE="http://stoopidsimple.com/lfhex"
SRC_URI="http://stoopidsimple.com/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

RDEPEND="x11-libs/qt-gui:4
	x11-libs/libXt"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

S=${WORKDIR}/${P}/src

src_configure() {
	eqmake4 || die "eqmake4 failed"
}

src_install() {
	dobin lfhex || die
	dodoc ../README || die
}
