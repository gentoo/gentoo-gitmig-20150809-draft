# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irc-client/irc-client-2.10.3_p3.ebuild,v 1.3 2004/01/30 17:47:23 zul Exp $

MY_P=irc
MY_PV=2.10.3p3
DESCRIPTION="A simplistic RFC compliant IRC client"
HOMEPAGE="http://www.irc.org"
SRC_URI="ftp://ftp.irc.org/irc/server/${MY_P}${MY_PV}.tgz
		 ftp://ftp.funet.fi/pub/unix/irc/server/${MY_P}${MY_PV}.tgz"
LICENSE="GPL-1"
SLOT="0"

KEYWORDS="x86"
IUSE="ipv6"

DEPEND="virtual/glibc
		sys-libs/ncurses
		sys-libs/zlib"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}${MY_PV}

src_compile () {

	use ipv6 && myconf="--with-ip6" || myconf="--without-ip6"

	./configure \
		--prefix=/usr \
		--host=${CHOST} \
		--mandir=/usr/share/man \
		--sysconfdir=/etc/ircd \
		--localstatedir=/var/run/ircd \
		$myconf || die "Configure failed"

	# irc doesnt recognize the proper CHOST properly in some cases.
	# Cheap hack to get it working properly. - zul
	cd `support/config.guess`
	emake client || die "client build failed"
}

src_install() {

	# See note above.
	cd `support/config.guess`
	make \
		prefix=${D}/usr \
		client_man_dir=${D}/usr/share/man/man1 \
		install-client || die "client installed failed"
	dodoc ../doc/Etiquette ../doc/alt-irc-faq ../doc/rfc*
}
