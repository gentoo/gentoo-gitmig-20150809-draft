# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boehm-gc/boehm-gc-6.0.ebuild,v 1.10 2003/09/06 22:29:24 msterret Exp $

S=${WORKDIR}/gc${PV}

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector can be used as a garbage collecting replacement for C malloc or C++ new. It is also used by a number of programming language implementations that use C as intermediate code."
HOMEPAGE="http://www.hpl.hp.com/personal/Hans_Boehm/gc/"
SRC_URI="http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/gc6.0.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="virtual/glibc"

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/include/gc
	insinto /usr/include/gc
	doins include/*.h

	mv gc.a libgc.a
	dodir /usr/lib
	dolib.a libgc.a

	dodoc README.QUICK doc/README* doc/barrett_diagram
	dohtml doc
	mv doc/gc.man doc/gc.1
	doman doc/gc.1
}
