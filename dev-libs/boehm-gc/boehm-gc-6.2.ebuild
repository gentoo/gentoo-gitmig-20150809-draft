# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boehm-gc/boehm-gc-6.2.ebuild,v 1.1 2003/07/29 16:23:22 usata Exp $

S=${WORKDIR}/gc${PV/_/}

IUSE=""
DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
SRC_URI="http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/gc${PV/_/}.tar.gz"
HOMEPAGE="http://www.hpl.hp.com/personal/Hans_Boehm/gc/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~x86 ~sparc ~alpha ~ppc"

DEPEND="virtual/glibc"

src_compile() {
	econf --enable-threads=pthreads \
		|| die "Configure failed..."
	emake || die
}

src_install () {
	emake prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		DESTDIR=${D} install-exec || die
	insinto /usr/include/gc
	doins include/*.h

	dodoc README.QUICK doc/README* doc/barrett_diagram
	dohtml doc/*.html
	newman doc/gc.man gc.3
}
