# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ser2net/ser2net-2.3.ebuild,v 1.8 2010/10/28 12:21:55 ssuominen Exp $

inherit autotools eutils

DESCRIPTION="Serial To Network Proxy"
SRC_URI="mirror://sourceforge/ser2net/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/ser2net"

KEYWORDS="~amd64 ppc sparc x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="tcpd"

RDEPEND="tcpd? ( sys-apps/tcp-wrappers )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	eautoreconf
}

src_compile() {
	econf $(use_with tcpd tcp-wrappers)
	emake || die
}

src_install () {
	einstall || die
	insinto /etc
	doins ser2net.conf
	dodoc AUTHORS NEWS README ChangeLog
}
