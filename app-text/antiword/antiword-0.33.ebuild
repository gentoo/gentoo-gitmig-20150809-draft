# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/antiword/antiword-0.33.ebuild,v 1.13 2004/02/22 07:21:14 mr_bones_ Exp $

IUSE="kde"

DESCRIPTION="free MS Word reader for Linux and RISC OS"
SRC_URI="http://www.winfield.demon.nl/linux/${P}.tar.gz"
HOMEPAGE="http://www.winfield.demon.nl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND=">=sys-apps/sed-4.0.5
	virtual/ghostscript"

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
