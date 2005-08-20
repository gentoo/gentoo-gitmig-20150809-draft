# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/yelp/yelp-2.11.1.ebuild,v 1.1 2005/08/20 00:09:42 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="Help browser for GNOME"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="firefox"

RDEPEND=">=gnome-base/orbit-2
	>=dev-libs/glib-2
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
	!firefox? ( >=www-client/mozilla-1.7.3 )
	firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	dev-libs/popt
	sys-libs/zlib
	app-arch/bzip2"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"


pkg_setup() {
	G2CONF="--enable-man --enable-info"

	if use firefox; then
		G2CONF="${G2CONF} --with-mozilla=firefox"
	else
		G2CONF="${G2CONF} --with-mozilla=mozilla"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.6.4-makedepfix.patch
}
