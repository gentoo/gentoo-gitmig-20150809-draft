# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/physfs/physfs-0.1.9.ebuild,v 1.2 2003/12/26 12:26:38 weeve Exp $

DESCRIPTION="abstraction layer for filesystems, useful for games"
HOMEPAGE="http://icculus.org/physfs/"
SRC_URI="http://icculus.org/physfs/downloads/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~sparc"

DEPEND="virtual/glibc"

src_compile() {
	econf || die "./configure failed"
	emake || die "Compilation failed"
}

src_install() {
	einstall || die "Installation failed"
	dodoc AUTHORS ChangeLog COPYING README TODO
}
