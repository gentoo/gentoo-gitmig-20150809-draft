# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/blas-config/blas-config-1.0.1.ebuild,v 1.3 2006/08/20 22:49:51 dberkholz Exp $

DESCRIPTION="Utility to change the default BLAS library"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=""

RDEPEND="app-shells/bash"

src_unpack(){
	cp ${FILESDIR}/${P} ${WORKDIR}/${PN}
}

src_install () {
	exeinto /usr/bin
	doexe ${WORKDIR}/blas-config
}
