# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/huc/huc-0.1.ebuild,v 1.5 2002/08/16 04:04:42 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="HTML umlaut conversion tool"
SRC_URI="http://www.int21.de/huc/${P}.tar.bz2"
HOMEPAGE="http://www.int21.de/huc/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

src_compile() 
{
	emake CFLAGS="${CFLAGS}" || die
}

src_install () 
{
	dobin huc
	dodoc README COPYING
}
