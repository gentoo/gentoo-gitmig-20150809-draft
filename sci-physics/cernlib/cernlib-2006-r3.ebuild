# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/cernlib/cernlib-2006-r3.ebuild,v 1.4 2009/12/04 15:55:43 jer Exp $

EAPI=2
inherit eutils toolchain-funcs

DEB_PN=cernlib
DEB_PV=${PV}.dfsg.2
DEB_PR=14
DEB_P=${DEB_PN}_${DEB_PV}

DESCRIPTION="CERN program library for High Energy Physics"
HOMEPAGE="http://wwwasd.web.cern.ch/wwwasd/cernlib"
SRC_URI="mirror://debian/pool/main/${DEB_PN:0:1}/${DEB_PN}/${DEB_P}.orig.tar.gz
	mirror://debian/pool/main/${DEB_PN:0:1}/${DEB_PN}/${DEB_P}-${DEB_PR}.diff.gz"

KEYWORDS="amd64 hppa ~sparc x86"
LICENSE="GPL-2 LGPL-2 BSD"

SLOT="0"

RDEPEND="x11-libs/openmotif
	virtual/lapack
	dev-lang/cfortran"

DEPEND="${RDEPEND}
	x11-misc/imake
	x11-misc/makedepend
	dev-util/pkgconfig"

IUSE=""

S="${WORKDIR}/${DEB_PN}-${DEB_PV}"

src_prepare() {
	cd "${WORKDIR}"
	sed -i -e 's:/tmp/dp.*/cern:cern:g' ${DEB_P}-${DEB_PR}.diff || die
	epatch ${DEB_P}-${DEB_PR}.diff
	mv ${DEB_PN}-${DEB_PV}{.orig,}/upstream
	cd "${S}"
	epatch "${FILESDIR}/${P}-nogfortran.patch"
	# set some default paths
	sed -i \
		-e "s:/usr/local:/usr:g" \
		-e "s:prefix)/lib:prefix)/$(get_libdir):" \
		-e 's:$(prefix)/etc:/etc:' \
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
	emake -j1 patch || die "debian patch failed"

	# since we depend on cfortran, do not use the one from cernlib
	rm -f src/include/cfortran/cfortran.h

	# respect users flags
	sed -i \
		-e 's/-O3/-O2/g' \
		-e "s/-O2/${CFLAGS}/g" \
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
	emake -j1 cernlib-indep cernlib-arch || die "emake libs failed"
}

src_test() {
	LD_LIBRARY_PATH="${S}"/shlib \
		emake -j1 cernlib-test || die "emake test failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	cd "${S}"/debian
	dodoc changelog README.* deadpool.txt NEWS copyright || die "dodoc failed"
	newdoc add-ons/README README.add-ons || die "newdoc failed"
}

pkg_postinst() {
	elog "Gentoo ${PN} is based on Debian similar package."
	elog "Serious cernlib users might want to check:"
	elog "http://people.debian.org/~kmccarty/cernlib/"
	elog "for the changes and licensing from the original package"
}
