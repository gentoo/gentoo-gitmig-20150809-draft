# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/proj/proj-4.4.7.ebuild,v 1.5 2004/06/24 23:31:36 agriffis Exp $

DESCRIPTION="Cartographic projections library"
HOMEPAGE="http://www.remotesensing.org/proj/"
SRC_URI="ftp://ftp.remotesensing.org/pub/proj/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}
