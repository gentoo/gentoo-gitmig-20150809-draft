# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/mserver/mserver-0.5.5-r2.ebuild,v 1.5 2008/05/14 22:02:31 flameeyes Exp $

inherit eutils pam

DESCRIPTION="Daemon that provides control of dial-up links to other PCs on the LAN"
HOMEPAGE="None available"
SRC_URI="mirror://gentoo/c-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/pam"
RDEPEND="${DEPEND}
	net-dialup/ppp"

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

	pamd_mimic_system mserver auth account password session

	newinitd "${FILESDIR}/mserver-init" mserver
}
