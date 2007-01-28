# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/unfoo/unfoo-1.0.4.ebuild,v 1.15 2007/01/28 05:28:36 genone Exp $

DESCRIPTION="A simple bash driven frontend to simplify decompression of files"
HOMEPAGE="http://obsoleet.org/code/unfoo"
SRC_URI="${HOMEPAGE}/${P}.sh"
LICENSE="BSD"
SLOT="0"
KEYWORDS="ppc x86 sparc s390 ppc64"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/${A} ${WORKDIR}
}

src_install() {
	newbin ${P}.sh unfoo
}

pkg_postinst() {
	echo
	elog "unfoo can handle far more than just .tar*, but it requires some"
	elog "optional packages to do so. For a list, either consult the source"
	elog "(less /usr/bin/unfoo), or see http://obsoleet.org/code/unfoo"
	echo
}
