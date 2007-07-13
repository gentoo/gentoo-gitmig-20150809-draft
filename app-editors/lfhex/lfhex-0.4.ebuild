# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/lfhex/lfhex-0.4.ebuild,v 1.2 2007/07/13 05:34:14 mr_bones_ Exp $

inherit qt4 toolchain-funcs

DESCRIPTION="A fast, efficient hex-editor with support for large files and comparing binary files"
HOMEPAGE="http://stoopidsimple.com/lfhex"
SRC_URI="http://stoopidsimple.com/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

RDEPEND="$(qt4_min_version 4)
	|| (
	( >=x11-libs/libXt-1.0.0 )
	virtual/x11 )"

DEPEND="sys-devel/flex
	sys-devel/bison
	${RDEPEND}"

src_compile() {
	export QTDIR=/usr QTLIBDIR=/usr/lib/qt4 QTINCLUDEDIR=/usr/include/qt4 QTPLUGINDIR=/usr/lib/qt4/plugins
	${QTDIR}/bin/qmake lfhex.pro  || die
	emake CXX=$(tc-getCXX) LINK=$(tc-getCXX) LFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin lfhex
	dodoc README
}
