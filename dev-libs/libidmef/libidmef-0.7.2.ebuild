# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libidmef/libidmef-0.7.2.ebuild,v 1.1 2004/01/09 09:56:54 mr_bones_ Exp $

DESCRIPTION="Implementation of the IDMEF XML draft"
HOMEPAGE="http://www.silicondefense.com/idwg/libidmef/"
SRC_URI="http://www.silicondefense.com/idwg/libidmef/${P}.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.5.6"

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc API AUTHORS ChangeLog FAQ NEWS README TODO || die "dodoc failed"
}
