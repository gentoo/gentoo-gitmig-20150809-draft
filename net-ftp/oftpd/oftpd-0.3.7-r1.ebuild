# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/oftpd/oftpd-0.3.7-r1.ebuild,v 1.1 2004/03/31 19:29:05 eradicator Exp $

DESCRIPTION="Secure, small, anonymous only ftpd"
SRC_URI="http://www.time-travellers.org/oftpd/${P}.tar.gz"
HOMEPAGE="http://www.time-travellers.org/oftpd"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc ~ppc ~ppc64"

src_compile() {
	# local myconf
	# ipv6 support busted according to lamer
	# use ipv6 && myconf="${myconf} --enable-ipv6"
	econf --bindir=/usr/sbin || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS FAQ NEWS README TODO
	keepdir /home/ftp
	exeinto /etc/init.d
	newexe ${FILESDIR}/init.d.oftpd oftpd
	insinto /etc/conf.d
	newins ${FILESDIR}/conf.d.oftpd oftpd
}
