# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/mserver/mserver-0.5.5-r2.ebuild,v 1.1 2006/02/08 18:29:34 mrness Exp $

inherit eutils

DESCRIPTION="Daemon that provides control of dial-up links to other PCs on the LAN"
HOMEPAGE="http://cpwright.com/mserver/"
SRC_URI="http://cpwright.com/mserver/download/c-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/pam"
RDEPEND="net-dialup/ppp"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-errno.patch"
	epatch "${FILESDIR}/${P}-gcc4.patch"
}

src_install() {
	dosbin mserver/mserver mchat/mchat authgen/authgen checkstat/checkstat
	doman mchat/mchat.8
	dodoc mserver/PROTOCOL README docs/index.html
	newdoc mchat/README README.mchat
	docinto images
	dodoc docs/images/*.gif docs/images/*.jpg

	insinto /etc
	newins mserver/mserver.conf mserver.conf.dist

	insinto /etc/pam.d
	doins pam/mserver

	exeinto /etc/init.d
	newexe "${FILESDIR}/mserver-init mserver"
}
