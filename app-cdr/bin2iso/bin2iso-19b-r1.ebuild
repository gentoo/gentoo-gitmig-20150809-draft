# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/bin2iso/bin2iso-19b-r1.ebuild,v 1.10 2004/01/24 06:20:06 mr_bones_ Exp $

DESCRIPTION="Bin2iso converts RAW format (.bin/.cue) files to ISO/WAV format.It can also create cue files for .bin's"
HOMEPAGE="http://users.andara.com/~doiron/bin2iso/"
SRC_URI="http://users.eastlink.ca/~doiron/bin2iso/linux/bin2iso19b_linux.c
	http://users.andara.com/~doiron/bin2iso/readme.txt"

KEYWORDS="x86 ppc sparc alpha"
LICENSE="public-domain"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {
	mkdir "${P}"
	cd "${S}"
	cp "${DISTDIR}/bin2iso19b_linux.c" "${DISTDIR}/readme.txt" . \
		|| die "cp failed"
}

src_compile() {
	${CC:-gcc} bin2iso19b_linux.c -o ${PN} ${CFLAGS} || die "compile failed"
}

src_install() {
	dobin ${PN}      || die "dobin failed"
	dodoc readme.txt || die "dodoc failed"
}
