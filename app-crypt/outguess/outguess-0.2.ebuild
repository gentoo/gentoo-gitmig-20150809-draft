# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/outguess/outguess-0.2.ebuild,v 1.2 2004/02/16 07:24:00 zhen Exp $

DESCRIPTION="A universal tool for inserting steganographic information into other data."
HOMEPAGE="http://www.outguess.org/"
SRC_URI="http://packetstormsecurity.nl/crypt/stego/outguess-0.2.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/glibc"

S=${WORKDIR}/${PN}

src_compile() {
	econf || die "./configure failed"
	emake || die "make failed"
}

src_install() {
	dobin outguess || die "installation failed"
	doman outguess.1 || die "installation failed"
}
