# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus/ibus-0.1.1.20081023.ebuild,v 1.2 2009/01/21 14:53:32 matsuu Exp $

EAPI="1"
inherit autotools eutils multilib python

DESCRIPTION="Intelligent Input Bus for Linux / Unix OS"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2.1"
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
	x11-misc/notification-daemon
	|| (
		dev-python/gconf-python
		dev-python/gnome-python
	)"

pkg_setup() {
	# An arch specific config directory is used on multilib systems
	has_multilib_profile && GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
	GTK2_CONFDIR=${GTK2_CONFDIR:=/etc/gtk-2.0/}
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
	sed -i -e '/QMAKE/s/$/ "CONFIG+=nostrip"/' client/qt4/Makefile.am || die
	eautoreconf
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
	local qt_im_module="xim"
	use qt4 && qt_im_module="ibus"

	elog "To use ibus, you should:"
	elog "1. Get input engines from sunrise overlay."
	elog "   Run \"emerge -s ibus-\" in your favorite terminal"
	elog "   for a list of packages we already have."
	elog "2. Set the following in your"
	elog "   user startup scripts such as .xinitrc or .bashrc"
	elog
	elog "   export XMODIFIERS=\"@im=ibus\""
	elog "   export GTK_IM_MODULE=\"ibus\""
	elog "   export QT_IM_MODULE=\"${qt_im_module}\""
	elog "   ibus &"

	[ "${ROOT}" = "/" -a -x /usr/bin/gtk-query-immodules-2.0 ] && \
		gtk-query-immodules-2.0 > "${ROOT}/${GTK2_CONFDIR}/gtk.immodules"

	python_mod_optimize /usr/share/${PN}
}

pkg_postrm() {
	[ "${ROOT}" = "/" -a -x /usr/bin/gtk-query-immodules-2.0 ] && \
		gtk-query-immodules-2.0 > "${ROOT}/${GTK2_CONFDIR}/gtk.immodules"

	python_mod_cleanup /usr/share/${PN}
}
