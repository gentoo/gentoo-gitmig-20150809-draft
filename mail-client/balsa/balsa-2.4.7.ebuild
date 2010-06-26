# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/balsa/balsa-2.4.7.ebuild,v 1.6 2010/06/26 16:51:15 armin76 Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="Email client for GNOME"
HOMEPAGE="http://pawsa.fedorapeople.org/balsa/"
SRC_URI="http://pawsa.fedorapeople.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
# Doesn't currently build with -gnome
IUSE="crypt doc gnome gtkhtml +gtkspell kerberos ldap libnotify networkmanager rubrica sqlite ssl webkit xface"

# TODO: esmtp can be optional, webkit/canberra support
RDEPEND=">=dev-libs/glib-2.16
	>=x11-libs/gtk+-2.18
	dev-libs/gmime:2.4
	>=net-libs/libesmtp-1.0.3
	x11-themes/hicolor-icon-theme
	x11-themes/gnome-icon-theme
	net-mail/mailbase
	dev-libs/libunique
	crypt? ( >=app-crypt/gpgme-1.0 )
	gnome? (
		>=gnome-base/orbit-2
		>=gnome-base/libbonobo-2.0
		>=gnome-base/libgnome-2.0
		>=gnome-base/libgnomeui-2.0
		>=gnome-base/gconf-2.0
		>=gnome-base/gnome-keyring-2.20
		>=x11-libs/gtksourceview-2 )
	gtkhtml? ( >=gnome-extra/gtkhtml-3.14 )
	sqlite? ( >=dev-db/sqlite-2.8 )
	libnotify? ( x11-libs/libnotify )
	gtkspell? (
		=app-text/gtkspell-2*
		app-text/enchant )
	!gtkspell? ( virtual/aspell-dict )
	kerberos? ( app-crypt/mit-krb5 )
	ldap? ( net-nds/openldap )
	networkmanager? ( >=net-misc/networkmanager-0.7 )
	rubrica? ( dev-libs/libxml2 )
	ssl? ( dev-libs/openssl )
	webkit? ( >=net-libs/webkit-gtk-1.1.14 )
	xface? ( >=media-libs/compface-1.5.1 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	>=app-text/scrollkeeper-0.1.4
	app-text/gnome-doc-utils
	doc? ( dev-util/gtk-doc )"

DOCS="AUTHORS ChangeLog HACKING NEWS README TODO docs/*"

pkg_setup() {
	if use crypt ; then
		G2CONF="${G2CONF} --with-gpgme=gpgme-config"
	else
		G2CONF="${G2CONF} --without-gpgme"
	fi

	if use webkit || use gtkhtml ; then
		ewarn "Only one html widget can be enabled at the same time."
		ewarn "Selecting gtkhtml by default."

		if use gtkhtml ; then
			G2CONF="${G2CONF} --with-html-widget=gtkhtml3"
		else
			G2CONF="${G2CONF} --with-html-widget=webkit"
		fi
	else
		G2CONF="${G2CONF} --with-html-widget=no"
	fi

	# canberra support is considered experimental
	G2CONF="${G2CONF}
		--disable-pcre
		--enable-gregex
		--enable-threads
		--with-unique
		--without-canberra
		$(use_with gnome)
		$(use_with gnome gtksourceview)
		$(use_with gtkspell)
		$(use_with kerberos gss)
		$(use_with ldap)
		$(use_with libnotify)
		$(use_with networkmanager nm)
		$(use_with rubrica)
		$(use_with sqlite)
		$(use_with ssl)
		$(use_with xface compface)"
}

src_prepare() {
	gnome2_src_prepare

	# Fix build failure with USE="-libnotify", bug #314123
	epatch "${FILESDIR}/${P}-build-failure-notify.patch"
}
