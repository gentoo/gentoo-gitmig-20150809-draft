# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/tic98/tic98-1.01.ebuild,v 1.8 2004/07/15 02:41:15 agriffis Exp $

DESCRIPTION="tic98 is a compressor for black-and-white images, in particular scanned documents. It gets very good compression, better than AT&T's DjVu system.  tic98 also includes ppmd text compression (ppmd) and number compression (b_gamma_enc)"
HOMEPAGE="http://www.cs.waikato.ac.nz/~singlis/"
SRC_URI="http://www.cs.waikato.ac.nz/~singlis/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""

S="${WORKDIR}/${PN}"

src_compile() {
	patch -p1 < ${FILESDIR}/${P}-gentoo.diff
	patch -p1 < $FILESDIR/${PN}.diff
	emake all || die
	emake all2 || die
}

src_install() {
	dodir /usr
	dodir /usr/bin
	make BIN=${D}usr/bin install || die
}
