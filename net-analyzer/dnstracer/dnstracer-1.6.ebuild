# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dnstracer/dnstracer-1.6.ebuild,v 1.1 2002/12/17 20:00:22 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Determines where a given nameserver gets its information from"
SRC_URI="http://www.mavetju.org/download/${P}.tar.gz"
HOMEPAGE="http://www.mavetju.org/unix/general.php"

IUSE=""
KEYWORDS="~x86"
LICENSE="as-is"
SLOT="0"
DEPEND="virtual/glibc"
RDEPEND=""

src_install () {
	make DESTDIR=${D} install || die
	dodoc README CHANGES
}

