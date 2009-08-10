# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/meep/meep-1.0.3.ebuild,v 1.2 2009/08/10 13:16:06 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="Simulation software to model electromagnetic systems"
HOMEPAGE="http://ab-initio.mit.edu/meep/"
SRC_URI="http://ab-initio.mit.edu/meep/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bindist examples hdf5 guile mpi"

DEPEND="sci-libs/fftw
	!bindist? ( sci-libs/gsl )
	bindist? ( <sci-libs/gsl-1.10 )
	sci-physics/harminv
	guile? ( >=sci-libs/libctl-3.0.3 )
	hdf5? ( sci-libs/hdf5 )
	mpi? ( virtual/mpi )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch
}

src_configure() {
	econf \
		--enable-shared \
		$(use_with mpi) \
		$(use_with hdf5) \
		$(use_with guile libctl)
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS NEWS README TODO || die "dodoc failed"
	insinto /usr/share/doc/${PF}
	if use examples; then
		doins -r examples || die "install examples failed"
	fi
}
