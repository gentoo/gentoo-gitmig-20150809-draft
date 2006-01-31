# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdbackup/dvdbackup-0.1.1-r1.ebuild,v 1.9 2006/01/31 14:56:06 josejx Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Backup content from DVD to hard disk"
HOMEPAGE="http://dvd-create.sourceforge.net/"
SRC_URI="http://dvd-create.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc-macos ppc64 sparc x86"
IUSE=""

DEPEND="media-libs/libdvdread"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-debian-FPE.patch
}

src_compile() {
	$(tc-getCC) ${CFLAGS} -I/usr/include/dvdread \
		-ldvdread -o dvdbackup src/dvdbackup.c \
		|| die "compile failed"
}

src_install() {
	dobin dvdbackup || die
	dodoc README
}
