# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/countrycodes/countrycodes-1.0.5.ebuild,v 1.21 2010/10/19 06:01:05 leio Exp $

inherit eutils toolchain-funcs

DESCRIPTION="An ISO 3166 country code finder"
HOMEPAGE="http://www.grigna.com/diego/linux/countrycodes/"
SRC_URI="http://www.grigna.com/diego/linux/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	sys-apps/sed"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-Makefile.patch

	sed -i -e "s:gcc:$(tc-getCC):" src/Makefile || die "sed failed"
}

src_compile() {
	emake -C src CCOPTS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	make \
		-C src \
		prefix="${D}/usr" \
		mandir="${D}/usr/share/man/man1" install || die "make install failed"
	dosym iso3166 /usr/bin/countrycodes
	dosym iso3166.1 /usr/share/man/man1/countrycodes
	dodoc doc/{Changelog,README}
	prepman
}
