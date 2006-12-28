# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libghemical/libghemical-2.10.ebuild,v 1.1 2006/12/28 22:30:59 je_fro Exp $

DESCRIPTION="Chemical quantum mechanics and molecular mechanics"
HOMEPAGE="http://bioinformatics.org/ghemical/"
SRC_URI="http://www.bioinformatics.org/ghemical/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="mopac7 mpqc"

DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.15"
RDEPEND="mopac7? ( sci-chemistry/mopac7 )
		mpqc? ( >=sci-chemistry/mpqc-2.3.1-r1
			virtual/blas
			virtual/lapack )"

src_unpack() {
	unpack ${A}
	cd "${S}"
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
	make DESTDIR="${D}" install || die "install failed"
}

