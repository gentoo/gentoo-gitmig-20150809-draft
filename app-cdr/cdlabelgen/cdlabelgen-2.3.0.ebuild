# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdlabelgen/cdlabelgen-2.3.0.ebuild,v 1.2 2002/08/14 09:29:26 pvdabeel Exp $

DESCRIPTION="CD cover, tray card and envelope generator"
HOMEPAGE="http://www.aczone.com/tools/cdinsert"
SRC_URI="http://www.aczone.com/pub/tools/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND=">=perl-5.6.1"
DEPEND=""

S="${WORKDIR}/${P}"

src_compile() {
	patch -p0 -i ${FILESDIR}/makefile.patch
}

src_install () {
	emake DESTDIR="${D}" install || die "install problem"
	dodoc README INSTALL.WEB *.spec cdinsert.pl
	dohtml *.html
}
