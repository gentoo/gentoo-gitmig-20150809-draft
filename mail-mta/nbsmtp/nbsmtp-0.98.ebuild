# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/nbsmtp/nbsmtp-0.98.ebuild,v 1.1 2004/12/22 12:42:13 ticho Exp $

DESCRIPTION="Extremely simple MTA to get mail off the system to a relayhost"
# original mirror is down, using "mirror 2" from $HOMEPAGE
#SRC_URI="http://www.gentoo-es.org/~ferdy/${P}.tar.bz2"
SRC_URI="http://www.it.uc3m.es/~ferdy/${PN}/${P}.tar.bz2"
HOMEPAGE="http://nbsmtp.ferdyx.org"

SLOT="0"
KEYWORDS="~x86 ~ppc ~hppa ~amd64 ~sparc"
LICENSE="GPL-2"
IUSE="ssl ipv6 debug"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )"

PROVIDE="virtual/mta"

src_compile() {
	local myconf

	econf `use_enable ssl` \
		`use_enable debug` \
		`use_enable ipv6` \
		${myconf} || die

	make || die
}

src_install() {
	dodir /usr/bin
	dobin nbsmtp
	doman nbsmtprc.5 nbsmtp.8
	dodoc INSTALL DOCS Doxyfile
}
