# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/cook/cook-2.20.ebuild,v 1.3 2002/08/08 13:27:41 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Cook is a tool for constructing files. It is a replacement for make."
SRC_URI="http://www.canb.auug.org.au/~millerp/cook/${P}.tar.gz"
HOMEPAGE="http://www.canb.auug.org.au/~millerp/cook/cook.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="sys-devel/bison"

src_compile()
{
	econf || die "./configure failed"

	# doesn't seem to like emake
	make || die
}


src_install ()
{

	# we'll hijack the RPM_BUILD_ROOT variable which is intended for a 
	# similiar purpose anyway
	make RPM_BUILD_ROOT=${D} install || die
}
