# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/qimhangul/qimhangul-0.1.2.ebuild,v 1.1 2008/09/24 15:31:20 matsuu Exp $

EAPI=1

inherit eutils qt3

DESCRIPTION="Korean input method plugin for Qt immodules"
HOMEPAGE="http://kldp.net/projects/qimhangul/"
SRC_URI="http://kldp.net/frs/download.php/4620/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt:3
	app-i18n/libhangul"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if use qt3 && ! built_with_use =x11-libs/qt-3* immqt-bc && ! built_with_use =x11-libs/qt-3* immqt; then
		eerror "To support qt3 in this package is required to have"
		eerror "=x11-libs/qt-3* compiled with immqt-bc(recommended) or immqt USE flag."
		die "You need to rebuild >=x11-libs/qt-3.3.3-r1 with immqt-bc or immqt USE flag enabled."
	fi
}

src_compile() {
	"${QTDIR}"/bin/qmake -makefile || die "qmake failed"
	emake || die "make failed."
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die

	dodoc AUTHORS ChangeLog* README
}

pkg_postinst() {
	elog
	elog "After you emerged ${PN}, use right click to switch immodules for Qt."
	elog "If you would like to use qimhangul as default instead of XIM,"
	elog " set QT_IM_MODULE to hangul2."
	elog "e.g.)"
	elog "	% export QT_IM_MODULE=hangul2"
	elog
	ewarn
	ewarn "qtconfig is no longer used for selecting input methods."
	ewarn
}
