# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-thinice/gtk-engines-thinice-2.0.2-r1.ebuild,v 1.9 2004/01/29 04:49:45 agriffis Exp $

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
KEYWORDS="x86 amd64 hppa sparc alpha ia64"
LICENSE="GPL-2"
SLOT="2"

GTK1_S=${WORKDIR}/${GTK1_PN}-${GTK1_VER}
GTK2_S=${WORKDIR}/${GTK2_PN}-${GTK2_VER}

src_unpack() {
	unpack ${A}
	if [ -d "${GTK1_S}" -a "${ARCH}" = "amd64" ]; then
		cd ${GTK1_S}
		aclocal
		autoheader
		automake -a -c
		autoconf
		libtoolize -c -f
	fi
}
