# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/highlight/highlight-3.0_beta.ebuild,v 1.1 2010/06/19 08:16:01 ssuominen Exp $

EAPI=3
inherit toolchain-funcs

MY_P=${P/_/-}

DESCRIPTION="converts source code to formatted text ((X)HTML, RTF, (La)TeX, XSL-FO, XML) with syntax highlight"
HOMEPAGE="http://www.andre-simon.de/"
SRC_URI="http://www.andre-simon.de/zip/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="qt4"

DEPEND="dev-lang/lua
	qt4? ( x11-libs/qt-gui:4 )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	myhlopts=(
		"CXX=$(tc-getCXX)"
		"DESTDIR=${D}"
		"PREFIX=${EPREFIX}/usr"
		"doc_dir=${EPREFIX}/usr/share/doc/${PF}/"
		"conf_dir=${EPREFIX}/etc/highlight/"
		)
}

src_prepare() {
	sed -i \
		-e 's:dir}plugins:dir}web_plugins:' \
		makefile || die

	sed -i \
		-e "/LSB_DOC_DIR/s:doc/${PN}:doc/${PF}:" \
		src/core/datadir.cpp || die

	sed -i \
		-e 's:-O2::' \
		-e 's:CFLAGS:CXXFLAGS:g' \
		src/makefile || die
}

src_compile() {
	emake -f makefile "${myhlopts[@]}" || die

	if use qt4; then
		emake -j1 -f makefile "${myhlopts[@]}" gui || die
	fi
}

src_install() {
	emake -f makefile "${myhlopts[@]}" install || die

	if use qt4; then
		emake -f makefile "${myhlopts[@]}" install-gui || die
	fi
}
