# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-pilot-conduits/gnome-pilot-conduits-2.0.5.ebuild,v 1.1 2003/04/21 14:53:44 liquidx Exp $

IUSE=""

inherit gnome.org gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Gnome Pilot Conduits"
HOMEPAGE="http://www.eskil.org/gnome-pilot/"

RDEPEND=">=gnome-base/libgnome-2.0
	>=gnome-extra/gnome-pilot-2.0.1
    >=dev-libs/libxml2-2.5"

DEPEND="sys-devel/gettext
		${RDEPEND}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

src_compile() {
	gnome2_src_compile "--enable-pilotlinktest"
}

SCROLLKEEPER_UPDATE="0"
