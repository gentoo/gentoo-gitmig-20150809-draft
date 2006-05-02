# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/yelp/yelp-2.14.0.ebuild,v 1.4 2006/05/02 14:02:28 corsair Exp $

inherit eutils gnome2 autotools

DESCRIPTION="Help browser for GNOME"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
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
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=dev-libs/libxml2-2.6.5
	>=dev-libs/libxslt-1.1.4
	>=x11-libs/startup-notification-0.8
	!firefox? ( >=www-client/mozilla-1.7.3 )
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
	G2CONF="${G2CONF} --enable-man --enable-info"

	if use firefox; then
		G2CONF="${G2CONF} --with-mozilla=firefox"
	else
		G2CONF="${G2CONF} --with-mozilla=mozilla"
	fi
}

src_unpack() {
	gnome2_src_unpack

	epatch ${FILESDIR}/${PN}-2.14.0-mozilla-include-fix.patch

	mv aclocal.m4 old_macros.m4
	AT_M4DIR="m4 ." \
	eautoreconf
}
