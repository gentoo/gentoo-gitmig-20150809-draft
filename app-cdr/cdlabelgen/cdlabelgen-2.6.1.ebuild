# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdlabelgen/cdlabelgen-2.6.1.ebuild,v 1.3 2003/09/22 22:31:36 zul Exp $

DESCRIPTION="CD cover, tray card and envelope generator"
HOMEPAGE="http://www.aczone.com/tools/cdinsert"
SRC_URI="http://www.aczone.com/pub/tools/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

RDEPEND=">=perl-5.6.1"
DEPEND="sys-apps/tar
	sys-apps/gzip"

S="${WORKDIR}/${P}"

src_compile() {
	cp Makefile Makefile.bak
	sed -e "s:BASE_DIR   = /usr/local:BASE_DIR   = ${D}/usr:g" \
		-e "s:LIB_DIR   = \$(BASE_DIR)/lib/cdlabelgen:LIB_DIR   = \$(BASE_DIR)/share/cdlabelgen:g" \
		-e "s:\$(INSTALL) cdlabelgen.1 \$(MAN_DIR)/man1::g" \
			Makefile.bak > Makefile
	
}

src_install() {
	emake  install || die "install problem"
	dodoc README INSTALL.WEB *.spec cdinsert.pl
	dohtml *.html

	doman cdlabelgen.1
}
