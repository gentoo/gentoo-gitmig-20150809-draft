# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xapian/xapian-0.8.3.ebuild,v 1.1 2004/11/14 14:36:57 dragonheart Exp $

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

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	emake DESTDIR=${D} install || die

	#docs tly et installed under /usr/share/doc/xapian-core,
	# lets move them under /usr/share/doc..
	mv ${D}/usr/share/doc/xapian-core ${D}/usr/share/doc/${PF}

	dodoc AUTHORS COPYING HACKING INSTALL PLATFORMS README Changelog
}
