# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boehm-gc/boehm-gc-6.0.ebuild,v 1.3 2002/08/01 16:07:17 seemant Exp $

S=${WORKDIR}/gc6.0
DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector can be used as a garbage collecting replacement for C malloc or C++ new. It is also used by a number of programming language implementations that use C as intermediate code."
SRC_URI="http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/gc6.0.tar.gz"
HOMEPAGE="http://www.hpl.hp.com/personal/Hans_Boehm/gc/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86"

DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install () {
	dodir /usr/include/gc
	insinto /usr/include/gc
	doins include/*.h 
	
	mv gc.a libgc.a
	dodir /usr/lib
	dolib.a libgc.a
	
	dodoc README.QUICK doc/README* doc/barrett_diagram
	dohtml doc
	doman doc/gc.man
}
