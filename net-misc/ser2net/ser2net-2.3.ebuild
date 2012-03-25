# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ser2net/ser2net-2.3.ebuild,v 1.9 2012/03/25 15:54:54 armin76 Exp $

inherit autotools eutils

DESCRIPTION="Serial To Network Proxy"
SRC_URI="mirror://sourceforge/ser2net/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/ser2net"

KEYWORDS="~amd64 ppc x86"
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
