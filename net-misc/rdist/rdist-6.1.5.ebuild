# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdist/rdist-6.1.5.ebuild,v 1.2 2002/08/14 12:08:08 murphy Exp $

DESCRIPTION="Remote software distribution system"
HOMEPAGE="http://www.magnicomp.com/rdist/rdist.shtml"
SRC_URI="http://www.magnicomp.com/download/rdist/${P}.tar.gz"
LICENSE="RDist"
SLOT="1"
KEYWORDS="x86 sparc sparc64"
DEPEND="dev-util/yacc"
RDEPEND=""  # yacc only needed for compile
S=${WORKDIR}/${P}

src_compile() {
	emake || die "emake failed"
}

src_install () {
	mkdir -p ${D}/usr/bin ${D}/usr/share/man/man{1,8}
	make install BIN_DIR=${D}/usr/bin || die "make install failed"
	make install.man \
		MAN_1_DIR=${D}/usr/share/man/man1 MAN_8_DIR=${D}/usr/share/man/man8 \
		|| die "make install.man failed"
}
