# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/fftw/fftw-2.1.5-r4.ebuild,v 1.1 2008/04/29 22:11:57 bicatali Exp $

inherit eutils flag-o-matic multilib autotools fortran

DESCRIPTION="Fast C library for the Discrete Fourier Transform"
SRC_URI="http://www.fftw.org/${P}.tar.gz"
HOMEPAGE="http://www.fftw.org"

# hppa does not have yet a virtual/mpi
DEPEND="mpi? ( !hppa? ( virtual/mpi ) )
	mpi? ( hppa? ( sys-cluster/lam-mpi ) )"

SLOT="2.1"
LICENSE="GPL-2"
IUSE="doc fortran mpi float"

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"

pkg_setup() {
	# this one is reported to cause trouble on pentium4 m series
	filter-mfpmath "sse"

	# here I need (surprise) to increase optimization:
	# --enable-i386-hacks requires -fomit-frame-pointer to work properly
	if [ "${ARCH}" == "x86" ]; then
		is-flag "-fomit-frame-pointer" || append-flags "-fomit-frame-pointer"
	fi
	FORTRAN="gfortran ifc g77"
	use fortran && fortran_pkg_setup
}

src_unpack() {
	# doc suggests installing single and double precision versions
	#  via separate compilations. will do in two separate source trees
	# since some sed'ing is done during the build
	# (?if --enable-type-prefix is set?)

	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-as-needed.patch"
	epatch "${FILESDIR}/${P}-configure.in.patch"

	# fix info files
	for infofile in doc/fftw*info*; do
		cat >> ${infofile} <<-EOF
			INFO-DIR-SECTION Libraries
			START-INFO-DIR-ENTRY
			* fftw: (fftw).				${DESCRIPTION}
			END-INFO-DIR-ENTRY
		EOF
	done

	eautoreconf

	cd "${WORKDIR}"
	cp -R ${P} ${P}-double
	mv ${P} ${P}-single
}

src_compile() {
	cd "${S}-single"
	econf \
		--enable-float \
		--enable-shared \
		--enable-type-prefix \
		--enable-vec-recurse \
		--enable-threads \
		$(use_enable fortran) \
		$(use_enable mpi) \
		$(use_enable x86 i386-hacks) \
		|| die "econf for float failed"
	emake || die "emake for float failed"

	# the only difference here is no --enable-float
	cd "${S}-double"
	econf \
		--enable-shared \
		--enable-type-prefix \
		--enable-vec-recurse \
		--enable-threads \
		$(use_enable fortran) \
		$(use_enable mpi) \
		$(use_enable x86 i386-hacks) \
		|| die "econf for double failed"
	emake || die "emake for double failed"
}

src_test() {
	cd "${S}-single"
	emake check || die "emake check single failed"
	cd "${S}-double"
	emake check || die "emake check double failed"
}

src_install () {

	# both builds are installed in the same place
	# libs are distinguished by prefix (s or d), see docs for details

	cd "${S}-single"
	emake DESTDIR="${D}" install || die "emake install float failed"
	insinto /usr/include
	doins fortran/fftw_f77.i || die "doins failed"
	dodoc AUTHORS ChangeLog NEWS TODO README README.hacks || die "dodoc failed"
	use doc && dohtml doc/*

	cd "${S}-double"
	emake DESTDIR="${D}" install || die "emake install double failed"

	if use float; then
		for f in "${D}"/usr/{include,$(get_libdir)}/*sfft*; do
			ln -s $(basename ${f}) ${f/sfft/fft}
		done
		for f in "${D}"/usr/{include,$(get_libdir)}/*srfft*; do
			ln -s $(basename ${f}) ${f/srfft/rfft}
		done
	else
		for f in "${D}"/usr/{include,$(get_libdir)}/*dfft*; do
			ln -s $(basename ${f}) ${f/dfft/fft}
		done
		for f in "${D}"/usr/{include,$(get_libdir)}/*drfft*; do
			ln -s $(basename ${f}) ${f/drfft/rfft}
		done
	fi
}
