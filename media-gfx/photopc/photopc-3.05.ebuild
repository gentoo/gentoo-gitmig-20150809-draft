# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/photopc/photopc-3.05.ebuild,v 1.2 2002/06/27 18:02:06 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="photopc"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/photopc/${P}.tar.gz"
HOMEPAGE="http://photopc.sourceforge.net"
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

