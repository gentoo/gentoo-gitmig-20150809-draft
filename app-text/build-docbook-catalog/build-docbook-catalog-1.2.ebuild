# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/build-docbook-catalog/build-docbook-catalog-1.2.ebuild,v 1.9 2004/10/11 03:30:01 tgall Exp $

DESCRIPTION="DocBook XML catalog auto-updater"
HOMEPAGE=""
SRC_URI="mirror://gentoo/${P}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha arm amd64 hppa ia64 mips ppc s390 sparc x86 ppc64"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_install() {
	newbin ${P} ${PN} || die
}
