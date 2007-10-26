# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/mpb/mpb-1.4.2-r1.ebuild,v 1.1 2007/10/26 16:33:45 pbienst Exp $

inherit fortran

DESCRIPTION="Program for computing the band structures and electromagnetic modes of periodic dielectric structures"
SRC_URI="http://ab-initio.mit.edu/mpb/${P}.tar.gz"
HOMEPAGE="http://ab-initio.mit.edu/mpb/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="mpi"

SLOT="0"

DEPEND="virtual/lapack
	dev-scheme/guile
	sci-libs/libctl
	sci-libs/hdf5
	~sci-libs/fftw-2.1.5
	sys-libs/readline
	mpi? ( virtual/mpi )"

RDEPEND="~sci-libs/fftw-2.1.5"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${P}-gcc4.patch

	# Create directories to compile the versions with inversion
	# symmetry, hermitian eps and mpi.

	cp -r ${S} ${S}_inv
	cp -r ${S} ${S}_herm

	if use mpi; then
		cp -r ${S} ${S}_mpi
	fi
}

src_compile() {
	# Create the normal version (mpb).
	cd ${S}
	econf || die
	MAKEOPTS="-j1" emake || die # Parallel 'make' gives syntax errors.

	# Create the version with inversion symmetry (mpbi).
	cd ${S}_inv
	econf --with-inv-symmetry || die
	MAKEOPTS="-j1" emake || die

	# Create the version with hermitian eps (mpbh).
	cd ${S}_herm
	econf --with-hermitian-eps || die
	MAKEOPTS="-j1" emake || die

	# Optionally compile mpi version (mpb-mpi).
	if use mpi; then
		cd ${S}_mpi
		econf --with-mpi || die
		MAKEOPTS="-j1" emake || die
	fi

}

src_install() {

	cd ${S}
	einstall || die

	dodoc README COPYING NEWS AUTHORS COPYRIGHT ChangeLog TODO
	dohtml doc/*

	# Install other versions as well.

	mv ${S}_inv/mpb-ctl/.mpb ${S}_inv/mpb-ctl/mpbi
	dobin ${S}_inv/mpb-ctl/mpbi || die

	mv ${S}_herm/mpb-ctl/.mpb ${S}_herm/mpb-ctl/mpbh
	dobin ${S}_herm/mpb-ctl/mpbh || die

	if use mpi; then
		mv ${S}_mpi/mpb-ctl/.mpb ${S}_herm/mpb-ctl/mpb-mpi
		dobin ${S}_herm/mpb-ctl/mpb-mpi || die
	fi

	einfo "Several versions of mpb have been installed:"
	einfo "mpb  : regular version"
	einfo "mpbi : configured for inversion symmetry"
	einfo "mpbh : configured for hermitian epsilon"

	if use mpi; then
		einfo "mpb-mpi : configured for mpi"
	fi

}
