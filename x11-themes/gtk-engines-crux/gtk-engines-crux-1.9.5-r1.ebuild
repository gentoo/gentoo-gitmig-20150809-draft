# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-crux/gtk-engines-crux-1.9.5-r1.ebuild,v 1.3 2004/01/19 23:35:40 gustavoz Exp $

inherit gtk-engines2

MY_P=${P/gtk-engines-/}
IUSE=""
DESCRIPTION="GTK+2 Crux Theme Engine"
PVP=($(echo " $PV " | sed 's:[-\._]: :g'))
SRC_URI="mirror://gnome/crux/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"
KEYWORDS="x86 ~ppc sparc ~alpha hppa"
LICENSE="GPL-2"
SLOT="2"

DEPEND=">=x11-libs/gtk+-2
	!x11-themes/gnome-themes"

S=${WORKDIR}/${MY_P}


