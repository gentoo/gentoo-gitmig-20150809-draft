# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines/gtk-engines-2.6.3.ebuild,v 1.10 2005/06/23 07:45:21 gmsoft Exp $

inherit gtk-engines2 gnuconfig

GTK1_VER="0.12"
GTK2_VER="${PV}"
PVP=($(echo " $PV " | sed 's:[-\._]: :g'))

DESCRIPTION="GTK+1 and GTK+2 Theme Engines from GNOME including Pixmap, Metal, Raleigh, Redmond95, Raleigh and Notif"
SRC_URI="mirror://gnome/sources/${PN}/${GTK1_VER}/${PN}-${GTK1_VER}.tar.gz
	mirror://gnome/sources/${PN}/${PVP[0]}.${PVP[1]}/${PN}-${GTK2_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="${DEPEND}
	!x11-themes/gtk-engines-crux
	!x11-themes/gtk-engines-lighthouseblue
	!x11-themes/gtk-engines-metal
	!x11-themes/gtk-engines-mist
	!x11-themes/gtk-engines-redmond95
	!x11-themes/gtk-engines-smooth
	!>=x11-themes/gtk-engines-thinice-2
	!<=x11-themes/gnome-themes-2.8.2"

#PROVIDE="x11-themes/gtk-engines-metal 
#	x11-themes/gtk-engines-pixbuf 
#	x11-themes/gtk-engines-raleigh
#	x11-themes/gtk-engines-redmond95"

[ -n "${HAS_GTK1}" ] && DEPEND="${DEPEND} >=media-libs/imlib-1.8"

GTK1_S=${WORKDIR}/${PN}-${GTK1_VER}
GTK2_S=${WORKDIR}/${PN}-${GTK2_VER}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fix_clearlooks_path.patch
	if use alpha || use amd64 || use ppc64 ; then
		gnuconfig_update || die 'gnuconfig_update failed'
		( cd $GTK1_S && libtoolize --force ) || die 'libtoolize1 failed'
		( cd $GTK2_S && libtoolize --force ) || die 'libtoolize2 failed'
	fi
}
