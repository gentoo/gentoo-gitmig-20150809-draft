# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/serialmail/serialmail-0.75.ebuild,v 1.7 2004/07/15 02:27:13 agriffis Exp $

IUSE=""

DESCRIPTION="A serialmail is a collection of tools for passing mail
across serial links."
HOMEPAGE="http://cr.yp.to/serialmail.html"
SRC_URI="http://cr.yp.to/software/${P}.tar.gz"

DEPEND="virtual/libc
	sys-apps/groff
	>=sys-apps/ucspi-tcp-0.88"

RDEPEND="virtual/libc
	sys-apps/groff
	>=sys-apps/ucspi-tcp-0.88
	>=sys-apps/daemontools-0.76-r1"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc"

src_unpack() {

	unpack ${P}.tar.gz
	cd ${S}

	echo "/usr" > conf-home
	echo "gcc ${CFLAGS}" > conf-cc
	echo "gcc" > conf-ld
	echo "500" > conf-spawn

}

src_compile() {

	grep -v man hier.c | grep -v doc > hier.c

	emake it man || die

}

src_install() {

	dodir /usr

	echo "${D}/usr" > conf-home

	make man setup check || die

	dodoc AUTOTURN CHANGES FROMISP SYSDEPS THANKS TOISP \
		BLURB FILES INSTALL README TARGETS TODO VERSION

	doman maildirqmtp.1 maildirserial.1 maildirsmtp.1 \
		serialqmtp.1 serialsmtp.1 setlock.1
}
