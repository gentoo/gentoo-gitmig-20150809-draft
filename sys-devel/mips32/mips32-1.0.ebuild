# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/mips32/mips32-1.0.ebuild,v 1.3 2004/07/02 08:41:39 eradicator Exp $

inherit eutils

DESCRIPTION="A MIPS32 compilation environment."
HOMEPAGE=""
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* mips"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-no-kern-headers.patch
}

src_compile() {
	emake || die
}

src_install () {
	dobin mips32
	dosym mips32 /usr/bin/mips64
	doman mips32.8
	doman mips64.8
}
