# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/oftpd/oftpd-0.3.7.ebuild,v 1.6 2004/03/27 22:23:40 lu_zero Exp $

DESCRIPTION="Secure, small, anonymous only ftpd"
HOMEPAGE="http://www.time-travellers.org/oftpd"
SRC_URI="http://www.time-travellers.org/oftpd/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc ~ppc64 sparc"

DEPEND="virtual/glibc"

src_compile() {
	# local myconf
	# ipv6 support busted according to lamer
	# use ipv6 && myconf="${myconf} --enable-ipv6"
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS FAQ NEWS README TODO
	dodir /home/ftp
	exeinto /etc/init.d
	newexe ${FILESDIR}/init.d.oftpd oftpd
	insinto /etc/conf.d
	newins ${FILESDIR}/conf.d.oftpd oftpd
}
