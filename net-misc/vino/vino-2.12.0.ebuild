# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vino/vino-2.12.0.ebuild,v 1.12 2006/04/23 18:00:53 kumba Exp $

inherit eutils gnome2

DESCRIPTION="An integrated VNC server for GNOME"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE="crypt gnutls jpeg zlib"

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2.5.2
	>=gnome-base/orbit-2
	>=gnome-base/libbonobo-2
	|| ( x11-libs/libXtst virtual/x11 )
	jpeg? ( media-libs/jpeg )
	gnutls? ( >=net-libs/gnutls-1 )
	crypt? ( >=dev-libs/libgcrypt-1.1.90 )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
USE_DESTDIR="1"


pkg_setup() {
	G2CONF="$(use_with jpeg) $(use_enable gnutls) $(use_enable crypt gcrypt) \
		$(use_with zlib) $(use_with zlib libz) --enable-session-support"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Fix compilation if --without-libz is passed
	epatch ${FILESDIR}/${PN}-2.11-zlib_fix.patch
	# Fix compilation for Gentoo/FreeBSD
	epatch ${FILESDIR}/${PN}-2.10.0-fbsd.patch
}
