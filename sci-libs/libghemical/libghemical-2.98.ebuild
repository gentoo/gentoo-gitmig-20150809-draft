# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libghemical/libghemical-2.98.ebuild,v 1.2 2008/11/30 01:00:00 je_fro Exp $

inherit autotools

DESCRIPTION="Chemical quantum mechanics and molecular mechanics"
HOMEPAGE="http://bioinformatics.org/ghemical/"
SRC_URI="http://www.bioinformatics.org/ghemical/download/current/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="mopac7 mpqc"

DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.15"
RDEPEND="mopac7? ( >=sci-chemistry/mopac7-1.13-r1 )
		mpqc? ( >=sci-chemistry/mpqc-2.3.1-r1
			virtual/blas
			virtual/lapack )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	eautoreconf
}

src_compile() {
	econf \
		$(use_enable mopac7) \
		$(use_enable mpqc) \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
