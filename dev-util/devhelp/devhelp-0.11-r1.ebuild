# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/devhelp/devhelp-0.11-r1.ebuild,v 1.1 2006/07/03 15:30:13 allanonjl Exp $

inherit eutils gnome2

DESCRIPTION="An API documentation browser for GNOME 2"
HOMEPAGE="http://www.imendio.com/projects/devhelp"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="firefox zlib"

RDEPEND=">=x11-libs/gtk+-2.6
		 >=dev-libs/glib-2.6
		 >=gnome-base/gconf-2.6
		 >=gnome-base/libglade-2.4
		 >=x11-libs/libwnck-2.10
		 >=gnome-base/gnome-vfs-2.2
		   sys-devel/gettext
		 sparc? ( >=www-client/mozilla-firefox-1.0.2-r1 )
		 firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )
		 !sparc? ( !firefox?	( www-client/seamonkey ) )
		 zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog README NEWS TODO"

pkg_setup() {
	G2CONF="$(use_with zlib)"

	if use firefox  || use sparc; then
		G2CONF="${G2CONF} --with-mozilla=firefox"
	else
		G2CONF="${G2CONF} --with-mozilla=seamonkey"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patch to build cleanly against the mozilla component
	epatch ${FILESDIR}/${PN}-0.11-mozilla-includes.patch
}
