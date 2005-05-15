# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/sms/sms-1.9.2m.ebuild,v 1.1 2005/05/15 19:50:28 mrness Exp $

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
	sys-devel/gcc
	>=sys-apps/sed-4"

S=${WORKDIR}/${PN}

src_compile() {
	sed -i -e 's:^CFLAGS.*::' Makefile
	emake || die
}

src_install() {
	rm -rf contrib/CVS
	emake INSTALL_PREFIX=${D}/usr INSTALL_DOC=${D}/usr/share/doc/${PF}  INSTALL_MAN=${D}/usr/share/man install
}
