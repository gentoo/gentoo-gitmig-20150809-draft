# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/oftpd/oftpd-0.3.7-r1.ebuild,v 1.9 2008/11/02 12:36:44 jmbsvicetto Exp $

DESCRIPTION="Secure, small, anonymous only ftpd"
HOMEPAGE="http://www.time-travellers.org/oftpd"
SRC_URI="http://www.time-travellers.org/oftpd/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 arm ~ppc ppc64 sparc x86"
IUSE=""

DEPEND=""

src_compile() {
	# local myconf
	# ipv6 support busted according to lamer
	# use ipv6 && myconf="${myconf} --enable-ipv6"
	econf --bindir=/usr/sbin || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS FAQ NEWS README TODO
	keepdir /home/ftp
	newinitd "${FILESDIR}/init.d.oftpd" oftpd
	newconfd "${FILESDIR}/conf.d.oftpd" oftpd
}
