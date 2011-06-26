# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/cmospwd/cmospwd-4.6.ebuild,v 1.6 2011/06/26 06:15:22 radhermit Exp $

inherit toolchain-funcs

DESCRIPTION="CmosPwd decrypts password stored in cmos used to access BIOS SETUP"
HOMEPAGE="http://www.cgsecurity.org/index.html?cmospwd.html"
SRC_URI="http://www.cgsecurity.org/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

src_compile() {
	cd src
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} cmospwd.c -o cmospwd || die
}

src_install() {
	dosbin src/cmospwd || die
	dodoc cmospwd.txt || die
}
