# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/htslib/htslib-1.0.ebuild,v 1.6 2015/05/27 11:22:38 ago Exp $

EAPI=5

inherit multilib toolchain-funcs

DESCRIPTION="C library for high-throughput sequencing data formats"
HOMEPAGE="http://www.htslib.org/"
SRC_URI="mirror://sourceforge/samtools/${PV}/${P}.tar.bz2"

SLOT="0"
LICENSE="MIT"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE="static-libs"

src_prepare() {
	sed \
		-e "/libdir/s:lib$:$(get_libdir):g" \
		-i Makefile || die
}

src_compile() {
	emake \
		AR="$(tc-getAR)" \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake \
		DESTDIR="${D}" \
		prefix="${EPREFIX}/usr" \
		install

	rm "${ED}/usr/share/man/man1/libhts.so.1" || die

	if ! use static-libs; then
		find "${ED}" -type f -name "*.a" -delete || die
	fi

	dodoc README
}
