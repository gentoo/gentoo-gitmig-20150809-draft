# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pptpd/pptpd-1.1.2.ebuild,v 1.3 2002/07/17 10:43:25 seemant Exp $

S=${WORKDIR}/pptpd-1.1.2
DESCRIPTION="Linux Point-to-Point Tunnelling Protocol Server"
SRC_URI="http://www.mirrors.wiretapped.net/security/network-security/poptop/pptpd-1.1.2.tar.gz"
HOMEPAGE="http://poptop.lineo.com"

DEPEND="virtual/glibc net-dialup/ppp" 

SLOT="0"
LICENSE="GPL"
KEYWORDS="x86"

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

