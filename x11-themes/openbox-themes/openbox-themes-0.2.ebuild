# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header :$

DESCRIPTION="A set of themes for Openbox3."
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://home.clara.co.uk/dpb/openbox.htm"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""
SLOT="0"

DEPEND=">=x11-wm/openbox-3.0_beta4"

src_install() {
	dodir /usr/share/themes
	cp -a ${WORKDIR}/* ${D}/usr/share/themes
}
