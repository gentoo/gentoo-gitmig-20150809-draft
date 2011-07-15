# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/glib-networking/glib-networking-2.28.7.ebuild,v 1.7 2011/07/15 11:07:22 xarthisius Exp $

EAPI="3"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="Network-related giomodules for glib"
HOMEPAGE="http://git.gnome.org/browse/glib-networking/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="+gnome +libproxy +ssl"

RDEPEND=">=dev-libs/glib-2.27.90:2
	gnome? ( gnome-base/gsettings-desktop-schemas )
	libproxy? ( >=net-libs/libproxy-0.3.1 )
	ssl? ( >=net-libs/gnutls-2.1.7 )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	>=dev-util/pkgconfig-0.9
	sys-devel/gettext"

pkg_setup() {
	# AUTHORS, ChangeLog are empty
	DOCS="NEWS README"
	G2CONF="${G2CONF}
		--disable-static
		--disable-maintainer-mode
		--with-ca-certificates=/etc/ssl/certs/ca-certificates.crt
		$(use_with gnome gnome-proxy)
		$(use_with libproxy)
		$(use_with ssl gnutls)"
}
