# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/antiword/antiword-0.33.ebuild,v 1.1 2002/08/14 16:58:26 satai Exp $

S=${WORKDIR}/${PN}-0.33
DESCRIPTION="Antiword is a free MS Word reader for Linux and RISC OS"
SRC_URI="http://www.winfield.demon.nl/linux/${P}.tar.gz"
HOMEPAGE="http://www.winfield.demon.nl"

DEPEND="app-text/ghostscript
	"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_unpack() {
	unpack ${A}
	
	cd ${S}
	#patch -p0 < ${FILESDIR}/gentoo-antiword.diff

	rm Makefile

	sed -e '/pedantic/d' -e 's/$(CFLAGS)/$(CFLAGS) -D$(DB)/' \
		Makefile.Linux > Makefile
}

src_compile() {
	emake || die
}

src_install () {
	dobin antiword

	if [ `use kde` ]
	then
		dobin kantiword
	fi

	cd Docs
	doman antiword.1
	dodoc COPYING ChangeLog FAQ History Netscape QandA ReadMe

	cd ..
	insinto /usr/share/${PN}
	doins Resources/*
}
