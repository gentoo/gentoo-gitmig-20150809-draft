# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jmbus/jmbus-1.0.7.ebuild,v 1.1 2003/05/23 04:12:10 tberman Exp $

inherit java-pkg

DESCRIPTION="Java Message Bus (RFC 3259) library"
HOMEPAGE="http://www.mbus.org/"
SRC_URI="ftp://ftp.informatik.uni-bremen.de/home/prelle/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND="virtual/jdk
	sys-devel/libtool
	dev-util/pkgconfig"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	java-pkg_dojar src/jmbus.jar
	insinto /usr/lib/pkgconfig
	doins src/jmbus.pc
	dobin jmspy.sh
	dobin jmbuskeygen.sh
	dobin jcetest.sh
	dodoc AUTHORS README TODO INSTALL
}

