# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/sparc32/sparc32-1.1-r2.ebuild,v 1.2 2004/06/24 22:49:23 agriffis Exp $

inherit eutils

DESCRIPTION="A SPARC32 compilation environment."
HOMEPAGE=""
SRC_URI="ftp://ftp.auxio.org/pub/linux/SOURCES/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~sparc"
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-no-kern-headers.patch
}

src_compile() {
	emake || die
}

src_install () {
	dobin sparc32
	dosym sparc32 /usr/bin/sparc64
	doman sparc32.8
	doman sparc64.8
}
