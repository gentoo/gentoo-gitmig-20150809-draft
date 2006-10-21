# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xapian/xapian-0.9.6.ebuild,v 1.2 2006/10/21 12:00:57 nixnut Exp $

DESCRIPTION="Xapian Probabilistic Information Retrieval library"
HOMEPAGE="http://www.xapian.org/"
SRC_URI="http://www.oligarchy.co.uk/xapian/${PV}/xapian-core-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc ~x86"
IUSE=""

DEPEND="virtual/libc
	sys-apps/gawk
	sys-apps/grep
	sys-apps/sed
	sys-devel/libtool
	sys-devel/gcc"

RDEPEND="virtual/libc"

S=${WORKDIR}/xapian-core-${PV}


src_test() {
	if has_version '<=dev-util/valgrind-2.3.0';
	then
		#valgrind-2.2 caused errors here.
		make check VALGRIND= || die "check failed"
	else
		make check || die "check failed"
	fi
}


src_install () {
	emake -j1 DESTDIR="${D}" install || die

	mv "${D}/usr/share/doc/xapian-core" "${D}/usr/share/doc/${PF}"

	dodoc AUTHORS HACKING PLATFORMS README
}
