# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/qt4-qtruby/qt4-qtruby-1.4.9-r3.ebuild,v 1.4 2009/10/06 20:33:19 ayoy Exp $

EAPI="1"

inherit toolchain-funcs eutils qt4 cmake-utils

DESCRIPTION="Ruby bindings for QT4"
HOMEPAGE="http://rubyforge.org/projects/korundum"
SRC_URI="http://rubyforge.org/frs/download.php/21951/${P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""
RDEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-dbus:4
	x11-libs/qt-opengl:4
	=x11-libs/qwt-5*"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.4.6"

SLOT="0"

pkg_setup() {
	qt4_pkg_setup
}

src_unpack() {
	unpack $A
	cd "${S}"
	epatch "${FILESDIR}/libCMakeLists.diff"
	epatch "${FILESDIR}/FindQwt5.cmake.diff"
	epatch "${FILESDIR}/cmakefix.diff"
	epatch "${FILESDIR}/FindQScintilla.cmake.diff"
	epatch "${FILESDIR}/libsmoke-multilib.patch"
}
