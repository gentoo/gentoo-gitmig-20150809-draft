# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/fftw/fftw-2.1.5-r3.ebuild,v 1.2 2007/05/18 14:30:42 armin76 Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit flag-o-matic multilib autotools

IUSE="doc mpi float"

DESCRIPTION="C subroutine library for computing the Discrete Fourier Transform (DFT)"
SRC_URI="http://www.fftw.org/${P}.tar.gz"
HOMEPAGE="http://www.fftw.org"

# hppa does not have yet a virtual/mpi, and just got ~.
DEPEND="mpi? ( !hppa? ( virtual/mpi ) )
	mpi? ( hppa? ( sys-cluster/lam-mpi ) )"

SLOT="2.1"
LICENSE="GPL-2"

KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"

pkg_setup() {
	# this one is reported to cause trouble on pentium4 m series
	filter-mfpmath "sse"

	# here I need (surprise) to increase optimization:
	# --enable-i386-hacks requires -fomit-frame-pointer to work properly
	if [ "${ARCH}" == "x86" ]; then
		is-flag "-fomit-frame-pointer" || append-flags "-fomit-frame-pointer"
	fi
}

src_unpack() {
	# doc suggests installing single and double precision versions via separate compilations
	# will do in two separate source trees
	# since some sed'ing is done during the build (?if --enable-type-prefix is set?)

	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-as-needed.patch"
	# fix info files
	for infofile in doc/fftw*info*; do
		echo "INFO-DIR-SECTION Libraries" >>${infofile}
		echo "START-INFO-DIR-ENTRY" >>${infofile}
		echo "* fftw: (fftw).				   C subroutine library for computing the Discrete Fourier Transform (DFT)" >>${infofile}
		echo "END-INFO-DIR-ENTRY" >>${infofile}
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
		dosym sfftw.h /usr/include/fftw.h
		dosym srfftw.h /usr/include/rfftw.h
		dosym libsfftw.so /usr/$(get_libdir)/libfftw.so
		dosym libsrfftw.so /usr/$(get_libdir)/librfftw.so
		dosym sfftw_threads.h /usr/include/fftw_threads.h
		dosym srfftw_threads.h /usr/include/rfftw_threads.h
		dosym libsfftw_threads.so /usr/$(get_libdir)/libfftw_threads.so
		dosym libsrfftw_threads.so /usr/$(get_libdir)/librfftw_threads.so
	else
		dosym dfftw.h /usr/include/fftw.h
		dosym drfftw.h /usr/include/rfftw.h
		dosym libdfftw.so /usr/$(get_libdir)/libfftw.so
		dosym libdrfftw.so /usr/$(get_libdir)/librfftw.so
		dosym dfftw_threads.h /usr/include/fftw_threads.h
		dosym drfftw_threads.h /usr/include/rfftw_threads.h
		dosym libdfftw_threads.so /usr/$(get_libdir)/libfftw_threads.so
		dosym libdrfftw_threads.so /usr/$(get_libdir)/librfftw_threads.so
	fi
}
