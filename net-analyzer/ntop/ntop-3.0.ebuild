# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ntop/ntop-3.0.ebuild,v 1.8 2004/07/25 13:35:01 eldad Exp $

DESCRIPTION="tool that shows network usage like top"
HOMEPAGE="http://www.ntop.org/ntop.html"
SRC_URI="mirror://sourceforge/ntop/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~amd64"
IUSE="ssl readline tcpd ncurses"

DEPEND=">=sys-libs/gdbm-1.8.0
	>=net-libs/libpcap-0.5.2
	>=media-libs/gd-2.0.22
	>=media-libs/libpng-1.2.5
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r4 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	readline? ( >=sys-libs/readline-4.1 )
	ncurses? ( sys-libs/ncurses )"

src_compile() {
	local myconf

	use readline	|| myconf="${myconf} --without-readline"
	use tcpd	|| myconf="${myconf} --with-tcpwrap"
	use ssl		|| myconf="${myconf} --without-ssl"
	use ncurses	|| myconf="${myconf} --without-curses"

	econf ${myconf} || die "configure problem"
	make || die "compile problem"
}

src_install () {
	make DESTDIR=${D} install || die "install problem"

	# fixme: bad handling of plugins (in /usr/lib with unsuggestive names)
	# (don't know if there is a clean way to handle it)

	doman ntop.8

	dodoc AUTHORS CONTENTS COPYING ChangeLog MANIFESTO NEWS
	dodoc PORTING README SUPPORT_NTOP.txt THANKS docs/*

	dohtml ntop.html

	keepdir /var/lib/ntop
	chown -R nobody:nobody ${D}/var/lib/ntop

	exeinto /etc/init.d ; newexe ${FILESDIR}/ntop-init ntop
	insinto /etc/conf.d ; newins ${FILESDIR}/ntop-confd ntop
}
