# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/lapack-config/lapack-config-1.0.0.ebuild,v 1.2 2005/02/17 21:28:45 kloeri Exp $

DESCRIPTION="Utility to change the default LAPACK library"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""

DEPEND=""

RDEPEND="app-shells/bash"

src_unpack(){
	cp ${FILESDIR}/${PN}.gz ${WORKDIR}
	gunzip ${WORKDIR}/${PN}.gz
}

src_install () {
	exeinto /usr/bin
	doexe ${WORKDIR}/${PN}
}
