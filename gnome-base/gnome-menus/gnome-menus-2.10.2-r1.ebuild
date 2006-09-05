# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-menus/gnome-menus-2.10.2-r1.ebuild,v 1.13 2006/09/05 02:02:00 kumba Exp $

inherit eutils gnome2

DESCRIPTION="The GNOME menu system, implementing the F.D.O cross-desktop spec"
HOMEPAGE="http://www.gnome.org"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="debug static"

RDEPEND=">=dev-libs/glib-2.5.6
	>=gnome-base/gnome-vfs-2.8.2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.31"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

USE_DESTDIR="1"


pkg_setup() {
	G2CONF="$(use_enable static)"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Add a couple of important LegacyDir entries. See bug #97839.
	epatch ${FILESDIR}/${P}-legacy_dirs.patch
}
