# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdbackup/dvdbackup-0.1.1-r1.ebuild,v 1.1 2004/04/09 06:22:46 vapier Exp $

inherit gcc eutils

DESCRIPTION="Backup content from DVD to hard disk"
HOMEPAGE="http://dvd-create.sourceforge.net/"
SRC_URI="http://dvd-create.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc amd64"
IUSE=""

DEPEND="media-libs/libdvdread"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-debian-FPE.patch
}

src_compile() {
	$(gcc-getCC) ${CFLAGS} -I/usr/include/dvdread \
		-ldvdread -o dvdbackup src/dvdbackup.c \
		|| die "compile failed"
}

src_install() {
	dobin dvdbackup || die
	dodoc README
}
