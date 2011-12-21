# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/primegen/primegen-0.97-r1.ebuild,v 1.4 2011/12/21 08:23:22 phajdan.jr Exp $

EAPI=2
inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="A small, fast library to generate primes in order"
HOMEPAGE="http://cr.yp.to/primegen.html"
SRC_URI="http://cr.yp.to/primegen/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}/${P}-man.patch"
	epatch "${FILESDIR}/${P}-missing-headers.patch"
	find . -type f -exec \
		sed -i -e 's:\(primegen.a\):lib\1:' {} \;
	mkdir usr
}

src_configure() {
	# Fixes bug #161015
	append-flags -fsigned-char
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "${S}/usr" > conf-home
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
}

src_test() {
	[[ $(./primes 1 100000000 | md5sum ) == "4e2b0027288a27e9c99699364877c9db "* ]] || die "test failed"
}

src_install() {
	dobin primegaps primes primespeed || die "dobin failed"
	doman primegaps.1 primes.1 primespeed.1 primegen.3
	dolib.a libprimegen.a || die "dolib.a failed"
	# include the 2 typedefs to avoid collision (bug #248327)
	sed -i \
		-e "s/#include \"uint32.h\"/$(grep typedef uint32.h)/" \
		-e "s/#include \"uint64.h\"/$(grep typedef uint64.h)/" \
		primegen.h || die
	insinto /usr/include
	doins primegen.h || die
	dodoc BLURB CHANGES README TODO
}
