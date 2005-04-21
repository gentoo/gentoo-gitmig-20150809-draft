# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/c-ares/c-ares-1.2.1.ebuild,v 1.1 2005/04/21 12:35:27 dragonheart Exp $

DESCRIPTION="C library that resolves names asynchronously"
SRC_URI="http://daniel.haxx.se/projects/c-ares/${P}.tar.gz"
HOMEPAGE="http://daniel.haxx.se/projects/c-ares/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/libc"

src_install () {
	make DESTDIR=${D} install || die
	dodoc CHANGES NEWS README*
}
