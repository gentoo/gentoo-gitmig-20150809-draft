# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/pptpd/pptpd-1.2.1.ebuild,v 1.2 2005/02/12 09:36:50 mrness Exp $

DESCRIPTION="Linux Point-to-Point Tunnelling Protocol Server"
SRC_URI="mirror://sourceforge/poptop/${P}.tar.gz"
HOMEPAGE="http://www.poptop.org/"

DEPEND="virtual/libc
	net-dialup/ppp
	tcpd? ( sys-apps/tcp-wrappers )"
RDEPEND="$DEPEND"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"
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

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README* TODO
	docinto samples
	dodoc samples/*
}
