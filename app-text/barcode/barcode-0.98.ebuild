# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/barcode/barcode-0.98.ebuild,v 1.2 2003/02/13 09:32:45 vapier Exp $

DESCRIPTION="GNU/Barcode - A barcode generator"
SRC_URI="mirror://gnu/barcode/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/barcode/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	econf
	make || die
}

src_install() {
	einstall
	prepinfo
	dodoc ChangeLog README TODO doc/barcode.{pdf,ps}
}
