# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdist/rdist-6.1.5-r1.ebuild,v 1.4 2004/07/15 03:23:10 agriffis Exp $

DESCRIPTION="Remote software distribution system"
HOMEPAGE="http://www.magnicomp.com/rdist/rdist.shtml"
SRC_URI="http://www.magnicomp.com/download/rdist/${P}.tar.gz"

LICENSE="RDist"
SLOT="1"
KEYWORDS="x86 sparc alpha ia64 ~ppc"
IUSE=""

DEPEND="dev-util/yacc >=sys-apps/sed-4"
RDEPEND=""  # yacc only needed for compile

src_unpack() {
	unpack ${A} && cd ${S} || die

	# Fix for bug 41781: Build with yacc instead of bison and change
	# the following #define (10 Mar 2004 agriffis)
	sed -i -e 's/^\(#define ARG_TYPE\).*/\1 ARG_STDARG/' config/os-linux.h
	assert "sed ARG_TYPE failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodir /usr/bin /usr/share/man/man{1,8}
	make install BIN_DIR=${D}/usr/bin || die "make install failed"
	make install.man \
		MAN_1_DIR=${D}/usr/share/man/man1 MAN_8_DIR=${D}/usr/share/man/man8 \
		|| die "make install.man failed"
}
