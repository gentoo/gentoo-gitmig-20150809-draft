# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/sparc32/sparc32-1.1-r3.ebuild,v 1.2 2005/03/23 17:34:44 eradicator Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A SPARC32 compilation environment."
HOMEPAGE=""
SRC_URI="ftp://ftp.auxio.org/pub/linux/SOURCES/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~sparc"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-no-kern-headers.patch
	epatch ${FILESDIR}/${P}-linux32.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install () {
	dobin sparc32
	dosym sparc32 /usr/bin/sparc64
	dosym sparc32 /usr/bin/linux32
	dosym sparc32 /usr/bin/linux64
	doman sparc32.8
	dosym sparc32.8.gz /usr/share/man/man8/linux32.8.gz
	doman sparc64.8
	dosym sparc64.8.gz /usr/share/man/man8/linux64.8.gz
}
