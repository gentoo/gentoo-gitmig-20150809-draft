# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dnstracer/dnstracer-1.7.ebuild,v 1.3 2004/03/21 17:46:06 weeve Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Determines where a given nameserver gets its information from"
SRC_URI="http://www.mavetju.org/download/${P}.tar.gz"
HOMEPAGE="http://www.mavetju.org/unix/general.php"

IUSE=""
KEYWORDS="x86 ~ppc ~sparc"
LICENSE="as-is"
SLOT="0"
DEPEND="virtual/glibc"
RDEPEND=""

src_install () {
	make DESTDIR=${D} install || die
	dodoc README CHANGES
}

