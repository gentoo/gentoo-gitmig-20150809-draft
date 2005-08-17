# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-menus/gnome-menus-2.11.91.ebuild,v 1.1 2005/08/17 16:17:36 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="The GNOME menu system, implementing the F.D.O cross-desktop spec"
HOMEPAGE="http://www.gnome.org"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="python static"

RDEPEND=">=dev-libs/glib-2.6
	>=gnome-base/gnome-vfs-2.8.2
	python? ( >=dev-lang/python-2.2 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.31"

DOCS="AUTHORS ChangeLog HACKING NEWS README"

USE_DESTDIR="1"


pkg_setup() {
	G2CONF="$(use_enable static) $(use_enable python)"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Add a couple of important LegacyDir entries. See bug #97839.
	epatch ${FILESDIR}/${PN}-2.10.2-legacy_dirs.patch
}
