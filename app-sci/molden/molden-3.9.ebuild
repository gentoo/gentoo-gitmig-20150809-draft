# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/molden/molden-3.9.ebuild,v 1.1 2003/11/10 05:49:47 spyderous Exp $

MY_P="${PN}${PV}"
DESCRIPTION="Display molecular density from GAMESS-UK, GAMESS-US, GAUSSIAN and Mopac/Ampac."
HOMEPAGE="http://www.cmbi.kun.nl/~schaft/molden/molden.html"
SRC_URI="ftp://ftp.cmbi.kun.nl/pub/molgraph/${PN}/${MY_P}.tar.Z"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="opengl"
DEPEND=""
RDEPEND="virtual/x11"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PF}-fixMakefile.patch
	# Respect $CC
	sed -i -e "s:^CC = cc:CC = ${CC}:g" ${S}/makefile
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
	use opengl && \
		dobin moldenogl
	dodoc CopyRight HISTORY README REGISTER
	cd doc
	uncompress *
	dodoc *
}
