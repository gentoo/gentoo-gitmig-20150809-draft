# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/liferea/liferea-1.4.1.ebuild,v 1.1 2007/09/05 17:36:59 dang Exp $

WANT_AUTOMAKE=1.7
WANT_AUTOCONF=latest
inherit gnome2

DESCRIPTION="News Aggregator for RDF/RSS/CDF/Atom/Echo/etc feeds"
HOMEPAGE="http://liferea.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="dbus firefox gtkhtml gnutls libnotify lua networkmanager seamonkey xulrunner"

RDEPEND="
	libnotify? ( >=x11-libs/libnotify-0.3.2 )
	lua? ( >=dev-lang/lua-5.1 )
	xulrunner? ( net-libs/xulrunner )
	!xulrunner? ( firefox? ( www-client/mozilla-firefox ) )
	!xulrunner? ( !firefox? ( seamonkey? ( www-client/seamonkey ) ) )
	!amd64? ( !xulrunner? ( !firefox? ( !seamonkey? ( =gnome-extra/gtkhtml-2* ) ) ) )
	!amd64? ( gtkhtml? ( =gnome-extra/gtkhtml-2* ) )
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
	# On amd64, gtkhtml isn't supported.  You need one of the gecko use flags
	if use amd64 && ! use firefox && ! use seamonkey && ! use xulrunner; then
		elog "gtkhtml is no longer supported on amd64; you will need to select"
		elog "one of the gecko backends to use liferea"
		die "You must enable on of the gecko backends on amd64"
	fi

	# if you don't choose a gecko to use, we will automatically
	# use gtkhtml2 as the backend except on amd64 (where we failed above)
	if ! use seamonkey && ! use firefox && ! use xulrunner && ! use amd64 ; then
		G2CONF="${G2CONF} --enable-gtkhtml2"
	elif ! use amd64 && use gtkhtml ; then
		G2CONF="${G2CONF} --enable-gtkhtml2"
	else
		G2CONF="${G2CONF} --disable-gtkhtml2"
	fi

	# we prefer xulrunner over firefox over seamonkey
	if use xulrunner ; then
		G2CONF="${G2CONF} --enable-xulrunner"
	elif use firefox ; then
		G2CONF="${G2CONF} --enable-gecko=firefox"
	elif use seamonkey ; then
		G2CONF="${G2CONF} --enable-gecko=seamonkey"
	else
		G2CONF="${G2CONF} --disable-gecko"
	fi

	G2CONF="${G2CONF} \
		$(use_enable dbus) \
		$(use_enable gnutls) \
		$(use_enable libnotify) \
		$(use_enable lua) \
		$(use_enable networkmanager nm)"
}

src_install() {
	gnome2_src_install
	rm -f ${D}/usr/bin/${PN}
	mv ${D}/usr/bin/${PN}-bin ${D}/usr/bin/${PN}
}
