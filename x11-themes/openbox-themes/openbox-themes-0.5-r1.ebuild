# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/openbox-themes/openbox-themes-0.5-r1.ebuild,v 1.7 2004/03/20 19:47:30 zx Exp $

DESCRIPTION="A set of themes for Openbox3."
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://gumerry.co.uk/themes/"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64 ~hppa"
IUSE="gnome"
SLOT="0"
S=${WORKDIR}/${P}

DEPEND=">=x11-wm/openbox-3.0_beta6
		gnome? ( >=x11-themes/gtk-engines-thinice-2 )"

src_install() {
	dodir /usr/share/themes
	cp -a ${S}/* ${D}/usr/share/themes
}
