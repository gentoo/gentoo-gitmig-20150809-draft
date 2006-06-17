# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libghemical/libghemical-2.00.ebuild,v 1.2 2006/06/17 01:02:59 spyderous Exp $

inherit autotools eutils

DESCRIPTION="Chemical quantum mechanics and molecular mechanics"
HOMEPAGE="http://bioinformatics.org/ghemical/"
SRC_URI="http://www.bioinformatics.org/ghemical/download/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="mopac7 mpqc"
RDEPEND="mopac7? ( sci-chemistry/mopac7 )
		mpqc? ( >=sci-chemistry/mpqc-2.3.1-r1
			virtual/blas
			virtual/lapack )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.15"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-really-find-blas-and-lapack.patch
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
