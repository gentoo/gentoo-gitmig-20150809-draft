# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/pcf2bdf/pcf2bdf-1.04-r1.ebuild,v 1.8 2009/11/25 09:48:33 maekke Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Converts PCF fonts to BDF fonts"
HOMEPAGE="http://www.tsg.ne.jp/GANA/S/pcf2bdf/"
SRC_URI="http://www.tsg.ne.jp/GANA/S/pcf2bdf/${P}.tgz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~ppc s390 sh sparc x86 ~x86-fbsd"
IUSE=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-64bit.patch
	epatch "${FILESDIR}"/${P}-gzip.patch
}

src_compile() {
	emake -f Makefile.gcc CC="$(tc-getCXX)" CFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	emake -f Makefile.gcc \
		PREFIX="${D}/usr" \
		MANPATH="${D}/usr/share/man/man1" \
		install || die
}
