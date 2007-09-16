# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kovpn/kovpn-0.3_pre6-r1.ebuild,v 1.2 2007/09/16 05:06:29 josejx Exp $

inherit kde

DESCRIPTION="kovpn - a simple OpenVPN GUI"
SRC_URI="http://home.bawue.de/~lighter/www.enlighter.de/files/${P}.tar.bz2"
HOMEPAGE="http://www.enlighter.de"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
SLOT="0"
S=${WORKDIR}/${P}

DEPEND=">=net-misc/openvpn-2.0"
need-kde 3.4

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/traywindow_x86_64.patch
}
