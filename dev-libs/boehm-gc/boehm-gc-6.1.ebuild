# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boehm-gc/boehm-gc-6.1.ebuild,v 1.4 2003/02/13 10:34:13 vapier Exp $

S=${WORKDIR}/gc${PV}

IUSE=""
DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
SRC_URI="http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/gc${PV}.tar.gz"
HOMEPAGE="http://www.hpl.hp.com/personal/Hans_Boehm/gc/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ~sparc "

DEPEND="virtual/glibc"

src_compile() {
	econf --enable-threads=pthreads \
		|| die "Configure failed..."
	emake || die
}

src_install () {
	einstall || die

	dodir /usr/include/gc
	insinto /usr/include/gc
	doins include/*.h 
	
	dodoc README.QUICK doc/README* doc/barrett_diagram
	dohtml doc
	mv doc/gc.man doc/gc.3
	doman doc/gc.3
}
