# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/openbox-themes/openbox-themes-0.2.ebuild,v 1.6 2004/05/06 15:06:02 ciaranm Exp $

DESCRIPTION="A set of themes for Openbox3."
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://home.clara.co.uk/dpb/openbox.htm"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
IUSE=""
SLOT="0"

DEPEND=">=x11-wm/openbox-3.0_beta6"

src_install() {
	dodir /usr/share/themes
	cp -a ${WORKDIR}/* ${D}/usr/share/themes
}
