# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libnc-dap/libnc-dap-3.7.3-r1.ebuild,v 1.6 2011/06/21 15:14:13 jlec Exp $

EAPI="1"

inherit eutils fortran-2 flag-o-matic toolchain-funcs

DESCRIPTION="An OPeNDAP-enabled version of the NetCDF 3.6 API that replaces the standard NetCDF library."
HOMEPAGE="http://opendap.org/index.html"
SRC_URI="http://opendap.org/pub/source/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug fortran full-test"

RDEPEND="
	fortran? ( virtual/fortran )
	dev-util/cppunit
	full-test? ( dev-util/dejagnu )"

DEPEND="${RDEPEND}
	sys-libs/zlib
	dev-libs/libxml2:2
	>=net-misc/curl-7.10.6
	<=sci-libs/libdap-3.8.2"

pkg_setup() {
	fortran-2_pkg_setup
	if use fortran; then
		case "$(tc-getFC)" in
			# probably needs more compilers here, of which I have
			# none, so feel free to provide flags for others...
			*g77)
				export FCLAGS+="-finit-local-zero -fno-automatic \
					-fno-second-underscore -std=legacy -ff2c \
					-fall-intrinsics -static-libgfortran"
				;;
			*)
				export FCLAGS+="-finit-local-zero -fno-automatic \
					-fno-second-underscore -std=gnu \
					-fall-intrinsics -static-libgfortran"
				;;
		esac
	else
		export FC=""
	fi

	if use full-test; then
		if [ -n "${DAP_TEST_OPTS}" ]; then
		elog "User-specified test URL is ${DAP_TEST_OPTS}."
		else
		elog "User-specified test URL is not set; if needed, set"
		elog "DAP_TEST_OPTS to a URL of your choice and rebuild."
		fi
	elog
	elog "The full regression test does two passes, the second one with"
	elog "remote data queries.  The latter part can take several hours,"
	elog "so hit Ctl-C now and set USE=-full-test if you'd rather not."
	epause 10
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# increase the number of open netcdf files
	sed -i -e "s:MAX_NC_OPEN 32:MAX_NC_OPEN 128:g" \
		lnetcdf/{lnetcdf.h,netcdf.h} \
		|| die "sed headers failed"

	# missing definition causes unknown symbol errors
	epatch "${FILESDIR}"/${P}_template-fix.patch

	# this is specific to GNU Fortran
	if [[ $(tc-getFC) = *gfortran ]] ; then
		elog "updating for gfortran..."
		sed -i -e "s/= -Df2cFortran/= -DgFortran/" Makefile.in \
		|| die "sed makefile.in failed"
	fi
}

src_compile() {
	local test_conf="${DAP_TEST_OPTS}"
	local myconf="--disable-dependency-tracking --enable-largefile \
		 --enable-64bit"
	use fortran || myconf="${myconf} --disable-f77"
	# debug can be set to 2 for extra verbosity
	use debug && myconf="${myconf} --enable-debug=1"

	econf ${myconf} ${test_conf} || die "econf failed"

	emake -j1 || die "emake failed"
}

src_test() {
	if use full-test; then
		cd "${S}"/nc_test
		# These tests should all pass, but the non-local tests can take
		# several hours to complete.
		make check || die "Regression tests failed!"
		cd "${S}"
		# This test has unexpected failures
		make check
	else
		# unit tests only
		cd "${S}"/unit-tests
		ln -sf ../ncdump/testsuite testsuite
		# These tests should also pass
		make check || die "Unit tests failed!"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	mv "${D}"usr/bin/ncdump "${D}"usr/bin/dncdump
	# this is just the netcdf ncdump man page...
	#newman ncdump/ncdump.1 dncdump.1

	dodoc README NEWS README.translation
}

pkg_postinst() {
	elog
	elog "If you want to run the regression tests with a custom URL and"
	elog "dataset then you can pass it via the following option:"
	elog
	elog "DAP_TEST_OPTS=--with-data-url=<your URL> emerge libnc-dap"
	elog
	elog "for example, http://test.opendap.org/opendap/nph-dods/data/nc/test.nc"
	elog "Just make sure you have test enabled in your FEATURES and"
	elog "an active Internet connection."
	elog
}
