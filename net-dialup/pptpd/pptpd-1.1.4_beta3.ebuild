# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pptpd/pptpd-1.1.4_beta3.ebuild,v 1.1 2003/06/28 17:14:08 jhhudso Exp $

S=${WORKDIR}/poptop-1.1.4
DESCRIPTION="Linux Point-to-Point Tunnelling Protocol Server"
SRC_URI="mirror://sourceforge/poptop/pptpd-1.1.4-b3.tar.gz"
HOMEPAGE="http://www.poptop.org/"

DEPEND="virtual/glibc
	net-dialup/ppp"
RDEPEND="$DEPEND"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

src_compile() {
	econf --with-bcrelay || die
	emake || die
}

src_install () {
	einstall || die

	insinto /etc
	doins ${FILESDIR}/1.1.4_beta3/pptpd.conf

	dodir /etc/ppp
	insinto /etc/ppp
	doins ${FILESDIR}/1.1.4_beta3/options.pptpd

	exeinto /etc/init.d
	newexe ${FILESDIR}/pptpd-init pptpd

	insinto /etc/conf.d
	newins ${FILESDIR}/pptpd-confd pptpd

	dodoc README* AUTHORS COPYING INSTALL TODO ChangeLog
	docinto samples
	dodoc samples/*
}
