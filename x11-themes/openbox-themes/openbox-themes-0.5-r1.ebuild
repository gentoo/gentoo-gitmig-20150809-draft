# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/openbox-themes/openbox-themes-0.5-r1.ebuild,v 1.4 2004/01/24 15:14:37 tseng Exp $

DESCRIPTION="A set of themes for Openbox3."
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://home.clara.co.uk/dpb/openbox.htm"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE="gnome"
SLOT="0"
S=${WORKDIR}/${P}

DEPEND=">=x11-wm/openbox-3.0_beta6
		gnome? ( >=x11-themes/gtk-engines-thinice-2 )"

src_install() {
	dodir /usr/share/themes
	cp -a ${S}/* ${D}/usr/share/themes
}
