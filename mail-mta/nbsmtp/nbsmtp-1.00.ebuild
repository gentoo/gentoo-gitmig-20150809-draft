# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-mta/nbsmtp/nbsmtp-1.00.ebuild,v 1.2 2005/07/29 12:27:41 dertobi123 Exp $

inherit eutils

DESCRIPTION="Extremely simple MTA to get mail off the system to a relayhost"
SRC_URI="http://www.gentoo-es.org/~ferdy/${P}.tar.bz2"
#SRC_URI="http://www.it.uc3m.es/~ferdy/${PN}/${P}.tar.bz2"
HOMEPAGE="http://nbsmtp.ferdyx.org"

SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ppc ~sparc x86"
LICENSE="GPL-2"
IUSE="ssl ipv6 debug"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )"

PROVIDE="virtual/mta"

src_compile() {
	econf $(use_enable ssl) \
		$(use_enable debug) \
		$(use_enable ipv6) || die

	make || die
}

src_install() {
	dodir /usr/bin
	dobin nbsmtp
	dobin scripts/nbqueue
	doman nbsmtprc.5 nbsmtp.8
	dodoc INSTALL DOCS Doxyfile
}
