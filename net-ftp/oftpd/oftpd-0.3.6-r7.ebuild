# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-ftp/oftpd/oftpd-0.3.6-r7.ebuild,v 1.3 2002/08/16 14:24:49 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Secure, small, anonymous only ftpd"
SRC_URI="http://www.time-travellers.org/oftpd/${P}.tar.gz"
HOMEPAGE="http://www.time-travellers.org/oftpd"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc sparc64"

src_compile() {
	# local myconf
	# ipv6 support busted according to lamer
	# use ipv6 && myconf="${myconf} --enable-ipv6"
	./configure \
		--prefix=/usr \
		--bindir=/usr/sbin \
		--mandir=/usr/share/man \
		--host=${CHOST} ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING INSTALL FAQ NEWS README TODO
	dodir /home/ftp
	exeinto /etc/init.d
	newexe ${FILESDIR}/oftpd.rc6 oftpd
}
