# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/jive/jive-1.1.ebuild,v 1.5 2004/04/06 23:11:16 weeve Exp $

DESCRIPTION="Filter that converts English text to Jive, by Adam Douglas"
HOMEPAGE="http://dev.gentoo.org/~brad/"
SRC_URI="http://dev.gentoo.org/~brad/${P}.tar.gz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc ~sparc"
IUSE=""
DEPEND="virtual/glibc"
#RDEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	emake
}

src_install() {
	dobin jive
	doman jive.1
	dodoc README POSTER
}
