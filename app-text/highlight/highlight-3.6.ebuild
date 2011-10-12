# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/highlight/highlight-3.6.ebuild,v 1.1 2011/10/12 02:06:40 radhermit Exp $

EAPI=4

inherit toolchain-funcs qt4-r2

DESCRIPTION="converts source code to formatted text ((X)HTML, RTF, (La)TeX, XSL-FO, XML) with syntax highlight"
HOMEPAGE="http://www.andre-simon.de/"
SRC_URI="http://www.andre-simon.de/zip/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="examples qt4"

DEPEND="dev-lang/lua
	dev-libs/boost
	qt4? ( x11-libs/qt-gui:4
		x11-libs/qt-core:4 )"
RDEPEND="${DEPEND}"

pkg_setup() {
	myhlopts=(
		"CXX=$(tc-getCXX)"
		"AR=$(tc-getAR)"
		"LDFLAGS=${LDFLAGS}"
		"CFLAGS=${CXXFLAGS}"
		"DESTDIR=${D}"
		"PREFIX=${EPREFIX}/usr"
		"LUA_CFLAGS="
		"HL_CONFIG_DIR=${EPREFIX}/etc/highlight/"
		"HL_DATA_DIR=${EPREFIX}/usr/share/highlight/"
		"doc_dir=${EPREFIX}/usr/share/doc/${PF}/"
		"conf_dir=${EPREFIX}/etc/highlight/"
	)
}

src_prepare() {
	sed -i -e "/LSB_DOC_DIR/s:doc/${PN}:doc/${PF}:" \
		src/core/datadir.cpp || die
}

src_compile() {
	emake -f makefile "${myhlopts[@]}"
	if use qt4 ; then
		cd src/gui-qt
		eqmake4 'DEFINES+=DATA_DIR=\\\"'"${EPREFIX}"'/usr/share/${PN}/\\\" CONFIG_DIR=\\\"'"${EPREFIX}"'/etc/${PN}/\\\" DOC_DIR=\\\"'"${EPREFIX}"'/usr/share/doc/${PF}/\\\"'
		emake
	fi
}

src_install() {
	emake -f makefile "${myhlopts[@]}" install
	use qt4 && emake -f makefile "${myhlopts[@]}" install-gui

	if use examples ; then
		docompress -x /usr/share/doc/${PF}/examples
	else
		rm -rf "${ED}"/usr/share/doc/${PF}/examples
	fi
}
