# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xapian/xapian-0.9.3-r1.ebuild,v 1.1 2006/02/18 11:51:41 dragonheart Exp $

inherit eutils

IUSE=""

S=${WORKDIR}/xapian-core-${PV}
DESCRIPTION="Xapian Probabilistic Information Retrieval library"
SRC_URI="http://www.oligarchy.co.uk/xapian/${PV}/xapian-core-${PV}.tar.gz"
HOMEPAGE="http://www.xapian.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

DEPEND="virtual/libc
	sys-apps/gawk
	sys-apps/grep
	sys-apps/sed
	sys-devel/libtool
	sys-devel/gcc"

RDEPEND="virtual/libc"


src_unpack() {
	unpack "${A}"
	epatch "${FILESDIR}/${P}-config.patch"
}

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
	emake DESTDIR=${D} install || die

	#docs tly et installed under /usr/share/doc/xapian-core,
	# lets move them under /usr/share/doc..
	mv ${D}/usr/share/doc/xapian-core ${D}/usr/share/doc/${PF}

	dodoc AUTHORS HACKING PLATFORMS README
}
