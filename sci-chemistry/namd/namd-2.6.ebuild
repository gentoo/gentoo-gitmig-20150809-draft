# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/namd/namd-2.6.ebuild,v 1.4 2009/09/23 19:55:56 patrick Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="A powerful and highly parallelized molecular dynamics code"
LICENSE="namd"
HOMEPAGE="http://www.ks.uiuc.edu/Research/namd/"

MY_PN="NAMD"
MY_PV="2.6"

SRC_URI="${MY_PN}_${MY_PV}_Source.tar.gz"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="fetch"

DEPEND="app-shells/tcsh
	=sys-cluster/charm-5.9
	=sci-libs/fftw-2*
	=dev-lang/tcl-8.4*"

RDEPEND=${DEPEND}

CHARM="charm-5.9"
NAMD_ARCH="Linux-i686-g++"

NAMD_DOWNLOAD="http://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=NAMD"

S="${WORKDIR}/${MY_PN}_${MY_PV}_Source"

pkg_nofetch() {
	echo
	einfo "Please download ${MY_PN}_${MY_PV}_Source.tar.gz from"
	einfo "${NAMD_DOWNLOAD}"
	einfo "after agreeing to the license and then move it to"
	einfo "${DISTDIR}"
	einfo "Be sure to select the ${MY_PV} version!"
	echo
}

src_unpack() {
	unpack ${A}

	# apply a few small fixes to make NAMD compile and
	# link to the proper libraries
	epatch "${FILESDIR}"/namd-2.6-gentoo.patch

	cd "${S}"

	# proper compiler and cflags
	sed -e "s/g++/$(tc-getCXX)/" \
		-e "s/CXXOPTS = -O3 -march=pentiumpro -ffast-math -static/CXXOPTS = ${CXXFLAGS}/" \
		-e "s/gcc/$(tc-getCC)/" \
		-e "s/COPTS = -O3 -march=pentiumpro -ffast-math -static/COPTS = ${CFLAGS}/" \
		-i arch/${NAMD_ARCH}.arch || \
		die "Failed to setup ${NAMD_ARCH}.arch"

	# configure
	./config tcl fftw ${NAMD_ARCH}
}

src_compile() {
	# build namd
	cd "${S}/${NAMD_ARCH}"
	emake || die "Failed to build namd"
}

src_install() {
	cd "${S}/${NAMD_ARCH}"

	# the binaries
	dobin ${PN}2 psfgen flipbinpdb flipdcd || \
		die "Failed to install binaries"

	cd "${S}"

	# some docs
	dodoc announce.txt license.txt notes.txt || \
		die "Failed to install docs"
}

pkg_postinst() {
	echo
	einfo "For detailed instructions on how to run and configure"
	einfo "NAMD please consults the extensive documentation at"
	einfo "http://www.ks.uiuc.edu/Research/namd/"
	einfo "and the NAMD tutorials available at"
	einfo "http://www.ks.uiuc.edu/Training/Tutorials/"
	einfo "Have fun :)"
	echo
}
