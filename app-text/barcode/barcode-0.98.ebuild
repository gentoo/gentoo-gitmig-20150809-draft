# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/barcode/barcode-0.98.ebuild,v 1.3 2003/10/28 17:37:53 vapier Exp $

DESCRIPTION="barcode generator"
HOMEPAGE="http://www.gnu.org/software/barcode/"
SRC_URI="mirror://gnu/barcode/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-info.patch
	sed -i \
		-e 's:/info:/share/info:' \
		-e 's:/man/:/share/man/:' \
		Makefile.in
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	emake install prefix=${D}/usr || die
	dodoc ChangeLog README TODO doc/barcode.{pdf,ps}
}
