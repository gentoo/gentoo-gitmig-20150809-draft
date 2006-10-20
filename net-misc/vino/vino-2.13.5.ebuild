# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vino/vino-2.13.5.ebuild,v 1.17 2006/10/20 18:40:26 agriffis Exp $

inherit eutils gnome2 autotools

DESCRIPTION="An integrated VNC server for GNOME"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="avahi crypt gnutls jpeg zlib"

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2.5.2
	>=gnome-base/orbit-2
	>=gnome-base/libbonobo-2
	|| ( x11-libs/libXtst virtual/x11 )
	avahi? ( >=net-dns/avahi-0.6 )
	crypt? ( >=dev-libs/libgcrypt-1.1.90 )
	gnutls? ( >=net-libs/gnutls-1 )
	jpeg? ( media-libs/jpeg )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"

pkg_setup() {
	if use avahi && ! built_with_use net-dns/avahi dbus; then
		einfo "avahi support in vino requires USE=dbus in avahi"
		die "Please rebuild net-dns/avahi with USE=dbus"
	fi
	G2CONF="$(use_with jpeg) $(use_enable gnutls) $(use_enable crypt gcrypt) \
			$(use_with zlib) $(use_with zlib libz) $(use_enable avahi) \
			--enable-session-support"
}

src_unpack() {
	gnome2_src_unpack

	# Fix compilation if --without-libz is passed
	epatch "${FILESDIR}"/${PN}-2.11-zlib_fix.patch

	# Fix compilation for Gentoo/FreeBSD
	epatch "${FILESDIR}"/${PN}-2.10.0-fbsd.patch

	# fix as-needed #132558
	epatch "${FILESDIR}"/${P}-as-needed.patch

	cp aclocal.m4 old_macros.m4
	# rename some things so they get regenerated and we don't get a mismatch
	sed -i -e 's:AM_AUTOMAKE_VERSION:AM_AUTOMAKE_VERSION2:' old_macros.m4
	sed -i -e 's:AM_INIT_AUTOMAKE:AM_INIT_AUTOMAKE2:' old_macros.m4
	sed -i -e 's:AM_SET_CURRENT_AUTOMAKE_VERSION:AM_SET_CURRENT_AUTOMAKE_VERSION2:' old_macros.m4
	AT_M4DIR="." eautoreconf
}
