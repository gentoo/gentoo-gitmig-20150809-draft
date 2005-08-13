# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/devhelp/devhelp-0.10.ebuild,v 1.4 2005/08/13 23:30:09 hansmi Exp $

inherit eutils gnome2

DESCRIPTION="An API documentation browser for GNOME 2"
HOMEPAGE="http://www.imendio.com/projects/devhelp"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE="zlib firefox"

RDEPEND=">=x11-libs/gtk+-2.6
	>=gnome-base/gnome-vfs-2.2
	>=gnome-base/libglade-2
	firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )
	!firefox? ( www-client/mozilla )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS COPYING ChangeLog README NEWS TODO"

pkg_setup() {
	G2CONF="$(use_with zlib)"

	if use firefox ; then
		G2CONF="${G2CONF} --with-mozilla=firefox"
	else
		G2CONF="${G2CONF} --with-mozilla=mozilla"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# fix mozilla includes
	epatch ${FILESDIR}/${P}-fix_includes.patch
}
