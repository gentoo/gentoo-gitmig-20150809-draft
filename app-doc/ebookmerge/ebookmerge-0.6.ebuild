# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/ebookmerge/ebookmerge-0.6.ebuild,v 1.2 2005/07/04 23:04:42 bass Exp $

DESCRIPTION="Script to manage eBooks in Gentoo."
HOMEPAGE="http://www.josealberto.org/blog/?p=35"

SRC_URI="mirror://gentoo/${P}.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86 ~ppc"

DEPEND="app-shells/bash"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${P}.bz2
}

src_install() {
	cd ${WORKDIR}
	newbin ${P} ebookmerge.sh
}

pkg_postinst() {
	echo
	einfo "Need help? just run: "
	einfo "ebookmerge.sh -h"
	echo
	einfo "The first you must run is: "
	einfo "ebookmerge.sh -r"
	echo
}
