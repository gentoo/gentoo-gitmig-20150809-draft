# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mime-types/mime-types-1.0.ebuild,v 1.4 2004/02/25 17:14:56 aliz Exp $

IUSE=""
S=${WORKDIR}/${P}

DESCRIPTION="Provides mime.types file"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc alpha ppc ~amd64"

DEPEND=""

RDEPEND=""

src_install() {
	dodir /etc
	insinto /etc
	doins mime.types
}
