# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: Sean Mitchell <sean@arawak.tzo.org>
# /space/gentoo/cvsroot/gentoo-x86/skel.build,v 1.11 2001/12/06 22:12:34 drobbins Exp

S=${WORKDIR}/${P}
DESCRIPTION="Cook is a tool for constructing files. It is a replacement for make."
SRC_URI="http://www.canb.auug.org.au/~millerp/cook/${P}.tar.gz"
HOMEPAGE="http://www.canb.auug.org.au/~millerp/cook/cook.html"
DEPEND="sys-devel/bison"

src_compile()
{
	./configure --prefix=/usr || die "./configure failed"

	# doesn't seem to like emake
	make || die
}


src_install ()
{

	# we'll hijack the RPM_BUILD_ROOT variable which is intended for a 
	# similiar purpose anyway
	make RPM_BUILD_ROOT=${D} install || die
}

