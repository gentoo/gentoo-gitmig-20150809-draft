# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/qimhangul/qimhangul-0.0.2.ebuild,v 1.1 2005/07/31 09:01:32 usata Exp $

inherit qt3

DESCRIPTION="Korean input method plugin for Qt immodules"
HOMEPAGE="http://kldp.net/projects/qimhangul/"
SRC_URI="http://kldp.net/frs/download.php/1800/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="$(qt_min_version 3.3.4)"

pkg_setup() {
	if [ ! -e /usr/qt/3/plugins/inputmethods/libqimsw-none.so ] ; then
		die "You need to rebuild >=x11-libs/qt-3.3.3-r1 with immqt-bc or immqt USE flag enabled."
	fi
}

src_compile() {
	${QTDIR}/bin/qmake -makefile || die "qmake failed"
	emake -j1 || die "make failed."
}

src_install() {
	make INSTALL_ROOT=${D} install || die

	dodoc ChangeLog
}

pkg_postinst() {
	einfo
	einfo "After you emerged ${PN}, use right click to switch immodules for Qt."
	einfo "If you would like to use qimhangul as default instead of XIM,"
	einfo " set QT_IM_MODULE to hangul2."
	einfo "e.g.)"
	einfo "	% export QT_IM_MODULE=hangul2"
	einfo
	ewarn
	ewarn "qtconfig is no longer used for selecting input methods."
	ewarn
}
