# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/molden/molden-4.4.ebuild,v 1.5 2007/08/12 04:09:38 beandog Exp $

inherit eutils toolchain-funcs flag-o-matic fortran

MY_P="${PN}${PV}"
DESCRIPTION="Display molecular density from GAMESS-UK, GAMESS-US, GAUSSIAN and Mopac/Ampac."
HOMEPAGE="http://www.cmbi.kun.nl/~schaft/molden/molden.html"
SRC_URI="ftp://ftp.cmbi.kun.nl/pub/molgraph/${PN}/${MY_P}.tar.Z"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ia64 x86"
IUSE="opengl"

RDEPEND="opengl? ( virtual/glut
	virtual/opengl )
	x11-libs/libXmu"
DEPEND="${RDEPEND}
	virtual/libc"

S="${WORKDIR}/${MY_P}"

FORTRAN="g77 gfortran"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gfortran-gentoo.patch
}

src_compile() {
	# Use -mieee on alpha, according to the Makefile
	use alpha && append-flags -mieee

	# Honor CC, CFLAGS, FC, and FFLAGS from environment;
	# unfortunately a bash bug prevents us from doing typeset and
	# assignment on the same line.
	typeset -a args
	args=( CC="$(tc-getCC) ${CFLAGS}" \
		FC="${FORTRANC}" LDR="${FORTRANC}" FFLAGS="${FFLAGS}" )

	einfo "Building Molden..."
	emake -j1 "${args[@]}" || die "molden emake failed"
	if use opengl ; then
		einfo "Building Molden OpenGL helper..."
		emake -j1 "${args[@]}" moldenogl || die "moldenogl emake failed"
	fi
}

src_install() {
	dobin molden
	use opengl && dobin moldenogl
	dodoc HISTORY README REGISTER
	cd doc
	uncompress *
	dodoc *
}
