# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/cmospwd/cmospwd-5.1.ebuild,v 1.1 2011/04/02 14:05:21 patrick Exp $

inherit toolchain-funcs

DESCRIPTION="CmosPwd decrypts password stored in cmos used to access BIOS SETUP"
HOMEPAGE="http://www.cgsecurity.org/wiki/CmosPwd"
SRC_URI="http://www.cgsecurity.org/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND=""
RDEPEND=""

src_compile() {
	cd src
	$(tc-getCC) ${CFLAGS} cmospwd.c -o cmospwd || die
}

src_install() {
	dosbin src/cmospwd || die
	dodoc cmospwd.txt || die
}
