# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/leaktracer/leaktracer-2.4.ebuild,v 1.1 2004/01/06 10:17:57 sergey Exp $

DESCRIPTION="LeakTracer - trace and analyze memory leaks in C++ programs."

S=${WORKDIR}/${P}
HOMEPAGE="http://www.andreasen.org/LeakTracer/"
SRC_URI="mirror://gentoo/${P}.tbz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="virtual/glibc
		>=dev-lang/perl-5
		sys-devel/gdb"

src_compile() {
	epatch ${FILESDIR}/LeakCheck-gentoo.patch
	make
}

src_install() {
	dobin LeakCheck
	dobin leak-analyze
	dolib.so LeakTracer.so
	dohtml README.html
	dodoc README VERSION
}

pkg_postinst() {
	einfo "To use LeakTracer, run LeakCheck my_prog and then leak-analyze my_prog leak.out"
	einfo "Please reffer to README file for more info."
}
