# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/nestra/nestra-0.66.ebuild,v 1.3 2003/07/18 22:59:32 vapier Exp $

inherit games eutils

PATCH="${P/-/_}-6.diff"
DESCRIPTION="NES emulation for Linux/x86"
HOMEPAGE="http://nestra.linuxgames.com/"
SRC_URI="http://nestra.linuxgames.com/${P}.tar.gz
	http://ftp.debian.org/debian/pool/contrib/n/nestra/${PATCH}.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/x11"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${PATCH}
	sed -i \
		's:-O2 ::' \
		"s:gcc:gcc ${CFLAGS}:" \
		Makefile
}

src_compile() {
	make || die "compile failed"
}

src_install() {
	dogamesbin nestra
	dodoc BUGS CHANGES README
	doman nestra.6
	prepgamesdirs
}
