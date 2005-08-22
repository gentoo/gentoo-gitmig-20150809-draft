# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-qtimm/scim-qtimm-0.9.3.ebuild,v 1.2 2005/08/22 21:54:12 usata Exp $

inherit kde-functions

DESCRIPTION="Qt immodules input method framework plugin for SCIM"
HOMEPAGE="http://scim.freedesktop.org/"
SRC_URI="mirror://sourceforge/scim/${P}.tar.bz2
	http://freedesktop.org/~scim/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="nls arts"

DEPEND="|| ( >=app-i18n/scim-1.3 >=app-i18n/scim-cvs-1.3 )
	nls? ( sys-devel/gettext )
	arts? ( kde-base/arts )
	$(qt_min_version 3.3.4)"

pkg_setup() {
	if [ ! -e /usr/qt/3/plugins/inputmethods/libqimsw-none.so ] ; then
		die "You need to rebuild >=x11-libs/qt-3.3.4 with immqt-bc(recommended) or immqt USE flag enabled."
	fi
}

src_compile() {

	# bug #84369
	if which kde-config >/dev/null 2>&1 ; then
		export KDEDIR=$(kde-config --prefix)
		export kde_kcfgdir=/usr/share/config.kcfg
		export kde_servicesdir=/usr/share/services
	fi

	econf --enable-mt \
		$(use_enable nls) \
		$(use_with arts) || die
	emake -j1 || die "make failed."
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog README NEWS TODO
}

pkg_postinst() {
	einfo
	einfo "After you emerged ${PN}, use right click to switch immodules for Qt."
	einfo "If you would like to use ${PN} as default instead of XIM, set"
	einfo "	% export QT_IM_MODULE=scim"
	einfo
}
