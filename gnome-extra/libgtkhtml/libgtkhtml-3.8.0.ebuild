# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgtkhtml/libgtkhtml-3.8.0.ebuild,v 1.1 2005/09/06 16:02:44 leonardop Exp $

inherit gnome2

MY_PN=${PN/lib/}
MY_P="${MY_PN}-${PV}"
PVP=(${PV//[-\._]/ })

DESCRIPTION="Lightweight HTML Rendering/Printing/Editing Engine"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="mirror://gnome/sources/${MY_PN}/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"
LICENSE="GPL-2 LGPL-2"

SLOT="3.8"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="static"

S=${WORKDIR}/${MY_P}

RDEPEND=">=gnome-base/gail-1.1
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomeprintui-2.2.1
	>=gnome-base/libglade-2
	>=gnome-base/libbonoboui-2.2.4
	>=gnome-base/orbit-2
	>=gnome-base/libbonobo-2
	>=net-libs/libsoup-2.1.6
	>=x11-libs/gtk+-2.4
	>=x11-themes/gnome-icon-theme-1.2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.30
	>=dev-util/pkgconfig-0.9"

USE_DESTDIR="1"
ELTCONF="--reverse-deps"

DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"


pkg_setup() {
	G2CONF="$(use_enable static)"
}
