# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pptpd/pptpd-1.1.2.ebuild,v 1.11 2004/07/14 23:06:12 agriffis Exp $

S=${WORKDIR}/pptpd-1.1.2
DESCRIPTION="Linux Point-to-Point Tunnelling Protocol Server"
SRC_URI="http://www.mirrors.wiretapped.net/security/network-security/poptop/pptpd-1.1.2.tar.gz"
HOMEPAGE="http://poptop.lineo.com/"

DEPEND="virtual/libc net-dialup/ppp"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make \
	DESTDIR=${D} \
	man_prefix=/usr/share/man \
	install || die

	insinto /etc
	doins ${FILESDIR}/pptpd.conf
	insinto /etc/ppp
	dodir /etc/ppp
	insinto /etc/ppp
	doins ${FILESDIR}/options.pptpd

	dodoc README* AUTHORS COPYING INSTALL TODO ChangeLog
	docinto samples; dodoc samples/*
}
