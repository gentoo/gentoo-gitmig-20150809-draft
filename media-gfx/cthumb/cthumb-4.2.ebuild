# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/cthumb/cthumb-4.2.ebuild,v 1.1 2002/12/02 16:35:12 mcummings Exp $

DESCRIPTION="Create a statical HTML Image gallery with captions for each image."

HOMEPAGE="http://cthumb.sourceforge.net"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/cthumb/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~sparc64 ~alpha"

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
