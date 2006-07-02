# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/yelp/yelp-2.12.2-r1.ebuild,v 1.1 2006/07/02 20:23:42 allanonjl Exp $

inherit eutils gnome2

DESCRIPTION="Help browser for GNOME"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc x86"
IUSE="firefox"

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/orbit-2.12.4
	>=gnome-base/gconf-2
	>=app-text/gnome-doc-utils-0.3.1
	>=gnome-base/gnome-vfs-2
	>=x11-libs/gtk+-2.5.3
	>=gnome-base/libbonobo-1.108
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2.0.2
	>=gnome-base/libgnomeui-1.103
	>=dev-libs/libxml2-2.6.5
	>=dev-libs/libxslt-1.1.4
	sparc? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	ia64? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	ppc64? ( www-client/seamonkey )
	!sparc? ( !ia64? ( !firefox? ( www-client/seamonkey ) ) )
	firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	dev-libs/popt
	sys-libs/zlib
	app-arch/bzip2"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.28
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog NEWS README TODO"


pkg_setup() {
	G2CONF="--enable-man --enable-info"

	if use firefox || use sparc || use ia64; then
		G2CONF="${G2CONF} --with-mozilla=firefox"
	else
		G2CONF="${G2CONF} --with-mozilla=seamonkey"
	fi
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	epatch ${FILESDIR}/${PN}-2.6.4-makedepfix.patch
}
