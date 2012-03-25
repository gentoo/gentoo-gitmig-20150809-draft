# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/arpack/arpack-96-r2.ebuild,v 1.26 2012/03/25 15:52:09 armin76 Exp $

EAPI=2

inherit autotools eutils fortran-2 toolchain-funcs

DESCRIPTION="Arnoldi package library to solve large scale eigenvalue problems."
HOMEPAGE="http://www.caam.rice.edu/software/ARPACK/"
SRC_URI="
	http://www.caam.rice.edu/software/ARPACK/SRC/${PN}${PV}.tar.gz
	http://www.caam.rice.edu/software/ARPACK/SRC/p${PN}${PV}.tar.gz
	http://dev.gentoo.org/~bicatali/${P}-patches.tar.bz2
	doc? (
		http://www.caam.rice.edu/software/ARPACK/SRC/ug.ps.gz
		http://www.caam.rice.edu/software/ARPACK/DOCS/tutorial.ps.gz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="doc examples mpi static-libs"

RDEPEND="
	virtual/fortran
	virtual/blas
	virtual/lapack
	mpi? ( virtual/mpi[fortran] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/ARPACK"

src_unpack() {
	unpack ${A}
	unpack ./*patch.tar.gz
}

src_prepare() {
	cd "${WORKDIR}"
	epatch "${WORKDIR}"/${PN}-arscnd.patch
	epatch "${WORKDIR}"/${PN}-autotools.patch
	cd "${S}"
	# fix examples library paths
	sed -i \
		-e '/^include/d' \
		-e "s:\$(ALIBS):-larpack $(pkg-config --libs blas lapack):g" \
		-e 's:$(FFLAGS):$(FFLAGS) $(LDFLAGS):g' \
		EXAMPLES/*/makefile || die "sed failed"

	sed -i \
		-e '/^include/d' \
		-e "s:\$(PLIBS):-larpack -lparpack $(pkg-config --libs blas lapack):g" \
		-e 's:_$(PLAT)::g' \
		-e 's:$(PFC):mpif77:g' \
		-e 's:$(PFFLAGS):$(FFLAGS) $(LDFLAGS) $(EXTOBJS):g' \
		PARPACK/EXAMPLES/MPI/makefile || die "sed failed"
	eautoreconf
}

src_configure() {
	econf \
		--with-blas="$(pkg-config --libs blas)" \
		--with-lapack="$(pkg-config --libs lapack)" \
		$(use_enable static-libs static) \
		$(use_enable mpi)
}

src_test() {
	pushd EXAMPLES/SIMPLE
	emake simple FC=$(tc-getFC) LDFLAGS="${LDFLAGS} -L${S}/.libs"
	local prog=
	for p in ss ds sn dn cn zn; do
		prog=${p}simp
		LD_LIBRARY_PATH="${S}/.libs" ./${prog} \
			|| die "${prog} test failed"
		rm -f ${prog} *.o
	done
	popd

	if use mpi; then
		pushd PARPACK/EXAMPLES/MPI
		mpif77 ${FFLAGS} -c ../../../LAPACK/dpttr{f,s}.f \
			|| die "compiling dpttrf,s failed"
		emake \
			FC=mpif77 \
			EXTOBJS="dpttr{f,s}.o" \
			LDFLAGS="${LDFLAGS} -L${S}/.libs -L${S}/PARPACK/.libs" \
			pdndrv || die "emake pdndrv failed"
		for p in 1 3; do
			prog=pdndrv${p}
			LD_LIBRARY_PATH="${S}/.libs:${S}/PARPACK/.libs" \
				./${prog} || die "${prog} test failed"
			rm -f ${prog} *.o
		done
		popd
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README DOCUMENTS/*.doc || die "dodoc failed"
	newdoc DOCUMENTS/README README.doc || die "newdoc failed"
	if use doc; then
		dodoc "${WORKDIR}"/*.ps || die "dodoc postscript failed"
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r EXAMPLES || die "doins examples failed"
		if use mpi; then
			insinto /usr/share/doc/${PF}/EXAMPLES/PARPACK
			doins -r PARPACK/EXAMPLES/MPI || die "doins mpi examples failed"
		fi
	fi
}
