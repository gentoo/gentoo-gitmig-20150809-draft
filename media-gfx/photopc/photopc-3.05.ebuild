# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/photopc/photopc-3.05.ebuild,v 1.1 2002/06/14 18:49:27 rphillips Exp $

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
	into /usr
	dobin photopc
	doman photopc
}

