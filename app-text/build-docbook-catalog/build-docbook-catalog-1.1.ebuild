# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/build-docbook-catalog/build-docbook-catalog-1.1.ebuild,v 1.1 2004/06/30 03:12:29 agriffis Exp $

DESCRIPTION="DocBook XML catalog auto-updater"
HOMEPAGE=""
SRC_URI="mirror://gentoo/${P}.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~mips"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_install() {
	newbin ${P} ${PN}
}
