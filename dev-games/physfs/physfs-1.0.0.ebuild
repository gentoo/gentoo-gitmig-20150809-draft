# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/physfs/physfs-1.0.0.ebuild,v 1.2 2004/04/05 21:19:14 vapier Exp $

DESCRIPTION="abstraction layer for filesystems, useful for games"
HOMEPAGE="http://icculus.org/physfs/"
SRC_URI="http://icculus.org/physfs/downloads/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa amd64"
IUSE=""

DEPEND="virtual/glibc"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGELOG CREDITS TODO docs/README
}
