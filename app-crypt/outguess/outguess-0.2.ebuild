# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/outguess/outguess-0.2.ebuild,v 1.5 2004/09/03 00:39:29 dholm Exp $

DESCRIPTION="A universal tool for inserting steganographic information into other data"
HOMEPAGE="http://www.outguess.org/"
SRC_URI="http://packetstormsecurity.nl/crypt/stego/outguess-0.2.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/libc"

S=${WORKDIR}/${PN}

src_install() {
	dobin outguess || die "installation failed"
	doman outguess.1
}
