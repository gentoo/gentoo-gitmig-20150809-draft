# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdlabelgen/cdlabelgen-3.0.0.ebuild,v 1.5 2004/03/21 13:38:50 mholzer Exp $

DESCRIPTION="CD cover, tray card and envelope generator"
HOMEPAGE="http://www.aczone.com/tools/cdinsert"
SRC_URI="http://www.aczone.com/pub/tools/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc"

RDEPEND=">=dev-lang/perl-5.6.1"
DEPEND="app-arch/tar
	app-arch/gzip"

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
