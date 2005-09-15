# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/mode2cdmaker/mode2cdmaker-1.5.1.ebuild,v 1.3 2005/09/15 20:40:18 mr_bones_ Exp $

DESCRIPTION="Utility to create mode-2 CDs, for example XCDs."
HOMEPAGE="http://webs.ono.com/usr016/de_xt/mcf.html"
SRC_URI="http://dext.peque.org/xcd/${P}-src.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -e 's:gcc -c:gcc $(CFLAGS) -DMAX_PATH=512 -c:g' \
		Makefile.linux > Makefile || die "sed failed"
	sed -i -e 's:lstrlen:strlen:g' mkvcdfs.c || die "sed failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin mode2cdmaker || die "dobin failed"
	dodoc bugs.txt compatibility.txt readme.txt
}
