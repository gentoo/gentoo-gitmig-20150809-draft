# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/physfs/physfs-0.1.8.ebuild,v 1.1 2003/08/17 20:58:11 vapier Exp $

DESCRIPTION="abstraction layer for filesystems, useful for games"
SRC_URI="http://icculus.org/physfs/downloads/${P}.tar.gz"
HOMEPAGE="http://icculus.org/physfs/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_compile() {
	econf || die "./configure failed"
	emake || die "Compilation failed"
}

src_install() {
	einstall || die "Installation failed"
	dodoc AUTHORS ChangeLog COPYING README TODO
}
