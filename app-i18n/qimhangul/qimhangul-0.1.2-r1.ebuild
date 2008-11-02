# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/qimhangul/qimhangul-0.1.2-r1.ebuild,v 1.1 2008/11/02 09:57:36 matsuu Exp $

EAPI=2

inherit qt3

DESCRIPTION="Korean input method plugin for Qt immodules"
HOMEPAGE="http://kldp.net/projects/qimhangul/"
SRC_URI="http://kldp.net/frs/download.php/4620/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=" app-i18n/libhangul
	|| (
		x11-libs/qt:3[immqt-bc]
		x11-libs/qt:3[immqt]
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	eqmake3 || die "qmake failed"
}

src_compile() {
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
	elog "	$ export QT_IM_MODULE=hangul2"
	elog
	ewarn
	ewarn "qtconfig is no longer used for selecting input methods."
	ewarn
}
