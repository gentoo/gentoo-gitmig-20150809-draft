# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/ibus/ibus-1.3.1.ebuild,v 1.2 2010/04/04 14:33:41 matsuu Exp $

EAPI="2"
PYTHON_DEPEND="python? 2:2.5"
inherit eutils gnome2-utils multilib python

DESCRIPTION="Intelligent Input Bus for Linux / Unix OS"
HOMEPAGE="http://code.google.com/p/ibus/"
SRC_URI="http://ibus.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +gconf nls python"

RDEPEND=">=dev-libs/glib-2.18
	>=x11-libs/gtk+-2
	gconf? ( >=gnome-base/gconf-2.12 )
	>=gnome-base/librsvg-2
	sys-apps/dbus
	app-text/iso-codes
	x11-libs/libX11
	python? (
		>=dev-python/pygobject-2.14
		dev-python/notify-python
		>=dev-python/dbus-python-0.83
	)
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5.8.1
	dev-perl/XML-Parser
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.9 )
	nls? ( >=sys-devel/gettext-0.16.1 )"
RDEPEND="${RDEPEND}
	python? (
		dev-python/pygtk
		dev-python/pyxdg
	)"

RESTRICT="test"

update_gtk_immodules() {
	if [ -x /usr/bin/gtk-query-immodules-2.0 ] ; then
		GTK2_CONFDIR="/etc/gtk-2.0"
		# An arch specific config directory is used on multilib systems
		has_multilib_profile && GTK2_CONFDIR="${GTK2_CONFDIR}/${CHOST}"
		mkdir -p "${ROOT}${GTK2_CONFDIR}"
		gtk-query-immodules-2.0 > "${ROOT}${GTK2_CONFDIR}/gtk.immodules"
	fi
}

src_prepare() {
	mv py-compile py-compile.orig || die
	ln -s "$(type -P true)" py-compile || die
	echo "ibus/_config.py" >> po/POTFILES.skip || die
}

src_configure() {
	econf \
		$(use_enable doc gtk-doc) \
		$(use_enable gconf) \
		$(use_enable nls) \
		$(use_enable python) || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	# bug 289547
	keepdir /usr/share/ibus/{engine,icons} || die

	dodoc AUTHORS ChangeLog NEWS README || die
}

pkg_postinst() {

	elog "To use ibus, you should:"
	elog "1. Get input engines from sunrise overlay."
	elog "   Run \"emerge -s ibus-\" in your favorite terminal"
	elog "   for a list of packages we already have."
	elog
	elog "2. Setup ibus:"
	elog
	elog "   $ ibus-setup"
	elog
	elog "3. Set the following in your user startup scripts"
	elog "   such as .xinitrc, .xsession or .xprofile:"
	elog
	elog "   export XMODIFIERS=\"@im=ibus\""
	elog "   export GTK_IM_MODULE=\"ibus\""
	elog "   export QT_IM_MODULE=\"xim\""
	elog "   ibus-daemon -d -x"

	update_gtk_immodules

	use python && python_mod_optimize /usr/share/${PN}
	gnome2_icon_cache_update
}

pkg_postrm() {
	update_gtk_immodules

	use python && python_mod_cleanup /usr/share/${PN}
	gnome2_icon_cache_update
}
