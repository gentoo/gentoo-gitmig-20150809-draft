# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Stein Magnus Jodal <stein.magnus@jodal.no>
# Maintainer: Chris Houser <chouser@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/silc-client/silc-client-0.7.6.2.ebuild,v 1.3 2002/04/12 18:54:01 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Secure Internet Live Conferencing"
SRC_URI="http://www.silcnet.org/download/client/sources/${P}.tar.gz"
HOMEPAGE="http://silcnet.org"
SLOT="0"
DEPEND="virtual/glibc
	=dev-libs/glib-1.2*
	sys-libs/ncurses"

src_compile() {

	myconf="--with-ncurses"

	if [ "`use ipv6`" ]; then
		myconf="${myconf} --enable-ipv6"
	fi

	if [ "`use socks5`" ]; then
		myconf="${myconf} --with-socks5"
	fi

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc/silc \
		--with-helpdir=/usr/share/silc/help \
		--with-docdir=/usr/share/doc/${P} \
		--with-simdir=/usr/lib/silc/modules \
		--with-logsdir=/var/log/silc \
		${myconf} || die "./configure failed"

	make || die "make failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	rmdir ${D}/usr/include
}
