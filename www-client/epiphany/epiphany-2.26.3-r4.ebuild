# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany/epiphany-2.26.3-r4.ebuild,v 1.10 2011/03/20 22:21:20 nirbheek Exp $

EAPI="2"

inherit gnome2 eutils multilib autotools

DESCRIPTION="GNOME webbrowser based on the mozilla rendering engine"
HOMEPAGE="http://www.gnome.org/projects/epiphany/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc64"
IUSE="avahi doc networkmanager python spell"

RDEPEND=">=dev-libs/glib-2.18.0:2
	>=x11-libs/gtk+-2.16.0:2
	>=dev-libs/libxml2-2.6.12:2
	>=dev-libs/libxslt-1.1.7
	>=gnome-base/libglade-2.3.1:2.0
	>=gnome-base/libgnome-2.14
	>=gnome-base/libgnomeui-2.14
	>=gnome-base/gnome-desktop-2.9.91:2
	>=x11-libs/startup-notification-0.5
	>=x11-libs/libnotify-0.4
	<x11-libs/libnotify-0.7
	>=media-libs/libcanberra-0.3[gtk]
	>=dev-libs/dbus-glib-0.71
	>=gnome-base/gconf-2:2
	>=app-text/iso-codes-0.35
	avahi? ( >=net-dns/avahi-0.6.22 )
	networkmanager? ( net-misc/networkmanager )
	=net-libs/xulrunner-1.9.2*
	python? (
		=dev-lang/python-2*
		>=dev-python/pygtk-2.7.1:2
		>=dev-python/gnome-python-2.6:2 )
	spell? ( app-text/enchant )
	x11-themes/gnome-icon-theme"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.40
	>=app-text/gnome-doc-utils-0.3.2
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-scrollkeeper
		--with-gecko=libxul-embedding
		--with-distributor-name=Gentoo
		--enable-canberra
		$(use_enable avahi zeroconf)
		$(use_enable networkmanager network-manager)
		$(use_enable spell spell-checker)
		$(use_enable python)"
}

src_prepare() {
	gnome2_src_prepare

	# Fix libcanberra automagic support, bug #266232
	epatch "${FILESDIR}/${PN}-2.26.1-automagic-libcanberra.patch"

	# Fix sandbox violations, bug #263585
	epatch "${FILESDIR}/${PN}-2.26-fix-sandbox-violations.patch"

	# Fix detection of system plugin, bug #279417
	epatch "${FILESDIR}/${P}-system-plugin.patch"

	# Fix missing favicons of most web-sites, bug #290024
	epatch "${FILESDIR}/${P}-favicon-cache.patch"

	# Fix download location reset, bug #292867
	epatch "${FILESDIR}/${P}-revert-downloadir.patch"

	# Port to xulrunner-1.9.2, bug #303583
	epatch "${FILESDIR}/${P}-xul192.patch"
	sed -i s/TextZoom/FullZoom/  embed/mozilla/EphyBrowser.cpp || die

	# Fix nspr dependency, bug #303583
	epatch "${FILESDIR}/${P}-nspr.patch"

	# Fix missing glib header, bug #303583
	epatch "${FILESDIR}/${P}-glib.patch"

	# Make it libtool-1 compatible
	rm -v m4/lt* m4/libtool.m4 || die "removing libtool macros failed"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

src_install() {
	gnome2_src_install

	# All .la files are for plugins or extensions that are dlopened.
	# Upstream should pass *_la_LIBTOOLFLAGS = --tag=disable-static to drop them instead
	# but gecko is a dead branch for them, so do it ourselves:
	find "${D}" -name '*.la' -delete
}

pkg_postinst() {
	gnome2_pkg_postinst

	elog
	elog "If after updating Epiphany it becomes unable to show any webpage reporting"
	elog "errors in terminal regarding 'EphyBrowser initialization failed', try"
	elog "removing old compreg.dat file:"
	elog " rm ~/.gnome2/epiphany/mozilla/epiphany/compreg.dat"
	elog "and restart it."
}
