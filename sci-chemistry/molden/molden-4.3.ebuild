# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/molden/molden-4.3.ebuild,v 1.10 2006/04/08 10:36:13 blubb Exp $

inherit eutils toolchain-funcs flag-o-matic

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
	|| ( x11-libs/libXmu virtual/x11 )"
DEPEND="${RDEPEND}
	virtual/libc"

S=${WORKDIR}/${MY_P}

src_unpack() {
	# Set fortran compiler, since gcc-config doesn't
	[ -z ${FC} ] && FC="g77"

	# Check for fortran compiler
	if [ ! "`which ${FC} 2> /dev/null`" ]; then
		eerror "Fortran compiler not found."
		eerror "Please recompile sys-devel/gcc with fortran in USE flags."
		die
	fi

	unpack ${A}
	cd ${S}

	# No need to add a new identical patch
	# assuming people don't stupidly remove 3.9 patch with 3.9
	epatch ${FILESDIR}/${PN}-3.9-fixMakefile.patch
}

src_compile() {
	# Use -mieee on alpha, according to the Makefile
	use alpha && append-flags -mieee

	# Honor CC, CFLAGS, FC, and FFLAGS from environment;
	# unfortunately a bash bug prevents us from doing typeset and
	# assignment on the same line.
	typeset -a args
	args=( CC="$(tc-getCC) ${CFLAGS}" \
		${FC:+FC="${FC}" LDR="${FC}"} \
		${FFLAGS:+FFLAGS="${FFLAGS}"} )

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
