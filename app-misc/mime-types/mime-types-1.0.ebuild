# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mime-types/mime-types-1.0.ebuild,v 1.5 2004/04/06 18:05:16 agriffis Exp $

IUSE=""
S=${WORKDIR}/${P}

DESCRIPTION="Provides mime.types file"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc alpha ppc ~amd64 ia64 ~hppa"

DEPEND=""

RDEPEND=""

src_install() {
	dodir /etc
	insinto /etc
	doins mime.types
}
