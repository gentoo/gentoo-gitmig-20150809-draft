# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-pilot-conduits/gnome-pilot-conduits-2.0.10.ebuild,v 1.1 2003/07/20 10:51:57 liquidx Exp $

inherit gnome2

DESCRIPTION="Gnome Pilot Conduits"
HOMEPAGE="http://www.eskil.org/gnome-pilot/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

RDEPEND=">=gnome-base/libgnome-2.0
	>=gnome-extra/gnome-pilot-${PV}
    >=dev-libs/libxml2-2.5"

DEPEND="sys-devel/gettext
	dev-util/pkgconfig
	${RDEPEND}"

G2CONF="${G2CONF} --enable-pilotlinktest"
SCROLLKEEPER_UPDATE="0"
