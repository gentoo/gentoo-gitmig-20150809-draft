# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/whois/whois-4.6.13-r1.ebuild,v 1.2 2004/07/17 16:39:19 tgall Exp $

inherit eutils

IUSE="nls"
MY_P=${P/-/_}
DESCRIPTION="improved Whois Client"
SRC_URI="http://www.linux.it/~md/software/${MY_P}.tar.gz"
HOMEPAGE="http://www.linux.it/~md/software/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips hppa ~ia64 alpha ~amd64 ppc64"

DEPEND=">=sys-apps/sed-4
	>=dev-lang/perl-5"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s/-O2/$CFLAGS/" Makefile

	use nls && ( \
		cd po
		sed -i -e "s:/usr/bin/install:install:" Makefile
	) || ( \
		sed -i -e "s:cd po.*::" Makefile
	)

	epatch ${FILESDIR}/${P}-gentoo-security.patch || die
}

src_compile() {
	make || die
	make mkpasswd || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	use nls && dodir /usr/share/locale
	make BASEDIR=${D} prefix=/usr mandir=/usr/share/man install || die

	dobin mkpasswd
	doman mkpasswd.1
	dodoc README whois.conf debian/changelog debian/copyright

	einfo ""
	einfo "The example whois.conf is located in /usr/doc/${P}"
	einfo ""
}
