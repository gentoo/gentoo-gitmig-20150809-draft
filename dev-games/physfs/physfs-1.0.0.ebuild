# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/physfs/physfs-1.0.0.ebuild,v 1.6 2005/01/01 18:02:52 eradicator Exp $

DESCRIPTION="abstraction layer for filesystems, useful for games"
HOMEPAGE="http://icculus.org/physfs/"
SRC_URI="http://icculus.org/physfs/downloads/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="x86 ppc sparc ~alpha hppa amd64"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGELOG CREDITS TODO docs/README
}
