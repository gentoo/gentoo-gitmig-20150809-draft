# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/bin2iso/bin2iso-19b.ebuild,v 1.6 2002/10/04 03:53:50 vapier Exp $

DESCRIPTION="Bin2iso converts RAW format (.bin/.cue) files to ISO/WAV format.It can also create cue files for .bin's"
HOMEPAGE="http://users.andara.com/~doiron/bin2iso/"
S=${WORKDIR}/${P}
SLOT="0"

DEPEND="virtual/glibc"
RDEPEND=""
LICENSE="public-domain"
KEYWORDS="x86 ppc sparc sparc64"

SRC_URI="http://users.eastlink.ca/~doiron/bin2iso/linux/bin2iso19b_linux.c
	http://users.andara.com/~doiron/bin2iso/readme.txt"

src_unpack() {
	mkdir ${P}
	cd ${S}
	cp ${DISTDIR}/bin2iso19b_linux.c ${DISTDIR}/readme.txt .
}

src_compile() {
	cd ${S}
	gcc bin2iso19b_linux.c -o ${PN} ${CFLAGS} || die
}

src_install () {

	dosbin ${PN}
	dodoc readme.txt

}
