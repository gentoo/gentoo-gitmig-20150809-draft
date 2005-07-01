# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/qimhangul/qimhangul-0.0.1.ebuild,v 1.4 2005/07/01 14:52:35 caleb Exp $

inherit eutils

DESCRIPTION="Korean input method plugin for Qt immodules"
HOMEPAGE="http://kldp.net/projects/qimhangul/"
SRC_URI="http://kldp.net/download.php/1529/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=x11-libs/qt-3.3.3-r1"

pkg_setup() {
	if [ ! -e /usr/qt/3/plugins/inputmethods/libqimsw-none.so ] ; then
		die "You need to rebuild >=x11-libs/qt-3.3.3-r1 with immqt-bc or immqt USE flag enabled."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-thread-gentoo.diff
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
