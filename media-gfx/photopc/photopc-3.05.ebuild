# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/photopc/photopc-3.05.ebuild,v 1.3 2002/07/23 05:18:07 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utility to control digital cameras based on Sierra Imaging firmware"
SRC_URI="mirror://sourceforge/photopc/${P}.tar.gz"
HOMEPAGE="http://photopc.sourceforge.net"

SLOT="0"
LICENSE="BSD | as-is"
KEYWORDS="x86"

DEPEND="virtual/glibc"

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
