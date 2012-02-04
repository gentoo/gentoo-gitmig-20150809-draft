# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/fftw/fftw-3.3-r2.ebuild,v 1.1 2012/02/04 21:45:07 ottxor Exp $

EAPI=4

inherit autotools-utils eutils flag-o-matic fortran-2 toolchain-funcs

DESCRIPTION="Fast C library for the Discrete Fourier Transform"
HOMEPAGE="http://www.fftw.org/"
SRC_URI="http://www.fftw.org/${P/_/-}.tar.gz"

LICENSE="GPL-2"
SLOT="3.0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="altivec avx doc fortran mpi openmp paired-single quad sse sse2 static-libs threads zbus"

DEPEND="
	fortran? ( virtual/fortran[openmp?] )
	mpi? ( virtual/mpi )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P/_/-}

AUTOTOOLS_AUTORECONF=1

DOCS=( AUTHORS ChangeLog NEWS README TODO COPYRIGHT CONVENTIONS doc/fftw3.pdf )

HTML_DOCS=( doc/html/ )

pkg_setup() {
	if use openmp; then
		tc-has-openmp || die "Please ensure your compiler has openmp support"
		FORTRAN_NEED_OPENMP="1"
		[[ $(tc-getCC)$ == icc* ]] && append-ldflags $(no-as-needed)
	fi
	use fortran && fortran-2_pkg_setup
	FFTW_DIRS="single double longdouble"
	use quad && FFTW_DIRS+= "quad"
}

src_prepare() {
	# fix info file for category directory
	sed -i \
		-e 's/Texinfo documentation system/Libraries/' \
		doc/fftw3.info || die "failed to fix info file"

	rm -f m4/lt* m4/libtool.m4
}

src_configure() {
	local x

	# filter -Os according to docs
	replace-flags -Os -O2

	for x in ${FFTW_DIRS}; do
		myeconfargs=(
			$(use_enable fortran)
			$(use_enable zbus mips-zbus-timer)
			$(use_enable threads)
			$(use_enable openmp)
		)
		if [[ $x == single ]]; then
			#altivec, sse, single-paired only work for single
			myeconfargs+=(
				--enable-single
				$(use_enable altivec)
				$(use_enable avx)
				$(use_enable sse)
				$(use_enable paired-single mips-ps)
				$(use_enable mpi)
			)
		elif [[ $x == double ]]; then
			myeconfargs+=(
				$(use_enable avx)
				$(use_enable sse2)
				$(use_enable mpi)
			)
		elif [[ $x == longdouble ]]; then
			myeconfargs+=(
				--enable-long-double
				$(use_enable mpi)
				)
		elif [[ $x == quad ]]; then
			#quad does not support mpi
			myeconfargs+=( --enable-quad-precision )
		else
			die "${x} precision not implemented in this ebuild"
		fi

		einfo "Configuring for ${x} precision"
		AUTOTOOLS_BUILD_DIR="${S}-${x}" \
			autotools-utils_src_configure
	done
}

src_compile() {
	for x in ${FFTW_DIRS}; do
		einfo "Compiling for ${x} precision"
		AUTOTOOLS_BUILD_DIR="${S}-${x}" \
			autotools-utils_src_compile
	done
}

src_test () {
	# We want this to be a reasonably quick test, but that is still hard...
	ewarn "This test series will take 30 minutes on a modern 2.5Ghz machine"
	# Do not increase the number of threads, it will not help your performance
	#local testbase="perl check.pl --nthreads=1 --estimate"
	#		${testbase} -${p}d || die "Failure: $n"
	for x in ${FFTW_DIRS}; do
		cd "${S}-${x}/tests"
		einfo "Testing ${x} precision"
		emake -j1 check
	done
}

src_install () {
	local u x

	for x in ${FFTW_DIRS}; do
		AUTOTOOLS_BUILD_DIR="${S}-${x}" \
			autotools-utils_src_install
	done

	if use doc; then
		insinto /usr/share/doc/"${PF}"/faq
		doins -r "${S}"/doc/FAQ/fftw-faq.html/*
	fi

	for x in "${ED}"/usr/lib*/pkgconfig/*.pc; do
		for u in $(usev mpi) $(usev threads) $(usex openmp omp ""); do
		    sed "s|-lfftw3[flq]\?|&_$u &|" "$x" > "${x%.pc}_$u.pc" || die
		done
	done
}
