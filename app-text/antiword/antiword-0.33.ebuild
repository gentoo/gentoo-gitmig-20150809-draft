# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/antiword/antiword-0.33.ebuild,v 1.7 2003/03/01 04:12:35 vapier Exp $

DESCRIPTION="free MS Word reader for Linux and RISC OS"
SRC_URI="http://www.winfield.demon.nl/linux/${P}.tar.gz"
HOMEPAGE="http://www.winfield.demon.nl"

IUSE="kde"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND="app-text/ghostscript"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -e '/pedantic/d' -e 's/$(CFLAGS)/$(CFLAGS) -D$(DB)/' \
		Makefile.Linux > Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin antiword
	use kde && dobin kantiword

	insinto /usr/share/${PN}
	doins Resources/*

	cd Docs
	doman antiword.1
	dodoc COPYING ChangeLog FAQ History Netscape QandA ReadMe
}
