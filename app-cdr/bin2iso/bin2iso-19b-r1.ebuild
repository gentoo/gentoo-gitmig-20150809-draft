# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/bin2iso/bin2iso-19b-r1.ebuild,v 1.6 2003/04/25 22:50:39 taviso Exp $

DESCRIPTION="Bin2iso converts RAW format (.bin/.cue) files to ISO/WAV format.It can also create cue files for .bin's"
HOMEPAGE="http://users.andara.com/~doiron/bin2iso/"
LICENSE="public-domain"
DEPEND="virtual/glibc"

SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~alpha"

SRC_URI="http://users.eastlink.ca/~doiron/bin2iso/linux/bin2iso19b_linux.c
	http://users.andara.com/~doiron/bin2iso/readme.txt"
S=${WORKDIR}/${P}

src_unpack() {
	mkdir ${P}
	cd ${S}
	cp ${DISTDIR}/bin2iso19b_linux.c ${DISTDIR}/readme.txt .
}

src_compile() {
	cd ${S}
	gcc bin2iso19b_linux.c -o ${PN} ${CFLAGS} || die
}

src_install() {
	dobin ${PN}
	dodoc readme.txt
}
