# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/blas-config/blas-config-1.0.0.ebuild,v 1.3 2004/06/06 16:17:43 kugelfang Exp $

DESCRIPTION="Utility to change the default BLAS library"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64 ~ppc"
IUSE=""

DEPEND=""

RDEPEND="app-shells/bash"

src_unpack(){
	cp ${FILESDIR}/blas-config.bz2 ${WORKDIR}
	bunzip2 ${WORKDIR}/blas-config.bz2
}

src_install () {
	exeinto /usr/bin
	doexe ${WORKDIR}/blas-config
}
