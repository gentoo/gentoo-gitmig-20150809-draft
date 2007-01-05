# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irc-client/irc-client-2.10.3_p7.ebuild,v 1.2 2007/01/05 08:48:27 flameeyes Exp $


MY_P=irc${PV/_/}
DESCRIPTION="A simplistic RFC compliant IRC client"
HOMEPAGE="http://www.irc.org"
SRC_URI="ftp://ftp.irc.org/irc/server/${MY_P}.tgz"
LICENSE="GPL-1"
SLOT="0"

KEYWORDS="~x86 ~ppc"
IUSE="ipv6"

DEPEND="virtual/libc
	sys-libs/ncurses
	sys-libs/zlib"

S=${WORKDIR}/${MY_P}

src_compile () {
	econf \
		`use_with ipv6 ip6` \
		--sysconfdir=/etc/ircd \
		--localstatedir=/var/run/ircd \
		|| die "econf failed"
	emake -C ${CHOST} client || die "client build failed"
}

src_install() {
	make -C ${CHOST} \
		prefix=${D}/usr \
		client_man_dir=${D}/usr/share/man/man1 \
		install-client || die "client installed failed"
	dodoc doc/Etiquette doc/alt-irc-faq doc/rfc*
}
