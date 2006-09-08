# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/yelp/yelp-2.16.0.ebuild,v 1.2 2006/09/08 16:58:54 compnerd Exp $

inherit eutils gnome2 autotools

DESCRIPTION="Help browser for GNOME"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="beagle firefox"

RDEPEND=">=gnome-base/gconf-2
	>=app-text/gnome-doc-utils-0.3.1
	>=x11-libs/gtk+-2.10
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2.14
	>=gnome-base/libgnomeui-2.14
	>=dev-libs/libxml2-2.6.5
	>=dev-libs/libxslt-1.1.4
	>=x11-libs/startup-notification-0.8
	>=dev-libs/glib-2
	sys-apps/dbus
	beagle? ( >=app-misc/beagle-0.2.4 )
	sparc? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	ia64? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	ppc64? ( www-client/seamonkey )
	!sparc? ( !ia64? ( !firefox? ( www-client/seamonkey ) ) )
	firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	sys-libs/zlib
	app-arch/bzip2"

DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog NEWS README TODO"


pkg_setup() {
	G2CONF="${G2CONF} --enable-man --enable-info"

	if use firefox || use sparc || use ia64; then
		G2CONF="${G2CONF} --with-mozilla=firefox"
	else
		G2CONF="${G2CONF} --with-mozilla=seamonkey"
	fi
}

src_unpack() {
	gnome2_src_unpack

	epatch ${FILESDIR}/${PN}-2.15.1-mozilla-include-fix.patch

	mv aclocal.m4 old_macros.m4
	AT_M4DIR="m4 ." eautoreconf
}
