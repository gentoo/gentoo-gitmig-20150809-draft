# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sms/sms-1.9.2l.ebuild,v 1.4 2004/07/01 21:53:47 squinky86 Exp $

DESCRIPTION="Command line program for sending SMS to Polish GSM mobile phone users"
HOMEPAGE="http://ceti.pl/~miki/komputery/sms.html"
SRC_URI="http://ceti.pl/~miki/komputery/download/sms/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RDEPEND="virtual/libc
	sys-libs/gdbm"

DEPEND="${RDEPEND}
	sys-devel/gcc"

S=${WORKDIR}/${PN}

src_compile() {
	emake || die
}

src_install() {
	rm -rf contrib/CVS
	emake INSTALL_PREFIX=${D}/usr INSTALL_DOC=${D}/usr/share/doc/${PF}  INSTALL_MAN=${D}/usr/share/man install
}
