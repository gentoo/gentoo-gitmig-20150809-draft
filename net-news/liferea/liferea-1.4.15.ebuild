# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/liferea/liferea-1.4.15.ebuild,v 1.7 2009/08/26 13:14:20 dang Exp $

EAPI="1"
WANT_AUTOMAKE=1.7
inherit gnome2 eutils

DESCRIPTION="News Aggregator for RDF/RSS/CDF/Atom/Echo/etc feeds"
HOMEPAGE="http://liferea.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="dbus firefox gtkhtml gnutls libnotify lua networkmanager seamonkey xulrunner"

RDEPEND="
	libnotify? ( >=x11-libs/libnotify-0.3.2 )
	lua? ( >=dev-lang/lua-5.1 )
	xulrunner? ( =net-libs/xulrunner-1.8* )
	!xulrunner? ( firefox? ( =www-client/mozilla-firefox-2* ) )
	!xulrunner? ( !firefox? ( seamonkey? ( =www-client/seamonkey-1* ) ) )
	!amd64? ( !xulrunner? ( !firefox? ( !seamonkey? ( gtkhtml? ( gnome-extra/gtkhtml:2 ) ) ) ) )
	>=x11-libs/gtk+-2.8
	x11-libs/pango
	>=gnome-base/gconf-2
	>=dev-libs/libxml2-2.6.27
	>=dev-libs/libxslt-1.1.19
	>=dev-db/sqlite-3.3
	>=dev-libs/glib-2
	>=gnome-base/libglade-2
	dbus? ( >=dev-libs/dbus-glib-0.71 )
	networkmanager? ( net-misc/networkmanager )
	gnutls? ( net-libs/gnutls )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	# Backends are now mutually exclusive.
	# we prefer xulrunner over firefox over seamonkey over gtkhtml
	if use xulrunner ; then
		G2CONF="${G2CONF} --enable-xulrunner"
		G2CONF="${G2CONF} --disable-gecko"
		G2CONF="${G2CONF} --disable-gtkhtml2"
	elif use firefox ; then
		G2CONF="${G2CONF} --enable-gecko=firefox"
		G2CONF="${G2CONF} --disable-xulrunner"
		G2CONF="${G2CONF} --disable-gtkhtml2"
	elif use seamonkey ; then
		G2CONF="${G2CONF} --enable-gecko=seamonkey"
		G2CONF="${G2CONF} --disable-xulrunner"
		G2CONF="${G2CONF} --disable-gtkhtml2"
	elif use gtkhtml ; then
		if ! use amd64 ; then
			G2CONF="${G2CONF} --enable-gtkhtml2"
			G2CONF="${G2CONF} --disable-gecko"
			G2CONF="${G2CONF} --disable-xulrunner"
		else
			elog ""
			elog "gtkhtml is no longer supported on amd64; you will need to "
			elog "select one of the gecko backends to use liferea.  "
			elog "Preference is: xulrunner, firefox, then seamonkey."
			die "You must enable on of the gecko backends on amd64"
		fi
	else
		elog ""
		elog "You must choose one backend for liferea to work.  Preference is:"
		elog "xulrunner, firefox, seamonkey, then gtkhtml."
		die "You must enable on of the backends"
	fi

	G2CONF="${G2CONF} \
		--disable-webkit \
		$(use_enable dbus) \
		$(use_enable gnutls) \
		$(use_enable libnotify) \
		$(use_enable lua) \
		$(use_enable networkmanager nm)"
}

src_install() {
	gnome2_src_install
	rm -f "${D}/usr/bin/${PN}"
	mv "${D}/usr/bin/${PN}-bin" "${D}/usr/bin/${PN}"
}
