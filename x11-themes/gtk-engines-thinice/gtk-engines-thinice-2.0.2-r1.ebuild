# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-thinice/gtk-engines-thinice-2.0.2-r1.ebuild,v 1.1 2003/06/19 09:51:44 liquidx Exp $

inherit gtk-engines2

GTK1_VER="1.0.4"
GTK2_VER="${PV}"
GTK1_PN=${PN/gtk-engines-thinice/gtk-thinice-theme}
GTK2_PN=${PN/gtk-engines-thinice/gtk-thinice-engine}

IUSE=""
DESCRIPTION="GTK+1 and GTK+2 ThinIce Theme Engine"
SRC_URI="mirror://sourceforge/thinice/${GTK1_PN}-${GTK1_VER}.tar.gz
	mirror://sourceforge/thinice/${GTK2_PN}-${GTK2_VER}.tar.gz"
HOMEPAGE="http://thinice.sourceforge.net/"
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="2"

GTK1_S=${WORKDIR}/${GTK1_PN}-${GTK1_VER}
GTK2_S=${WORKDIR}/${GTK2_PN}-${GTK2_VER}
