# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/jbigkit/jbigkit-1.4.ebuild,v 1.8 2003/03/31 02:24:44 rac Exp $

S="${WORKDIR}/${PN}"
DESCRIPTION="JBIG-KIT implements a highly effective data compression algorithm for bi-level high-resolution images such as fax pages or scanned documents"
SRC_URI="http://www.cl.cam.ac.uk/~mgk25/download/${P}.tar.gz"
HOMEPAGE="http://www.cl.cam.ac.uk/~mgk25/jbigkit/"

LICENSE="GPL-2"
IUSE=""
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha"
DEPEND="virtual/glibc"

src_compile() {
	cp Makefile Makefile.orig
	sed -e "s:-O2 -W:${CFLAGS}:" \
		< Makefile.orig > Makefile

	make || die "make failed"

	make test || die "tests failed"
}

src_install() {
	dolib libjbig/libjbig.a

	insinto /usr/include
	newins libjbig/jbig.h jbig.h

	# Install documentation.
	dodoc ANNOUNCE CHANGES COPYING INSTALL TODO
}
