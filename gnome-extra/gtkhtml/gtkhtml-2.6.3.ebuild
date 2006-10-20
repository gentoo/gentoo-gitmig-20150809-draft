# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-2.6.3.ebuild,v 1.3 2006/10/20 18:46:53 agriffis Exp $

inherit eutils gnome2 versionator

MY_P="lib${P}"
MY_PN="lib${PN}"
MY_MAJ_PV="$(get_version_component_range 1-2)"

DESCRIPTION="a Gtk+ based HTML rendering library"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="mirror://gnome/sources/${MY_PN}/${MY_MAJ_PV}/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1 GPL-2"
SLOT="2"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86"
IUSE="accessibility"

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

S=${WORKDIR}/${MY_P}

src_unpack() {

	unpack ${A}
	cd ${S}
	if use alpha; then
		epatch ${FILESDIR}/${MY_PN}-2.2.0-alpha.patch || die
	fi

}
