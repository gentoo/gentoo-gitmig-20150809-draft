# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgtkhtml/libgtkhtml-2.6.0.ebuild,v 1.1 2004/03/22 13:17:08 foser Exp $

inherit eutils gnome2

DESCRIPTION="a Gtk+ based HTML rendering library"
HOMEPAGE="http://www.gnome.org/"
LICENSE="LGPL-2.1 GPL-2"

IUSE="accessibility"
SLOT="1"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips"

# FIXME : seems only testapps need gnomevfs

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/libxml2-2.4.16
	>=gnome-base/gnome-vfs-2
	accessibility? ( >=gnome-base/gail-1.3 )"

DEPEND="${RDEPEND}
	 >=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} $(use_enable accessibility)"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS  README TODO docs/IDEAS"
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {

	unpack ${A}
	cd ${S}
	if use alpha; then
		epatch ${FILESDIR}/${PN}-2.2.0-alpha.patch || die
	fi

}
