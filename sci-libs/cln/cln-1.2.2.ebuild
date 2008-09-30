# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cln/cln-1.2.2.ebuild,v 1.3 2008/09/30 12:58:09 bicatali Exp $

inherit eutils flag-o-matic multilib

DESCRIPTION="Class library (C++) for numbers"

HOMEPAGE="http://www.ginac.de/CLN/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~amd64 ppc ~sparc ~x86"
IUSE="doc examples"

SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/gnu/${P}.tar.bz2
	ftp://ftp.santafe.edu/pub/gnu/${P}.tar.bz2
	ftp://ftp.ilog.fr/pub/Users/haible/gnu/${P}.tar.bz2"
DEPEND="dev-libs/gmp"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# avoid building tests and examples by default
	epatch "${FILESDIR}"/${P}-examples.patch
	# avoid installing dvi and html docs by default
	epatch "${FILESDIR}"/${P}-docs.patch
}

src_compile () {
	# -Os causes segmentation faults (see bug #174576)
	# checked for 1.2.1, gcc-4.2.3
	replace-flags -Os -O2
	use sparc && append-cppflags "-DNO_ASM"
	econf  \
		--libdir=/usr/$(get_libdir) \
		--datadir=/usr/share/doc/${PF} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog TODO* NEWS
	if use doc; then
		dodoc doc/cln.ps
		dohtml doc/cln/*
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
