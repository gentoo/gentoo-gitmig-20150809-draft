# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/meep/meep-0.10.1.ebuild,v 1.3 2008/06/28 13:14:21 markusle Exp $

inherit eutils autotools

DESCRIPTION="Simulation software to model electromagnetic systems"
HOMEPAGE="http://ab-initio.mit.edu/meep/"
SRC_URI="http://ab-initio.mit.edu/meep/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bindist doc examples hdf5 guile mpi"

DEPEND="sci-libs/fftw
	!bindist? ( sci-libs/gsl )
	bindist? ( <sci-libs/gsl-1.10 )
	sci-physics/harminv
	sci-libs/blas-atlas
	virtual/lapack
	guile? ( >=sci-libs/libctl-3.0 )
	hdf5? ( sci-libs/hdf5 )
	mpi? ( virtual/mpi )"

pkg_setup() {
	SELECTED_BLAS=$(eselect blas show | cut -d' ' -f2)
	if [[ ${SELECTED_BLAS} == "reference" ]]; then
		ewarn "You have selected blas-reference which may yield a"
		ewarn "broken meep and cause test failures (see bug #229693)"
		ewarn "We highly recommend that you use blas-atlas"
		ewarn "when compiling and using meep."
		epause 5
	fi
}


src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-configure.ac.patch
	epatch "${FILESDIR}"/${P}-gcc4.3.patch
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	econf \
		$(use_with mpi) \
		$(use_with hdf5) \
		$(use_with guile libctl) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS NEWS README TODO || die "dodoc failed"
	insinto /usr/share/doc/${PF}
	if use doc; then
		doins doc/meep.pdf || die "install doc failed"
	fi
	if use examples; then
		doins -r examples || die "install examples failed"
	fi
}

pkg_postinst() {
	# warn the user that meep + blas-reference may cause problems
	echo
	elog "Please note that meep may produce bad results when"
	elog "used in conjunction with blas-reference. We recommend"
	elog "that you use blas-atlas instead."
	echo
}

