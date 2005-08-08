# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgtkhtml/libgtkhtml-3.6.2.ebuild,v 1.7 2005/08/08 14:54:16 corsair Exp $

inherit versionator gnome2

MY_P=${P/lib/}
MY_PN=${PN/lib/}
MY_MAJ_PV=$(get_version_component_range 1-2)

DESCRIPTION="Lightweight HTML Rendering/Printing/Editing Engine"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="mirror://gnome/sources/${MY_PN}/${MY_MAJ_PV}/${MY_P}.tar.bz2"
LICENSE="GPL-2 LGPL-2"

SLOT="3.6"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="static"

S=${WORKDIR}/${MY_P}

RDEPEND=">=net-libs/libsoup-2.1.6
	>=x11-libs/gtk+-2.2
	>=gnome-base/libgnomeui-1.112.1
	>=gnome-base/libgnomeprint-2.8
	>=gnome-base/libgnomeprintui-2.2.1
	>=x11-themes/gnome-icon-theme-1.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonoboui-2.2.4
	>=gnome-base/orbit-2
	>=gnome-base/gail-0.13
	!=gnome-extra/libgtkhtml-3.1*"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.30
	dev-util/pkgconfig"

USE_DESTDIR="1"
SCROLLKEEPER_UPDATE="0"
ELTCONF="--reverse-deps"

DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"
G2CONF="${G2CONF} $(use_enable static)"
