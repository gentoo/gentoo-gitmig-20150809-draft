# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/primegen/primegen-0.97.ebuild,v 1.1 2004/12/28 19:19:55 ribosome Exp $

inherit gcc

DESCRIPTION="A small, fast library to generate primes in order"
HOMEPAGE="http://cr.yp.to/primegen.html"
SRC_URI="http://cr.yp.to/primegen/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	echo $(gcc-getCC) ${CFLAGS} > conf-cc
	echo /usr > conf-home
	echo $(gcc-getCC) ${CFLAGS} > conf-ld
	emake || die
}

src_install() {
	dobin primegaps primes primespeed || die "dobin failed"
	doman primegaps.1 primes.1 primespeed.1
	doman error.3 error_str.3 primegen.3
	dolib.a primegen.a || die "dolib.a failed"
	insinto /usr/include
	doins primegen.h uint32.h uint64.h
	dodoc BLURB CHANGES README
}
