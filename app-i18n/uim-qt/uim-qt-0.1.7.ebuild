# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim-qt/uim-qt-0.1.7.ebuild,v 1.5 2004/10/19 14:46:09 usata Exp $

inherit eutils

DESCRIPTION="Qt immodules input method framework plugin for UIM"
HOMEPAGE="http://freedesktop.org/Software/UimQt"
SRC_URI="http://freedesktop.org/~kzk/${PN}/${P}.tar.gz"

LICENSE="|| ( GPL-2 BSD )"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=app-i18n/uim-0.4.3
	|| ( =x11-libs/qt-3.3.3 =x11-libs/qt-3.3.2 )"

S="${WORKDIR}/${PN}"

pkg_setup() {
	if [ ! -e /usr/qt/3/plugins/inputmethods/libqimsw-none.so ] ; then
		die "You need to rebuild qt-3.3.3 or qt-3.3.2 with immqt-bc(recommended) or immqt USE flag enabled."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-thread.diff
}

src_compile() {
	sed -e 's,${QTDIR},${D}${QTDIR},g' install > ${T}/install

	qmake || die "qmake failed"
	emake -j1 || die "make failed."
}

src_install() {
	sh ${T}/install || die "install failed"

	dodoc COPYING ChangeLog README* TODO THANKS
}

src_test() {
	#cd edittest
	#qmake -project || die "qmake -project failed"
	#qmake || die "qmake failed"
	#emake || die "emake failed"
	#
	# This programme needs human interaction to test. (i.e. You need to
	# manually check whether quiminputcontextplugin is working or not
	# with GUI interface)
	#./edittest
	return
}

pkg_postinst() {
	einfo
	einfo "After you emerged ${PN}, use right click to switch immodules for Qt."
	einfo "If you would like to use ${PN} as default instead of XIM, set QT_IM_MODULE to uim-*."
	einfo "e.g.)"
	einfo "	% export QT_IM_MODULE=uim-anthy"
	einfo
	ewarn
	ewarn "qtconfig is no longer used for selecting input methods."
	ewarn
}
