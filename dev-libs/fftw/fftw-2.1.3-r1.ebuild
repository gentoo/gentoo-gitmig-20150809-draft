# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/fftw/fftw-2.1.3-r1.ebuild,v 1.8 2004/07/14 14:25:56 agriffis Exp $

IUSE="mpi"

DESCRIPTION="C subroutine library for computing the Discrete Fourier Transform (DFT)"
SRC_URI="http://www.fftw.org/${P}.tar.gz"
HOMEPAGE="http://www.fftw.org"
#lam compiled fine on uniprocessor (drobbins, 01 Aug 2002)
DEPEND="mpi? ( >=sys-cluster/lam-mpi-6.5.6 )"
SLOT="2.1"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc ~alpha"

src_unpack() {
	#doc suggests installing single and double precision versions via separate compilations
	#will do in two separate source trees
	#since some sed'ing is done during the build (?if --enable-type-prefix is set?)

	unpack "${P}.tar.gz"
	cd "${WORKDIR}"
	mv ${P} ${P}-single

	unpack "${P}.tar.gz"
	cd "${WORKDIR}"
	mv ${P} ${P}-double
}


src_compile() {

	#here I need (surprise) to increase optimization:
	#--enable-i386-hacks requires -fomit-frame-pointer to work properly
	export CFLAGS="${CFLAGS/-fomit-frame-pointer/} -fomit-frame-pointer"

	local myconf=""
	use mpi && myconf="${myconf} --enable-mpi"
	#mpi is not a valid flag yet. In this revision it is used merely to block --enable-mpi option
	#it might be needed if it is decided that lam is an optional dependence

	cd "${S}-single"
	econf \
		--enable-shared \
		--enable-threads \
		--enable-type-prefix \
		--enable-float \
		--enable-i386-hacks \
		--enable-vec-recurse \
		${myconf} || die "./configure failed"
	emake || die

	#the only difference here is no --enable-float
	cd "${S}-double"
	econf \
		--enable-shared \
		--enable-threads \
		--enable-type-prefix \
		--enable-i386-hacks \
		--enable-vec-recurse \
		${myconf} || die "./configure failed"
	emake || die
}

src_install () {
	#both builds are installed in the same place
	#libs are distinguished by preffix (s or d), see docs for details
	cd "${S}-single"

	make DESTDIR=${D} install || die

	cd "${S}-double"

	# fix info file
	echo "INFO-DIR-SECTION Libraries" >>$fftw.info
	echo "START-INFO-DIR-ENTRY" >>doc/fftw.info
	echo "* fftw: (fftw).                  C subroutine library for computing the Discrete Fourier Transform (DFT)" >>doc/fftw.info
	echo "END-INFO-DIR-ENTRY" >>doc/fftw.info

	make DESTDIR=${D} install || die

	# Install documentation.
	cd "${S}-single"

	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS  TODO
	dohtml doc/fftw*.html

	if [ "$SINGLE" = "yes" ]; then
		cd ${D}usr/include
		dosym sfftw.h /usr/include/fftw.h
		dosym srfftw.h /usr/include/rfftw.h
		dosym sfftw_threads.h /usr/include/fftw_threads.h
		dosym srfftw_threads.h /usr/include/rfftw_threads.h
		cd ${D}usr/lib
		dosym libsfftw.so /usr/lib/libfftw.so
		dosym libsrfftw.so /usr/lib/librfftw.so
		dosym libsfftw_threads.so /usr/lib/libfftw_threads.so
		dosym libsrfftw_threads.so /usr/lib/librfftw_threads.so
	else
		cd ${D}usr/include
		dosym dfftw.h /usr/include/fftw.h
		dosym drfftw.h /usr/include/rfftw.h
		dosym dfftw_threads.h /usr/include/fftw_threads.h
		dosym drfftw_threads.h /usr/include/rfftw_threads.h
		cd ${D}usr/lib
		dosym libdfftw.so /usr/lib/libfftw.so
		dosym libdrfftw.so /usr/lib/librfftw.so
		dosym libdfftw_threads.so /usr/lib/libfftw_threads.so
		dosym libdrfftw_threads.so /usr/lib/librfftw_threads.so
	fi
}
