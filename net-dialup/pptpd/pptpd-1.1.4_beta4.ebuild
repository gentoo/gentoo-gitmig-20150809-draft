# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pptpd/pptpd-1.1.4_beta4.ebuild,v 1.3 2004/07/01 22:09:29 eradicator Exp $

S=${WORKDIR}/poptop-1.1.4
DESCRIPTION="Linux Point-to-Point Tunnelling Protocol Server"
SRC_URI="mirror://sourceforge/poptop/pptpd-1.1.4-b4.tar.gz"
HOMEPAGE="http://www.poptop.org/"

DEPEND="virtual/libc
	net-dialup/ppp
	tcpd? ( sys-apps/tcp-wrappers )"
RDEPEND="$DEPEND"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="tcpd"

src_compile() {
	local myconf
	use tcpd && myconf="--with-libwrap"
	econf 	--with-bcrelay \
		${myconf} || die
	emake || die
}

src_install () {
	einstall || die

	insinto /etc
	doins samples/pptpd.conf

	insinto /etc/ppp
	doins samples/options.pptpd

	exeinto /etc/init.d
	newexe ${FILESDIR}/pptpd-init pptpd

	insinto /etc/conf.d
	newins ${FILESDIR}/pptpd-confd pptpd

	dodoc README* AUTHORS COPYING INSTALL TODO ChangeLog
	docinto samples
	dodoc samples/*
}
