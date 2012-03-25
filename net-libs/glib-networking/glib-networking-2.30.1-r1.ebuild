# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/glib-networking/glib-networking-2.30.1-r1.ebuild,v 1.9 2012/03/25 17:08:17 armin76 Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2
# tests need virtualx

DESCRIPTION="Network-related giomodules for glib"
HOMEPAGE="http://git.gnome.org/browse/glib-networking/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="+gnome +libproxy +ssl" # test

RDEPEND=">=dev-libs/glib-2.29.16:2
	gnome? ( gnome-base/gsettings-desktop-schemas )
	libproxy? ( >=net-libs/libproxy-0.4.6-r3 )
	ssl? (
		app-misc/ca-certificates
		>=net-libs/gnutls-2.1.7 )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	>=dev-util/pkgconfig-0.9
	sys-devel/gettext

	>=sys-devel/autoconf-2.65:2.5"
#	test? ( sys-apps/dbus[X] )"
# eautoreconf needs >=sys-devel/autoconf-2.65:2.5

# FIXME: tls tests often fail, figure out why
# ERROR:tls.c:265:on_input_read_finish: assertion failed (error == NULL): Error performing TLS handshake: The request is invalid. (g-tls-error-quark, 1)
RESTRICT="test"

pkg_setup() {
	# AUTHORS, ChangeLog are empty
	DOCS="NEWS README"
	G2CONF="${G2CONF}
		--disable-static
		--with-ca-certificates=${EPREFIX}/etc/ssl/certs/ca-certificates.crt
		$(use_with gnome gnome-proxy)
		$(use_with libproxy)
		$(use_with ssl gnutls)"
}

src_prepare() {
	# bug #387589, https://bugzilla.gnome.org/show_bug.cgi?id=662203
	# Fixed in upstream git master
	epatch "${FILESDIR}/${PN}-2.28.7-gnome-proxy-AC_ARG_WITH.patch"
	# https://bugzilla.gnome.org/show_bug.cgi?id=662085
	# Fixed in upstream git master
	epatch "${FILESDIR}/${P}-gnome-proxy-test.patch"
	mkdir m4
	eautoreconf

	gnome2_src_prepare

	# Drop DEPRECATED flags
	sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED:$(NULL):g' \
		proxy/libproxy/Makefile.am proxy/libproxy/Makefile.in \
		proxy/gnome/Makefile.am proxy/gnome/Makefile.in \
		tls/gnutls/Makefile.am tls/gnutls/Makefile.in || die
}

#src_test() {
	# global make check fails if gnome-proxy test is not built
#	use gnome || cd tls/tests
#	Xemake check
#}
