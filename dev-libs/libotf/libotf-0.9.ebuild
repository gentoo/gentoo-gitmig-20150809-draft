# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libotf/libotf-0.9.ebuild,v 1.3 2004/06/14 16:55:31 usata Exp $

DESCRIPTION="Library for handling OpenType fonts (OTF)"
HOMEPAGE="http://www.m17n.org/libotf/"
SRC_URI="http://www.m17n.org/libotf/${P}.tar.gz"

LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=media-libs/freetype-2.1"

src_install() {

	make DESTDIR=${D} install || die

	dodoc AUTHORS INSTALL NEWS README ChangeLog
}
