# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/ikarus/ikarus-0.0.3.ebuild,v 1.3 2008/06/01 18:03:13 pchrist Exp $

inherit eutils flag-o-matic autotools

DESCRIPTION="A free optimizing incremental native-code compiler for R6RS Scheme."
HOMEPAGE="http://www.cs.indiana.edu/~aghuloum/ikarus/"
SRC_URI="http://www.cs.indiana.edu/~aghuloum/ikarus/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"

KEYWORDS="-* ~x86"
IUSE="sse2 doc"

RDEPEND=">=dev-libs/gmp-4.2.2"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's/-O3//' configure.ac
	epatch "${FILESDIR}/${P}-cpu_has_sse2.patch"
	epatch "${FILESDIR}/${P}-ikarus-enter.patch"
	eautoreconf || die "autoconf failed"
}

src_compile() {
	if use !sse2; then \
		eerror "You must have a processor who supports \
		SSE2 instructions" && die
	fi

	append-flags "-std=gnu99"

	econf || die "econf failed"
	emake || die "emake failed"
}

src_test() {
	cd benchmarks
	make benchall || die "Tests failed"
	if [ -e timelog ]
	then
		cat timelog || die "stdout test logs failed."
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -R "${D}/usr/share"
	dodoc README ACKNOWLEDGMENTS
	if use doc; then
		dodoc doc/*.pdf
	fi
}
