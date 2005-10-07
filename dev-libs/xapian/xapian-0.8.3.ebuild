# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xapian/xapian-0.8.3.ebuild,v 1.3 2005/10/07 10:18:44 dragonheart Exp $

IUSE=""

S=${WORKDIR}/xapian-core-${PV}
DESCRIPTION="Xapian Probabilistic Information Retrieval library"
SRC_URI="http://www.oligarchy.co.uk/xapian/${PV}/xapian-core-${PV}.tar.gz"
HOMEPAGE="http://www.xapian.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc x86"

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

	dodoc AUTHORS HACKING PLATFORMS README Changelog
}
