# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rawrec/rawrec-0.9.98.ebuild,v 1.8 2004/09/15 17:21:26 eradicator Exp $

IUSE=""

DESCRIPTION="CLI program to play and record audiofiles."
HOMEPAGE="http://rawrec.sourceforge.net/"
SRC_URI="mirror://sourceforge/rawrec/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha amd64"
DEPEND="virtual/libc"

S=${S}/src

src_compile() {
	make || die
}

src_install() {
	make EXE_DIR=${D}/usr/bin \
	MAN_DIR=${D}/usr/share/man/man1 install || die

	einfo "Removing SUID from binary.."
	chmod u-s ${D}/usr/bin/rawrec
}
