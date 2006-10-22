# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/ebookmerge/ebookmerge-0.9.3.ebuild,v 1.5 2006/10/22 09:42:48 corsair Exp $

DESCRIPTION="Script to manage eBooks in Gentoo."
HOMEPAGE="http://www.josealberto.org/blog/2005/11/28/ebookmerge/"

SRC_URI="mirror://gentoo/${P}.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~alpha ~amd64 ia64 ~ppc ~ppc64 ~x86"

DEPEND="app-shells/bash"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_install() {
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
	einfo "Use -m for an alternative mirror"
	echo
}
