# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/mode2cdmaker/mode2cdmaker-1.5.1.ebuild,v 1.2 2005/04/05 12:17:04 pylon Exp $

DESCRIPTION="Utility to create mode-2 CDs, for example XCDs."
HOMEPAGE="http://webs.ono.com/usr016/de_xt/mcf.html"
SRC_URI="http://dext.peque.org/xcd/${P}-src.zip"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=""
S=${WORKDIR}

src_compile() {
	sed -e 's:gcc -c:gcc $(CFLAGS) -DMAX_PATH=512 -c:g' < Makefile.linux > Makefile
	sed -i 's:lstrlen:strlen:g' mkvcdfs.c

	emake || die
}

src_install() {
	dobin mode2cdmaker
	dodoc bugs.txt compatibility.txt readme.txt
}
