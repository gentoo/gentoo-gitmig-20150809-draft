# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/paw/paw-2.14.04.ebuild,v 1.2 2007/08/25 22:58:47 mr_bones_ Exp $

inherit eutils multilib fortran

DEB_PN=paw
DEB_PV=${PV}.dfsg.2
DEB_PR=1
DEB_P=${DEB_PN}_${DEB_PV}

DESCRIPTION="CERN's Physics Analysis Workstation data analysis program"
HOMEPAGE="http://wwwasd.web.cern.ch/wwwasd/paw/index.html"
LICENSE="GPL-2 LGPL-2 BSD"
SRC_URI="mirror://debian/pool/main/${DEB_PN:0:1}/${DEB_PN}/${DEB_P}.orig.tar.gz
	mirror://debian/pool/main/${DEB_PN:0:1}/${DEB_PN}/${DEB_P}-${DEB_PR}.diff.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND="virtual/motif
	virtual/lapack
	dev-lang/cfortran
	sci-physics/cernlib
	x11-libs/xbae"

DEPEND="${RDEPEND}
	virtual/tetex
	x11-misc/imake
	x11-misc/makedepend"

S="${WORKDIR}/${DEB_PN}-${DEB_PV}.orig"

KEYWORDS="~amd64 ~x86"

FORTRAN="gfortran g77 ifc"

src_unpack() {
	unpack ${A}
	epatch "${DEB_P}-${DEB_PR}".diff

	cd "${S}"
	cp debian/add-ons/Makefile .
	# fix some path stuff and collision for comis.h,
	# already installed by cernlib and replace hardcoded fortran compiler
	sed -i \
		-e 's:/usr/local:/usr:g' \
		-e '/comis.h/d' \
		-e "s/g77/${FORTRANC}/g" \
		Makefile || "sed'ing the Makefile failed"

	einfo "Applying Debian patches"
	emake -j1 \
		DEB_BUILD_OPTIONS="${FORTRANC} ${nostrip}" \
		patch || die "make patch failed"

	# since we depend on cfortran, do not use the one from cernlib
	# (adapted from debian/cernlib-debian.mk)
	mv -f src/include/cfortran/cfortran.h \
		src/include/cfortran/cfortran.h.disabled
	# create local LaTeX cache directory
	mkdir -p .texmf-var
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
	dodoc changelog README.* deadpool.txt copyright || die "dodoc failed"
	newdoc add-ons/README README.add-ons || die "newdoc failed"
}

pkg_postinst() {
	if use amd64; then
		elog "Please see the possible warnings in using ${PN} on 64 bits:"
		elog "/usr/share/doc/${PF}/README.*64*"
	fi
}
