# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/bin2iso/bin2iso-19b-r1.ebuild,v 1.12 2004/01/28 02:52:09 vapier Exp $

inherit gcc

DESCRIPTION="converts RAW format (.bin/.cue) files to ISO/WAV format"
HOMEPAGE="http://users.andara.com/~doiron/bin2iso/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="virtual/glibc"

S=${WORKDIR}/${PN}

src_compile() {
	$(gcc-getCC) bin2iso19b_linux.c -o ${PN} ${CFLAGS} || die "compile failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
	dodoc readme.txt
}
