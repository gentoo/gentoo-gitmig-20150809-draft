# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/whois/whois-4.6.22.ebuild,v 1.2 2004/11/03 00:23:44 vapier Exp $

inherit eutils

MY_P=${P/-/_}
DESCRIPTION="improved Whois Client"
HOMEPAGE="http://www.linux.it/~md/software/"
SRC_URI="mirror://debian/pool/main/w/whois/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="nls"
RESTRICT="maketest" #59327

RDEPEND="virtual/libc
	net-dns/libidn"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-4.6.13-gentoo-security.patch

	if use nls ; then
		cd po
		sed -i -e "s:/usr/bin/install:install:" Makefile
	else
		sed -i -e "s:cd po.*::" Makefile
	fi
}

src_compile() {
	emake OPTS="${CFLAGS}" HAVE_LIBIDN=1 || die
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	make BASEDIR=${D} prefix=/usr install || die
	dodoc README whois.conf
}
