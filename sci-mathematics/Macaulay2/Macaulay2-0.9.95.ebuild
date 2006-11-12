# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/Macaulay2/Macaulay2-0.9.95.ebuild,v 1.1 2006/11/12 20:11:09 markusle Exp $

inherit eutils flag-o-matic toolchain-funcs autotools

IUSE=""

DESCRIPTION="research tool for commutative algebra and algebraic geometry"
SRC_URI="http://www.math.uiuc.edu/Macaulay2/Downloads/${P}-src.tar.gz
	ftp://www.mathematik.uni-kl.de/pub/Math/Singular/Factory/factory-3-0-2.tar.gz \
	ftp://www.mathematik.uni-kl.de/pub/Math/Singular/Libfac/libfac-3-0-2.tar.gz"

HOMEPAGE="http://www.math.uiuc.edu/Macaulay2/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="sys-libs/gdbm
	dev-libs/gmp
	dev-libs/ntl
	dev-libs/boehm-gc
	virtual/blas
	virtual/lapack
	dev-util/ctags
	sys-libs/ncurses"

src_compile() {
	epatch "${FILESDIR}"/${P}-etags-gentoo.patch

	cd ${WORKDIR}/factory
	econf --enable-NTL --prefix=${WORKDIR} || \
		die "failed to configure factory"
	emake || die "failed to build factory"
	make install || die "failed to install factory"

	cd ${WORKDIR}/libfac
	CPPFLAGS="-I${WORKDIR}/include" ./configure --with-NOSTREAMIO \
		--prefix=${WORKDIR} || die "failed to configure libfac"
	make DEFS=-DHAVE_SINGULAR_ERROR || die "failed to build libfac"
	make install || die "failed to install libfac"

	CXXFLAGS="${CXXFLAGS} -Wno-deprecated"
	cd ${WORKDIR}/${P}
	sed -e "/^docm2RelDir/s:Macaulay2:${P}:" \
		-i include/config.Makefile.in || \
		die "failed to fix makefile"
	make && CPPFLAGS="-I/usr/include/gc -I${WORKDIR}/include" \
		LDFLAGS="-L${WORKDIR}/lib" \
		./configure --prefix="${D}/usr" --disable-encap \
		--with-lapacklibs="-llapack -lblas" || \
		die "failed to configure Macaulay"
	# fix install paths
	make || die "failed to build Macaulay"
}

src_test() {
	cd ${WORKDIR}/Macaulay2-0.9.2
	make -k check || die "tests failed"
}

src_install () {
	cd ${WORKDIR}/Macaulay2-0.9.2
	make install || die "install failed"
}
