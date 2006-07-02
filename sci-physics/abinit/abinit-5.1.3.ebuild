# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/abinit/abinit-5.1.3.ebuild,v 1.1 2006/07/02 23:26:18 metalgod Exp $

inherit fortran toolchain-funcs

DESCRIPTION="Find total energy, charge density and electronic structure using density functional theory"
HOMEPAGE="http://www.abinit.org/"
SRC_URI="ftp://ftp.abinit.org/pub/abinitio/ABINIT_v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
#IUSE="mpi netcdf test"
IUSE="mpi test"

RDEPEND="virtual/blas
	virtual/lapack"
# Doesn't build with 4.1-20060210
#	netcdf? ( sci-libs/netcdf )"
DEPEND="${RDEPEND}"

# F90 code, g77 won't work
FORTRAN="gfortran ifc"

pkg_setup() {
	fortran_pkg_setup

	# Doesn't compile with gcc-4.0, only >=4.1
	local diemsg="Requires gcc-4.1 or newer"
	if [[ "${FORTRANC}" = "gfortran" ]]; then
		if [[ $(gcc-major-version) -eq 4 ]] \
			&& [[ $(gcc-minor-version) -lt 1  ]]; then
				die "${diemsg}"
		elif [[ $(gcc-major-version) -lt 4 ]]; then
			die "${diemsg}"
		fi
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/change-default-directories.patch
	epatch ${FILESDIR}/fix-test-tarball.patch
	epatch ${FILESDIR}/fix-64bit-detection.patch

	# Update config files for m4 generation, and regenerate it
	epatch ${FILESDIR}/${PV}-fix-blas-lapack-check.patch
	./config/scripts/make-macros-extlibs

	AT_M4DIR="config/m4" eautoreconf
}

src_compile() {
	econf \
		--with-install-type=debian \
		--disable-config-file \
		--disable-library-search \
		$(use_enable mpi) \
		--with-blas-prefix=/usr \
		--with-lapack-prefix=/usr \
		--with-c-optflags="${CFLAGS}" \
		--with-fortran-optflags="${FFLAGS}" \
		FC="${FORTRANC}" \
		CC="$(tc-getCC)" \
		|| die "configure failed"
#		$(use_enable netcdf) \

	emake || die "make failed"
}

src_test() {
	einfo "The tests take quite a while, on the order of 2-3 hours"
	einfo "on a dual Athlon 2000+."
	cd ${S}/tests
	emake tests_dev

	local REPORT
	for REPORT in $(find . -name *fl*); do
		einfo "Results for ${REPORT%%/*} tests"
		cat ${REPORT}
	done
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	if use test; then
		dodoc ${S}/tests/summary_tests.tar.gz
	fi

	dodoc ${S}/KNOWN_PROBLEMS
	prepalldocs
}

pkg_postinst() {
	ewarn "Upstream considers this version unready for production use."
	ewarn "Major changes occurred in the build system since 4.x."
	ewarn "If you intend to use it in production, be sure to run all tests"
	ewarn "and read through the test results by emerging abinit"
	ewarn "with FEATURES=test and USE=test. Also see the KNOWN_PROBLEMS document."
	ewarn "The test results will be installed as summary_tests.tar.gz."
}
