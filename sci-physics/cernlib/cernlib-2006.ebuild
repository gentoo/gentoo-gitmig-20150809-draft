# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/cernlib/cernlib-2006.ebuild,v 1.2 2007/08/25 22:58:25 mr_bones_ Exp $

inherit eutils multilib fortran

DEB_PN=cernlib
DEB_PV=${PV}.dfsg.2
DEB_PR=2
DEB_P=${PN}_${DEB_PV}

DESCRIPTION="CERN program library for High Energy Physics"
HOMEPAGE="http://wwwasd.web.cern.ch/wwwasd/cernlib"
SRC_URI="mirror://debian/pool/main/${DEB_PN:0:1}/${DEB_PN}/${DEB_P}.orig.tar.gz
	mirror://debian/pool/main/${DEB_PN:0:1}/${DEB_PN}/${DEB_P}-${DEB_PR}.diff.gz"

KEYWORDS="~x86 ~amd64"
LICENSE="GPL-2 LGPL-2 BSD"

SLOT="0"

DEPEND="virtual/motif
	virtual/lapack
	virtual/tetex
	dev-lang/cfortran
	x11-misc/imake
	x11-misc/makedepend
	app-admin/eselect-blas"

RDEPEND="virtual/motif
	virtual/lapack
	dev-lang/cfortran"

S=${WORKDIR}/${DEB_PN}-${DEB_PV}.orig

FORTRAN="gfortran g77 ifc"

src_unpack() {

	unpack ${A}
	epatch "${DEB_P}-${DEB_PR}".diff

	cd "${S}"
	# temporary fix for threading support (might be supported by eselect)
	if eselect blas show | grep -q threaded-atlas; then
		einfo "Fixing threads linking for blas"
		sed -i \
			-e 's/$DEPS -lm/$DEPS -lm -lpthread/' \
			-e 's/$DEPS -l$1 -lm/$DEPS -l$1 -lm -lpthread/' \
			debian/add-ons/bin/cernlib.in || die "sed failed"
	fi

	# fix X11 library path
	sed -i \
		-e "s:L/usr/X11R6/lib:L/usr/$(get_libdir)/X11:g" \
		-e "s:XDIR=/usr/X11R6/lib:XDIR=/usr/$(get_libdir)/X11:g" \
		-e "s:XDIR64=/usr/X11R6/lib:XDIR64=/usr/$(get_libdir)/X11:g" \
		debian/add-ons/bin/cernlib.in || die "sed failed"

	# fix some default paths
	sed -i \
		-e "s:/usr/local:/usr:g" \
		-e "s:prefix)/lib:prefix)/$(get_libdir):" \
		-e 's:$(prefix)/etc:/etc:' \
		-e 's:$(prefix)/man:$(prefix)/share/man:' \
		debian/add-ons/cernlib.mk || die "sed failed"

	cp debian/add-ons/Makefile .
	sed -i \
		-e 's:/usr/local:/usr:g' \
		Makefile || "sed'ing the Makefile failed"

	einfo "Applying Debian patches"
	emake -j1 \
		DEB_BUILD_OPTIONS="${FORTRANC} nostrip" \
		patch || die "make patch failed"

	# since we depend on cfortran, do not use the one from cernlib
	# (adapted from debian/cernlib-debian.mk)
	mv -f src/include/cfortran/cfortran.h \
		src/include/cfortran/cfortran.h.disabled
	# create local LaTeX cache directory
	mkdir -p .texmf-var

	# fix an ifort problem
	sed -i \
		-e 's/= $(CLIBS) -nofor_main/+= -nofor_main/' \
		src/packlib/kuip/programs/kxterm/Imakefile || die "sed failed"
}

src_compile() {
	emake -j1 \
		DEB_BUILD_OPTIONS="${FORTRANC} nostrip" \
		|| die "emake failed"
}

src_install() {
	emake \
		DEB_BUILD_OPTIONS="${FORTRANC} nostrip" \
		DESTDIR="${D}" \
		install || die "emake install failed"
	cd "${S}"/debian
	dodoc changelog README.* deadpool.txt NEWS copyright || die "dodoc failed"
	newdoc add-ons/README README.add-ons || die "newdoc failed"
}

pkg_postinst() {
	elog "Gentoo ${PN} is based on Debian similar package."
	elog "Serious cernlib users might want to check:"
	elog "http://people.debian.org/~kmccarty/cernlib/"
	elog "for the changes and licensing from the original package"
	if use amd64; then
		elog "Please see the possible warnings in using ${PN} on 64 bits:"
		elog "/usr/share/doc/${PF}/README.*64*"
	fi
}
