# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/molden/molden-4.0.ebuild,v 1.9 2004/07/27 08:06:11 spyderous Exp $

inherit eutils gcc flag-o-matic

MY_P="${PN}${PV}"
DESCRIPTION="Display molecular density from GAMESS-UK, GAMESS-US, GAUSSIAN and Mopac/Ampac."
HOMEPAGE="http://www.cmbi.kun.nl/~schaft/molden/molden.html"
SRC_URI="ftp://ftp.cmbi.kun.nl/pub/molgraph/${PN}/${MY_P}.tar.Z"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ia64 alpha ~amd64"
IUSE="opengl"

DEPEND=""
RDEPEND="virtual/x11
	opengl? ( media-libs/glut )"

S=${WORKDIR}/${MY_P}

src_unpack() {
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
	args=( CC="${CC} ${CFLAGS}" \
		${FC:+FC="${FC}" LDR="${FC}"} \
		${FFLAGS:+FFLAGS="${FFLAGS}"} )

	einfo "Building Molden..."
	emake "${args[@]}" || die "molden emake failed"
	if use opengl ; then
		einfo "Building Molden OpenGL helper..."
		emake "${args[@]}" moldenogl || die "moldenogl emake failed"
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
