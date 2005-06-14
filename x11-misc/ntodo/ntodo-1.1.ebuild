# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ntodo/ntodo-1.1.ebuild,v 1.1 2005/06/14 21:55:43 pyrania Exp $

DESCRIPTION="GTK Todo program"
HOMEPAGE="http://www.theasylum.org/ntodo/"
SRC_URI="http://www.theasylum.org/ntodo/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
DEPEND="=x11-libs/gtk+-1.2*
	>=sys-apps/sed-4"
#RDEPEND=""
S="${WORKDIR}/nToDo-${PV}"

src_unpack() {
	unpack ${A} ; cd ${S}

	sed -i "s:^CFLAGS.*:CFLAGS = ${CFLAGS} \$(GTK_CFLAGS):g" Makefile
}



src_compile() {
	make || die
}

src_install() {
	dobin ntodo
	dodoc README
}
