# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/whois/whois-4.6.13-r1.ebuild,v 1.3 2004/10/16 18:08:05 vapier Exp $

inherit eutils

MY_P=${P/-/_}
DESCRIPTION="improved Whois Client"
HOMEPAGE="http://www.linux.it/~md/software/"
SRC_URI="http://www.linux.it/~md/software/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE="nls"

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
	emake || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	use nls && dodir /usr/share/locale
	make BASEDIR=${D} prefix=/usr mandir=/usr/share/man install || die

	dodoc README whois.conf debian/changelog debian/copyright
}
