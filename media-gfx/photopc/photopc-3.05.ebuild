# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/photopc/photopc-3.05.ebuild,v 1.9 2004/07/14 17:49:11 agriffis Exp $

DESCRIPTION="Utility to control digital cameras based on Sierra Imaging firmware"
SRC_URI="mirror://sourceforge/photopc/${P}.tar.gz"
HOMEPAGE="http://photopc.sourceforge.net"

SLOT="0"
LICENSE="BSD | as-is"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"

src_unpack ()
{
	unpack ${A}
	cd ${S}
}

src_install ()
{
	dobin photopc
	dobin epinfo
	doman photopc.1
	doman epinfo.1
}
