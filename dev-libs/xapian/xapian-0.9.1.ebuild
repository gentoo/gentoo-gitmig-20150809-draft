# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xapian/xapian-0.9.1.ebuild,v 1.1 2005/06/25 23:27:45 dragonheart Exp $

IUSE=""

S=${WORKDIR}/xapian-core-${PV}
DESCRIPTION="Xapian Probabilistic Information Retrieval library"
SRC_URI="http://www.oligarchy.co.uk/xapian/${PV}/xapian-core-${PV}.tar.gz"
HOMEPAGE="http://www.xapian.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/libc
	sys-apps/gawk
	sys-apps/grep
	sys-apps/sed
	sys-devel/libtool
	sys-devel/bison
	sys-devel/gcc"

RDEPEND="virtual/libc"


src_test() {
	make check || einfo "stemtest and internaltest are known to fail with loading shared libraries: cannot apply additional memory protection after relocation: Cannot allocate memory: SEGFAULT"
}

src_install () {
	emake DESTDIR=${D} install || die

	#docs tly et installed under /usr/share/doc/xapian-core,
	# lets move them under /usr/share/doc..
	mv ${D}/usr/share/doc/xapian-core ${D}/usr/share/doc/${PF}

	dodoc AUTHORS COPYING HACKING INSTALL PLATFORMS README
}
