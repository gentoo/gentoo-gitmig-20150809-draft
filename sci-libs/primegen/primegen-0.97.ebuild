# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/primegen/primegen-0.97.ebuild,v 1.7 2009/09/23 20:09:11 patrick Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A small, fast library to generate primes in order"
HOMEPAGE="http://cr.yp.to/primegen.html"
SRC_URI="http://cr.yp.to/primegen/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-man.patch"
}

src_compile() {
	# Fixes bug #161015
	append-flags -fsigned-char

	echo $(tc-getCC) ${CFLAGS} > conf-cc
	echo /usr > conf-home
	echo $(tc-getCC) ${CFLAGS} > conf-ld
	emake || die
}

src_install() {
	dobin primegaps primes primespeed || die "dobin failed"
	doman primegaps.1 primes.1 primespeed.1
	doman primegen.3
	dolib.a primegen.a || die "dolib.a failed"
	insinto /usr/include
	doins primegen.h uint32.h uint64.h
	dodoc BLURB CHANGES README
}
