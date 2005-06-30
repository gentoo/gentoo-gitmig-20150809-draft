# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines/gtk-engines-2.2.0.ebuild,v 1.23 2005/06/30 23:21:55 leonardop Exp $

inherit gtk-engines2 gnuconfig

GTK1_VER="0.12"
GTK2_VER="${PV}"
PVP=(${PV//[-._]/ })

DESCRIPTION="GTK+1 and GTK+2 Theme Engines from GNOME including Pixmap, Metal, Raleigh, Redmond95, Raleigh and Notif"
SRC_URI="mirror://gnome/sources/${PN}/${GTK1_VER}/${PN}-${GTK1_VER}.tar.gz
	mirror://gnome/sources/${PN}/${PVP[0]}.${PVP[1]}/${PN}-${GTK2_VER}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 mips ppc64 arm"
IUSE=""

[ -n "${HAS_GTK1}" ] && DEPEND="${DEPEND} >=media-libs/imlib-1.8"

GTK1_S=${WORKDIR}/${PN}-${GTK1_VER}
GTK2_S=${WORKDIR}/${PN}-${GTK2_VER}

src_unpack() {
	unpack ${A}
	if use alpha || use amd64 || use ppc64 ; then
		gnuconfig_update || die 'gnuconfig_update failed'
		( cd $GTK1_S && libtoolize --force ) || die 'libtoolize1 failed'
		( cd $GTK2_S && libtoolize --force ) || die 'libtoolize2 failed'
	fi
}
