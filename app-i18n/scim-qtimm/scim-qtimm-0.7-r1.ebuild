# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-qtimm/scim-qtimm-0.7-r1.ebuild,v 1.1 2004/09/10 16:47:17 usata Exp $

DESCRIPTION="Qt immodules input method framework plugin for SCIM"
HOMEPAGE="http://scim.freedesktop.org/"
SRC_URI="http://freedesktop.org/~cougar/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

RDEPEND=">=app-i18n/scim-0.99.9
	>=x11-libs/qt-3.3.3-r1
	nls? ( sys-devel/gettext )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

pkg_setup() {
	if [ ! -e /usr/qt/3/plugins/inputmethods/libqimsw-none.so ] ; then
		die "You need to rebuild >=x11-libs/qt-3.3.3-r1 with immqt or immqt-bc USE flag enabled."
	fi
}

src_compile() {
	addpredict /usr/qt/3/etc/settings

	sed -i -e "s/QCString/QString/g" src/qsciminputcontext.* || die

	econf `use_enable nls` || die
	emake -j1 || die "make failed."
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog README NEWS TODO
}

pkg_postinst() {
	einfo
	einfo "After you emerged ${PN}, use right click to switch immodules for Qt."
	einfo "If you would like to use scim-qtimm as default instead of XIM, set"
	einfo "	% export QT_IM_MODULE=scim"
	einfo
	ewarn
	ewarn "qtconfig is no longer used for selecting input methods."
	ewarn
}
