# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dnstracer/dnstracer-1.7.ebuild,v 1.4 2004/04/16 19:53:39 randy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Determines where a given nameserver gets its information from"
SRC_URI="http://www.mavetju.org/download/${P}.tar.gz"
HOMEPAGE="http://www.mavetju.org/unix/general.php"

IUSE=""
KEYWORDS="x86 ~ppc ~sparc s390"
LICENSE="as-is"
SLOT="0"
DEPEND="virtual/glibc"
RDEPEND=""

src_install () {
	make DESTDIR=${D} install || die
	dodoc README CHANGES
}

