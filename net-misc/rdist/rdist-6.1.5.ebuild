# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdist/rdist-6.1.5.ebuild,v 1.9 2004/07/15 03:23:10 agriffis Exp $

DESCRIPTION="Remote software distribution system"
HOMEPAGE="http://www.magnicomp.com/rdist/rdist.shtml"
SRC_URI="http://www.magnicomp.com/download/rdist/${P}.tar.gz"

LICENSE="RDist"
SLOT="1"
KEYWORDS="x86 sparc "
IUSE=""

DEPEND="sys-devel/bison"
RDEPEND=""  # bison only needed for compile

src_compile() {
	emake YACC="bison -y" || die "emake failed"
}

src_install() {
	dodir /usr/bin /usr/share/man/man{1,8}
	make install BIN_DIR=${D}/usr/bin || die "make install failed"
	make install.man \
		MAN_1_DIR=${D}/usr/share/man/man1 MAN_8_DIR=${D}/usr/share/man/man8 \
		|| die "make install.man failed"
}
