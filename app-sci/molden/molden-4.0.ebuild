# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/molden/molden-4.0.ebuild,v 1.3 2004/04/07 19:56:39 vapier Exp $

inherit eutils gcc

MY_P="${PN}${PV}"
DESCRIPTION="Display molecular density from GAMESS-UK, GAMESS-US, GAUSSIAN and Mopac/Ampac."
HOMEPAGE="http://www.cmbi.kun.nl/~schaft/molden/molden.html"
SRC_URI="ftp://ftp.cmbi.kun.nl/pub/molgraph/${PN}/${MY_P}.tar.Z"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ia64"
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
	# Respect $CC
	sed -i -e "s:^CC = cc:CC = $(gcc-getCC):g" ${S}/makefile
	# Respect $CFLAGS
	sed -i -e "s:^CFLAGS = :CFLAGS = ${CFLAGS} :g" ${S}/makefile
	# Respect $FC if set
	if [ -n "${FC}" ] ; then
		sed -i -e "s:^FC = g77:FC = ${FC}:g" ${S}/makefile
		sed -i -e "s:^LDR = g77:LDR = ${FC}:g" ${S}/makefile
	fi
	# Respect $FFLAGS if set
	if [ -n "${FFLAGS}" ] ; then
		sed -i -e "s:^FFLAGS =:FFLAGS = ${FFLAGS}:g" ${S}/makefile
	fi
}

src_compile() {
	einfo "Building Molden..."
	emake || die "molden emake failed"
	if use opengl ; then
		einfo "Building Molden OpenGL helper..."
		emake moldenogl || die "moldenogl emake failed"
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
