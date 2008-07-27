# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/qimhangul/qimhangul-0.0.2.ebuild,v 1.4 2008/07/27 19:48:20 carlo Exp $

EAPI=1

inherit qt3 eutils

DESCRIPTION="Korean input method plugin for Qt immodules"
HOMEPAGE="http://kldp.net/projects/qimhangul/"
SRC_URI="http://kldp.net/frs/download.php/1800/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-libs/qt:3"

pkg_setup() {
	if [ ! -e "${QTDIR}"/plugins/inputmethods/libqimsw-none.so ] ; then
		die "You need to rebuild >=x11-libs/qt-3.3.3-r1 with immqt-bc or immqt USE flag enabled."
	fi
}

src_compile() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_compile() {
	"${QTDIR}"/bin/qmake -makefile || die "qmake failed"
	emake -j1 || die "make failed."
}

src_install() {
	make INSTALL_ROOT="${D}" install || die

	dodoc ChangeLog
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
