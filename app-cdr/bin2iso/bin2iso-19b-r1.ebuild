# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/bin2iso/bin2iso-19b-r1.ebuild,v 1.16 2004/06/27 21:10:43 vapier Exp $

inherit gcc

DESCRIPTION="converts RAW format (.bin/.cue) files to ISO/WAV format"
HOMEPAGE="http://users.andara.com/~doiron/bin2iso/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_compile() {
	$(gcc-getCC) bin2iso19b_linux.c -o ${PN} ${CFLAGS} || die "compile failed"
}

src_install() {
	dobin ${PN} || die "dobin failed"
	dodoc readme.txt
}
