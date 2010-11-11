# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppcheck/cppcheck-1.45-r1.ebuild,v 1.1 2010/11/11 12:07:38 xmw Exp $

EAPI=2

PYTHON_DEPEND="htmlreport? 2"

inherit distutils eutils python toolchain-funcs qt4-r2

DESCRIPTION="static analyzer of C/C++ code"
HOMEPAGE="http://apps.sourceforge.net/trac/cppcheck/"
SRC_URI="mirror://sourceforge/cppcheck/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="htmlreport qt4"

DEPEND="htmlreport? ( dev-python/pygments )
		qt4? ( x11-libs/qt-gui:4
			x11-libs/qt-assistant:4 )"

pkg_setup() {
	if use htmlreport ; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	if use htmlreport ; then
		pushd htmlreport
		python_convert_shebangs -r 2 .
		distutils_src_prepare
		popd
	fi
}

src_configure() {
	tc-export CXX
	if use qt4 ; then
		pushd gui
		qt4-r2_src_configure
		popd
	fi
}

src_compile() {
	emake || die
	if use qt4 ; then
		pushd gui
		qt4-r2_src_compile
		popd
	fi
	if use htmlreport ; then
		pushd htmlreport
		distutils_src_compile
		popd
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc readme.txt || die
	if use qt4 ; then
		dobin gui/${PN}-gui || die
		dodoc readme_gui.txt gui/{projectfile.txt,gui.cppcheck} || die
	fi
	if use htmlreport ; then
		pushd htmlreport
		distutils_src_install
		popd
	fi
}
