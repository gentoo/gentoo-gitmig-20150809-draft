# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/LeakTracer/LeakTracer-2.3.ebuild,v 1.1 2003/09/06 10:26:39 sergey Exp $

DESCRIPTION="LeakTracer - trace and analyze memory leaks in C++ programs."

S=${WORKDIR}/${PN}
HOMEPAGE="http://www.andreasen.org/LeakTracer/"
SRC_URI="http://www.andreasen.org/${PN}/${PN}.tar.gz"

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
	einfo "Please refferto README file for more info."
}
