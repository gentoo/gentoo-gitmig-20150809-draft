# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rawrec/rawrec-0.9.98.ebuild,v 1.1 2003/06/26 16:15:28 robh Exp $

DESCRIPTION="CLI program to play and record audiofiles."
HOMEPAGE="http://rawrec.sourceforge.net/"
SRC_URI="http://switch.dl.sourceforge.net/sourceforge/rawrec/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""
DEPEND="virtual/glibc"
S=${WORKDIR}/${P}

src_compile() {
	cd src
	make || die
}

src_install() {
	cd src
	make EXE_DIR=${D}/usr/bin \
	MAN_DIR=${D}/usr/share/man/man1 install || die
		
	einfo "Removing SUID from binary.."
	chmod u-s ${D}/usr/bin/rawrec
}
