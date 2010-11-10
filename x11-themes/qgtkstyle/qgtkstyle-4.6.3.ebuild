# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/qgtkstyle/qgtkstyle-4.6.3.ebuild,v 1.2 2010/11/10 16:05:37 fauli Exp $

EAPI="3"
inherit qt4-r2

MY_PV=${PV/_/-}
MY_P=qt-everywhere-opensource-src-${MY_PV}

DESCRIPTION="Qt style that uses the active GTK theme."
HOMEPAGE="http://qt.nokia.com/"
SRC_URI="http://get.qt.nokia.com/qt/source/${MY_P}.tar.gz"

LICENSE="|| ( LGPL-2.1 GPL-3 )"
SLOT="4"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

COMMON_DEPEND="
	x11-libs/gtk+:2
	>=x11-libs/qt-gui-${PV}-r1
"
DEPEND="${COMMON_DEPEND}
	x11-libs/cairo
"
RDEPEND="${COMMON_DEPEND}
	!>x11-libs/qt-gui-${PV}-r9999
"

src_unpack() {
	tar xzf "${DISTDIR}"/${MY_P}.tar.gz ${MY_P}/src/gui/styles/ || die
	mv ${MY_P}/src/gui/styles "${S}" || die
	cp "${FILESDIR}"/qgtkstyle.pro "${S}"/ || die
}
