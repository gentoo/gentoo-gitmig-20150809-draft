# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gnome-pilot-conduits/gnome-pilot-conduits-2.0.8.ebuild,v 1.2 2003/09/11 00:57:51 msterret Exp $

inherit gnome.org gnome2

DESCRIPTION="Gnome Pilot Conduits"
HOMEPAGE="http://www.eskil.org/gnome-pilot/"

RDEPEND=">=gnome-base/libgnome-2.0
	>=app-pda/gnome-pilot-2.0.8
	>=dev-libs/libxml2-2.5"

DEPEND="sys-devel/gettext
		${RDEPEND}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"
IUSE=""

G2CONF="--enable-pilotlinktest"
SCROLLKEEPER_UPDATE="0"
