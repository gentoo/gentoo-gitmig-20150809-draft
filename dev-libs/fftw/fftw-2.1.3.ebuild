# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: George Shapovalov <george@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.4 2002/03/12 16:05:09 tod Exp

S="${WORKDIR}/${P}"

DESCRIPTION="C subroutine library for computing the Discrete Fourier Transform (DFT)"

SRC_URI="http://www.fftw.org/${P}.tar.gz"
HOMEPAGE="http://www.fftw.org"

DEPEND="mpi? ( >=lam-6.5.6 )"
#will just leave this as a dependency on mpi for now until I test if lam does not brake anything on uniproc systems.

RDEPEND="${DEPEND}"

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

    cd "${S}"
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
	./configure \
		--host=${CHOST} ${myconf} \
		--prefix=/usr \
		--enable-shared --enable-threads \
		--enable-type-prefix --enable-float \
		--enable-i386-hacks --enable-vec-recurse \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die

	#the only difference here is no --enable-float
	cd "${S}-double"
	./configure \
		--host=${CHOST} ${myconf} \
		--prefix=/usr \
		--enable-shared --enable-threads \
		--enable-type-prefix \
		--enable-i386-hacks --enable-vec-recurse \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	#both builds are installed in the same place
	#libs are distinguished by preffix (s or d), see docs for details
	cd "${S}-single"
	make DESTDIR=${D} install || die
	
	cd "${S}-double"
	make DESTDIR=${D} install || die

	# Install documentation.
	cd "${S}-single"
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS  TODO
	dohtml doc/fftw*.html
}
