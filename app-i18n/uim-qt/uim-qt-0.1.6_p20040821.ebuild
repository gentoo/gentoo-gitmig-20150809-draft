# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim-qt/uim-qt-0.1.6_p20040821.ebuild,v 1.1 2004/08/21 20:35:31 usata Exp $

MY_PN="quiminputcontextplugin"
#MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_PN}"
#MY_P="${MY_PN}-bc-${PV/*_p/}"
#S="${WORKDIR}/${MY_P}"

DESCRIPTION="Qt immodules input method framework plugin for UIM"
HOMEPAGE="http://uim.freedesktop.org/"
#SRC_URI="http://mover.cool.ne.jp/others/immodule/${MY_P}.tar.gz"
#SRC_URI="http://freedesktop.org/~tkng/${MY_PN}/${MY_P}.tar.gz"
SRC_URI="mirror://gentoo/${P/_p/-}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${P/_p/-}.tar.gz"

LICENSE="GPL-2 | BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-i18n/uim
	>=x11-libs/qt-3.3.2"

pkg_setup() {
	ewarn
	ewarn "You need to install >=x11-libs/qt-3.3.2 with immqt or immqt-bc"
	ewarn "USE flag enabled. (NOTE: This has been changed from cjk.)"
	ewarn
	if [ ! -e /usr/qt/3/include/qinputcontext.h ] ; then
		die "You need to rebuild >=x11-libs/qt-3.3.2 with immqt or immqt-bc USE flag enabled."
	fi
	if [ ! -e /usr/qt/3/plugins/inputmethods/libqimsw-none.so ] ; then
		die "Your Qt was not built against the latest immodule API. Please rebuild >=x11-libs/qt-3.3.2."
	fi
}

src_compile() {
	sed -e 's,${QTDIR},${D}${QTDIR},g' install > ${T}/install

	qmake || die "qmake failed"
	emake -j1 || die "make failed."
}

src_install() {
	sh ${T}/install || die "install failed"

	dodoc COPYING ChangeLog README* TODO
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
	einfo "After you emerged ${PN}, run"
	einfo "	% qtconfig"
	einfo "and select your immodule to enable ${PN}."
	einfo
}
