# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/oftpd/oftpd-0.3.7-r3.ebuild,v 1.5 2007/01/05 14:18:09 beandog Exp $

inherit eutils

DESCRIPTION="Secure, small, anonymous only ftpd"
HOMEPAGE="http://www.time-travellers.org/oftpd"
SRC_URI="http://www.time-travellers.org/oftpd/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ppc64 ~sh sparc x86"
IUSE=""

DEPEND="net-ftp/ftpbase"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Don't crash when using an unsupported address family, #159178.
	epatch "${FILESDIR}"/oftpd-0.3.7-family.patch
}

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
	newinitd "${FILESDIR}"/init.d.oftpd oftpd
	newconfd "${FILESDIR}"/conf.d.oftpd oftpd
}
