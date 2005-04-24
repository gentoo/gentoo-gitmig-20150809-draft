# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irc-client/irc-client-2.10.3_p3.ebuild,v 1.9 2005/04/24 13:11:27 hansmi Exp $

MY_P=irc${PV/_/}

DESCRIPTION="A simplistic RFC compliant IRC client"
HOMEPAGE="http://www.irc.org"
SRC_URI="ftp://ftp.irc.org/irc/server/${MY_P}.tgz"
LICENSE="GPL-1"
SLOT="0"

KEYWORDS="x86 ppc"
IUSE="ipv6"

DEPEND="virtual/libc
	sys-libs/ncurses
	sys-libs/zlib"

S=${WORKDIR}/${MY_P}

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
