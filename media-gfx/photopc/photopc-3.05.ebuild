# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/photopc/photopc-3.05.ebuild,v 1.5 2003/02/13 12:36:48 vapier Exp $

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
