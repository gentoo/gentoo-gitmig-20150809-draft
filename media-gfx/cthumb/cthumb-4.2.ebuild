# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/cthumb/cthumb-4.2.ebuild,v 1.7 2004/06/24 22:34:13 agriffis Exp $

DESCRIPTION="Create a statical HTML Image gallery with captions for each image."

HOMEPAGE="http://cthumb.sourceforge.net"
SRC_URI="mirror://sourceforge/cthumb/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha"

DEPEND="dev-perl/URI
	dev-perl/HTML-Parser
	media-libs/netpbm"

S="${WORKDIR}/${P}"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
}
