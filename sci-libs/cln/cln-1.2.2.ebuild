# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cln/cln-1.2.2.ebuild,v 1.14 2009/11/30 06:22:26 josejx Exp $

EAPI=2
inherit eutils flag-o-matic

DESCRIPTION="Class library (C++) for numbers"
HOMEPAGE="http://www.ginac.de/CLN/"
SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/gnu/${P}.tar.bz2
	ftp://ftp.santafe.edu/pub/gnu/${P}.tar.bz2
	ftp://ftp.ilog.fr/pub/Users/haible/gnu/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="doc examples"

DEPEND="dev-libs/gmp"
RDEPEND="${DEPEND}"

pkg_setup() {
	# -Os causes segmentation faults (see bug #174576)
	# checked for 1.2.2, gcc-4.3.3
	replace-flags -Os -O2
	# ftracer buggy bug #237451
	filter-flags -ftracer
	# -fdirectives-only also buggy bug #263257
	filter-flags -fdirectives-only
	use sparc && append-cppflags "-DNO_ASM"
	use hppa && append-cppflags "-DNO_ASM"
}

src_prepare() {
	# avoid building tests and examples by default
	epatch "${FILESDIR}"/${P}-examples.patch
	# avoid installing dvi and html docs by default
	epatch "${FILESDIR}"/${P}-docs.patch
	# fix compilation under gcc 4.4
	epatch "${FILESDIR}"/${P}-gcc-4.4.patch
}

src_configure () {
	econf  \
		--libdir=/usr/$(get_libdir) \
		--datadir=/usr/share/doc/${PF}
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog TODO* NEWS
	if use doc; then
		dodoc doc/cln.ps
		dohtml doc/cln/* || die
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi
}
