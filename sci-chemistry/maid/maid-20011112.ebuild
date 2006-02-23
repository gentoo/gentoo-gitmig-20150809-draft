# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/maid/maid-20011112.ebuild,v 1.5 2006/02/23 23:15:53 spyderous Exp $

inherit eutils toolchain-funcs

MY_PN="${PN}_unix"
MY_PV="${PV:6:2}nov${PV:2:2}"
MY_P="${MY_PN}_${MY_PV}"
DESCRIPTION="Automates the fitting of protein X-ray crystallographic electron density maps"
HOMEPAGE="http://www.msi.umn.edu/~levitt/"
SRC_URI="http://www.msi.umn.edu/~levitt/${MY_P}.tar.gz
	mirror://gentoo/maid-fix-compilation.patch.bz2"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="X"
DEPEND="X? ( virtual/motif
		virtual/glu
		virtual/opengl
		|| ( x11-libs/libXt virtual/x11 )
	)"
S="${WORKDIR}/glmaid_dist"

src_unpack() {
	if best_version virtual/opengl | grep mesa; then
		if ! built_with_use media-libs/mesa motif; then
			msg="Build media-libs/mesa with USE=motif"
			eerror "${msg}"
			die "${msg}"
		fi
	fi

	unpack ${A}
	cd ${S}

	epatch ${DISTDIR}/maid-fix-compilation.patch.bz2
	epatch ${FILESDIR}/fix-warnings.patch

	if use X; then
		ln -s makefile_graphics makefile
	else
		ln -s makefile_batch makefile
	fi

	sed -i \
		-e "s:^Cgeneric = .*:Cgeneric = $(tc-getCXX):g" \
		-e "s:\(Copt.*\)-O:\1${CFLAGS}:g" \
		makefile
}

src_install() {
	dodoc MANUAL*
	if use X; then
		dobin maid
	else
		dobin maidbatch
	fi
}
