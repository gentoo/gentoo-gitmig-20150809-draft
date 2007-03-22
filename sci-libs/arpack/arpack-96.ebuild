# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/arpack/arpack-96.ebuild,v 1.1 2007/03/22 16:24:55 bicatali Exp $

inherit eutils autotools fortran

DESCRIPTION="Arnoldi package library to solve large scale eigenvalue problems."
HOMEPAGE="http://www.caam.rice.edu/software/ARPACK"
SRC_URI="http://www.caam.rice.edu/software/ARPACK/SRC/${PN}${PV}.tar.gz
	http://www.caam.rice.edu/software/ARPACK/SRC/patch.tar.gz
	http://www.caam.rice.edu/software/ARPACK/SRC/p${PN}${PV}.tar.gz
	http://www.caam.rice.edu/software/ARPACK/SRC/ppatch.tar.gz
	doc? ( http://www.caam.rice.edu/software/ARPACK/SRC/ug.ps.gz
		http://www.caam.rice.edu/software/ARPACK/DOCS/tutorial.ps.gz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mpi doc examples"

DEPEND="mpi? ( virtual/mpi )"
RDEPEND="${DEPEND} virtual/lapack"

S=${WORKDIR}/ARPACK
RESTRICT="mirror"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-autotools.patch

	# fix examples library paths
	sed -i \
		-e '/^include/d' \
		-e 's/$(ALIBS)/-larpack -lblas -llapack/g' \
		-e 's/$(FFLAGS)/$(LDFLAGS)/g' \
		EXAMPLES/*/makefile || die "sed failed"

	sed -i \
		-e '/^include/d' \
		-e 's/$(PLIBS)/-larpack -lparpack -lblas -llapack -lmpi/g' \
		-e 's/_$(PLAT)//g' \
		-e 's/$(PFC)/mpif77/g' \
		-e 's/$(PFFLAGS)/$(LDFLAGS)/g' \
		PARPACK/EXAMPLES/MPI/makefile || die "sed failed"

	eautoreconf
}

src_compile() {
	econf $(use_enable mpi) || "econf failed"
	emake || "emake failed"
}

src_test() {
	cd "${S}"/EXAMPLES/SIMPLE
	make simple FC="${FORTRANC}" LDFLAGS="-L${S}/.libs"
	for p in ss ds sn dn cn zn; do
		prog=${p}simp
		LD_LIBRARY_PATH="${S}/.libs" ./${prog} || die "${prog} test failed"
		rm -f ${prog}
	done
	if use mpi; then
		cd "${S}"/PARPACK/EXAMPLES/MPI
		make pdndrv FC=mpif77 LDFLAGS="-L${S}/.libs -L${S}/PARPACK/.libs"
		for p in 1 3; do
			prog=pdndrv${p}
			LD_LIBRARY_PATH="${S}/.libs:${S}/PARPACK/.libs" ./${prog} || die "${prog} test failed"
			rm -f ${prog}
		done
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README DOCUMENTS/*.doc
	newdoc DOCUMENTS/README README.doc
	use doc && dodoc "${WORKDIR}"/*.ps

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r EXAMPLES
		if use mpi; then
			insinto /usr/share/doc/${PF}/EXAMPLES/PARPACK
			doins -r PARPACK/EXAMPLES/MPI
		fi
	fi
}
