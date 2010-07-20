# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/molden/molden-4.8-r1.ebuild,v 1.2 2010/07/20 11:03:31 jlec Exp $

EAPI="3"

inherit eutils flag-o-matic fortran toolchain-funcs

FORTRAN="g77 gfortran"
MY_P="${PN}${PV}"

DESCRIPTION="Display molecular density from GAMESS-UK, GAMESS-US, GAUSSIAN and Mopac/Ampac."
HOMEPAGE="http://www.cmbi.kun.nl/~schaft/molden/molden.html"
SRC_URI="ftp://ftp.cmbi.kun.nl/pub/molgraph/${PN}/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~x86"
IUSE="opengl"

RDEPEND="
	x11-libs/libXmu
	opengl? (
		virtual/glut
		virtual/opengl )"
DEPEND="${RDEPEND}
	x11-misc/gccmakedep
	app-editors/vim"
	# vim provides ex, which the build system uses (surf/Makefile, at least)

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-ambfor.patch
	epatch "${FILESDIR}"/${P}-overflow.patch
	epatch "${FILESDIR}"/${P}-ldflags.patch
	epatch "${FILESDIR}"/${PN}-4.7-implicit-dec.patch
	sed 's:makedepend:gccmakedep:g' -i surf/Makefile
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
	dobin ${PN} g${PN} || die "failed to install molden executable."
	if use opengl ; then
		dobin ${PN}ogl || die "failed to install moldenogl."
	fi

	dodoc HISTORY README REGISTER || die "failed to install docs."
	cd doc
	uncompress * && dodoc * || die "failed to install docs."
}
