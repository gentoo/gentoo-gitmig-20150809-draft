# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus/ibus-0.1.1.20080923.ebuild,v 1.1 2008/09/24 12:07:11 matsuu Exp $

EAPI="1"
inherit multilib

DESCRIPTION="Intelligent Input Bus for Linux / Unix OS"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls qt4"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	dev-libs/dbus-glib
	qt4? ( || (
		(
			>=x11-libs/qt-core-4.4:4
			>=x11-libs/qt-dbus-4.4:4
		)
		>=x11-libs/qt-4.4:4
	) )
	app-text/iso-codes
	x11-libs/libX11
	>=dev-lang/python-2.5
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( >=sys-devel/gettext-0.16.1 )"
RDEPEND="${RDEPEND}
	dev-python/pygtk
	>=dev-python/dbus-python-0.83
	dev-python/pyxdg
	dev-python/gconf-python"

pkg_setup() {
	# An arch specific config directory is used on multilib systems
	has_multilib_profile && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	GTK2_CONFDIR=${GTK2_CONFDIR:=/etc/gtk-2.0/}
}

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable qt4 qt4-immodule) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	ewarn "This package is very experimental, please report your bug to"
	ewarn "http://ibus.googlecode.com/issues/list"
	elog
	elog "To use ibus, you should:"
	elog "1. Get input engines from sunrise overlay."
	elog "   Run \"emerge -s ibus-\" in your favorite terminal"
	elog "   for a list of packages we already have."
	elog "2. Set the following in your"
	elog "   user startup scripts such as .xinitrc or .bashrc"
	elog
	elog "   export XMODIFIERS=\"@im=ibus\""
	elog "   export GTK_IM_MODULE=\"ibus\""
	elog "   export QT_IM_MODULE=\"ibus\""
	elog "   ibus &"
	elog
	if ! use qt4; then
		ewarn "Missing qt4 use flag, ibus will not work in qt4 applications."
		ebeep 3
	fi
	elog

	if [ -x /usr/bin/gtk-query-immodules-2.0 ] ; then
		gtk-query-immodules-2.0 > "${ROOT}/${GTK2_CONFDIR}/gtk.immodules"
	fi
}

pkg_postrm() {
	if [ -x /usr/bin/gtk-query-immodules-2.0 ] ; then
		gtk-query-immodules-2.0 > "${ROOT}/${GTK2_CONFDIR}/gtk.immodules"
	fi
}
