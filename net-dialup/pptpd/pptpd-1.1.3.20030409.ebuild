# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pptpd/pptpd-1.1.3.20030409.ebuild,v 1.1 2003/04/28 07:35:43 aliz Exp $

S=${WORKDIR}/poptop
DESCRIPTION="Linux Point-to-Point Tunnelling Protocol Server"
SRC_URI="mirror://sourceforge/poptop/pptpd-1.1.3-20030409.tar.gz"
HOMEPAGE="http://www.poptop.org"

DEPEND="virtual/glibc
	net-dialup/ppp" 

SLOT="0"
LICENSE="GPL-2"
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
	doins ${FILESDIR}/1.1.3/pptpd.conf
	insinto /etc/ppp
	dodir /etc/ppp
	insinto /etc/ppp
	doins ${FILESDIR}/1.1.3/options.pptpd

	dodoc README* AUTHORS COPYING INSTALL TODO ChangeLog
	docinto samples; dodoc samples/*
}

