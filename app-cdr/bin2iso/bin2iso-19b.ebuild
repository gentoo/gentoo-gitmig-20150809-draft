# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/bin2iso/bin2iso-19b.ebuild,v 1.9 2003/02/13 05:59:15 vapier Exp $

DESCRIPTION="Bin2iso converts RAW format (.bin/.cue) files to ISO/WAV format.It can also create cue files for .bin's"
HOMEPAGE="http://users.andara.com/~doiron/bin2iso/"
SRC_URI="http://users.eastlink.ca/~doiron/bin2iso/linux/bin2iso19b_linux.c
	http://users.andara.com/~doiron/bin2iso/readme.txt"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="x86 ppc sparc "

src_unpack() {
	mkdir ${P}
	cd ${S}
	cp ${DISTDIR}/bin2iso19b_linux.c ${DISTDIR}/readme.txt .
}

src_compile() {
	gcc bin2iso19b_linux.c -o ${PN} ${CFLAGS} || die
}

src_install() {
	dosbin ${PN}
	dodoc readme.txt
}
