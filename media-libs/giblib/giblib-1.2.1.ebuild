# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/giblib/giblib-1.2.1.ebuild,v 1.7 2003/02/13 12:44:01 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Giblib, graphics library"
HOMEPAGE="http://www.libuxbrit.co.uk/"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"

SLOT="0"
LICENSE="as-is|BSD"
KEYWORDS="x86 sparc "

DEPEND=">=media-libs/imlib2-1.0.3
	>=media-libs/freetype-2.0"

src_compile() {
	econf || die
	emake || die
}

src_install () {	
	make prefix=${D}/usr install || die
	rm -rf ${D}/usr/doc
	dodoc TODO README AUTHORS ChangeLog
}
