# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdlabelgen/cdlabelgen-2.4.0.ebuild,v 1.1 2002/08/17 23:21:32 aliz Exp $

DESCRIPTION="CD cover, tray card and envelope generator"
HOMEPAGE="http://www.aczone.com/tools/cdinsert"
SRC_URI="http://www.aczone.com/pub/tools/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND=">=perl-5.6.1"
DEPEND=""

S="${WORKDIR}/${P}"

src_compile() {
	patch -p1 -i ${FILESDIR}/makefile.patch-2.4.0
}

src_install () {
	emake DESTDIR="${D}" install || die "install problem"
	dodoc README INSTALL.WEB *.spec cdinsert.pl
	dohtml *.html
}
