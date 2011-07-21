# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/cernlib/cernlib-2006-r4.ebuild,v 1.2 2011/07/21 16:47:55 bicatali Exp $

EAPI=4
inherit eutils fortran-2 toolchain-funcs

DEB_PN=cernlib
DEB_PV=20061220+dfsg3
DEB_PR=1
DEB_P=${DEB_PN}_${DEB_PV}

DESCRIPTION="CERN program library for High Energy Physics"
HOMEPAGE="http://wwwasd.web.cern.ch/wwwasd/cernlib"
SRC_URI="mirror://debian/pool/main/${DEB_PN:0:1}/${DEB_PN}/${DEB_P}.orig.tar.gz
	mirror://debian/pool/main/${DEB_PN:0:1}/${DEB_PN}/${DEB_P}-${DEB_PR}.debian.tar.gz"

KEYWORDS="~amd64 ~hppa ~sparc ~x86"
LICENSE="GPL-2 LGPL-2 BSD"

SLOT="0"

RDEPEND=">=x11-libs/openmotif-2.3:0
	virtual/fortran
	virtual/lapack
	dev-lang/cfortran"

DEPEND="${RDEPEND}
	x11-misc/imake
	x11-misc/makedepend
	dev-util/pkgconfig"

IUSE=""

S="${WORKDIR}/${DEB_PN}-${DEB_PV}"

src_prepare() {
	mv ../debian .
	epatch "${FILESDIR}"/${P}-nogfortran.patch
	# set some default paths
	sed -i \
		-e "s:/usr/local:${EPREFIX}/usr:g" \
		-e "s:prefix)/lib:prefix)/$(get_libdir):" \
		-e "s:\$(prefix)/etc:${EPREFIX}/etc:" \
		-e 's:$(prefix)/man:$(prefix)/share/man:' \
		debian/add-ons/cernlib.mk || die "sed failed"

	# use system blas and lapack set by gentoo framework
	sed -i \
		-e "s:\$DEPS -lm:$(pkg-config --libs blas):" \
		-e "s:\$DEPS -llapack -lm:$(pkg-config --libs lapack):" \
		-e 's:`depend $d $a blas`::' \
		-e 's:X11R6:X11:g' \
		debian/add-ons/bin/cernlib.in || die "sed failed"

	cp debian/add-ons/Makefile .
	export DEB_BUILD_OPTIONS="$(tc-getFC) nostrip nocheck"

	einfo "Applying Debian patches"
	emake -j1 patch

	epatch "${FILESDIR}"/${P}-fgets.patch
	# since we depend on cfortran, do not use the one from cernlib
	rm -f src/include/cfortran/cfortran.h

	# respect users flags
	sed -i \
		-e 's/-O3/-O2/g' \
		-e "s/-O2/${CFLAGS}/g" \
		-e "s|\(CcCmd[[:space:]]*\)gcc|\1$(tc-getCC)|g" \
		-e "s|\(CplusplusCmd[[:space:]]*\)g++|\1$(tc-getCXX)|g" \
		-e "s|\(FortranCmd[[:space:]]*\)gfortran|\1$(tc-getFC)|g" \
		src/config/linux.cf	\
		|| die "sed linux.cf failed"
	sed -i \
		-e 's/\$(FCLINK)/\$(FCLINK) $(LDFLAGS)/' \
		-e 's/\$(CCLINK)/\$(CCLINK) $(LDFLAGS)/' \
		src/config/{biglib,fortran,Imake}.rules \
		src/patchy/Imakefile \
		|| die "sed for ldflags propagation failed"

	# add missing headers for implicit
	sed -i \
		-e '0,/^#include/i#include <stdlib.h>' \
		src/kernlib/kerngen/ccgen*/*.c || die
}

src_compile() {
	# parallel make breaks and complex patched imake system, hard to debug
	emake -j1 cernlib-indep cernlib-arch
}

src_test() {
	LD_LIBRARY_PATH="${S}"/shlib emake -j1 cernlib-test
}

src_install() {
	emake DESTDIR="${D}" install
	cd debian
	dodoc changelog README.* deadpool.txt NEWS copyright
	newdoc add-ons/README README.add-ons
}
