# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/antiword/antiword-0.33.ebuild,v 1.11 2003/04/14 17:03:48 agriffis Exp $

IUSE="kde"

DESCRIPTION="free MS Word reader for Linux and RISC OS"
SRC_URI="http://www.winfield.demon.nl/linux/${P}.tar.gz"
HOMEPAGE="http://www.winfield.demon.nl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND=">=sys-apps/sed-4.0.5
	app-text/ghostscript"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e 's/-pedantic//' \
		-e 's/$(CFLAGS)/$(CFLAGS) -D$(DB)/' \
		Makefile.Linux
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
