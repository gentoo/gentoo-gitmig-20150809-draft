# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgtkhtml/libgtkhtml-3.2.5.ebuild,v 1.2 2005/03/18 15:15:51 dsd Exp $

inherit gnome2 versionator eutils

MY_P=${P/lib/}
MY_PN=${PN/lib/}
MY_MAJ_PV=$(get_version_component_range 1-2)

DESCRIPTION="Lightweight HTML Rendering/Printing/Editing Engine"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="mirror://gnome/sources/${MY_PN}/${MY_MAJ_PV}/${MY_P}.tar.bz2"
LICENSE="GPL-2 LGPL-2"

SLOT="3.2"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~alpha ~ia64 ~amd64 ~mips ~arm"
IUSE=""

S=${WORKDIR}/${MY_P}

RDEPEND=">=net-libs/libsoup-2.2.1
	>=x11-libs/gtk+-2.2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2.1
	>=x11-themes/gnome-icon-theme-1.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonoboui-2.2.4
	>=gnome-base/gail-1
	!=gnome-extra/libgtkhtml-3.1*"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.30
	>=dev-util/pkgconfig-0.12.0"

USE_DESTDIR="1"
SCROLLKEEPER_UPDATE="0"
ELTCONF="--reverse-deps"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-3.2-i18n.patch || die "gettext fix"
}

