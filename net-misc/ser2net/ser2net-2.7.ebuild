# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ser2net/ser2net-2.7.ebuild,v 1.5 2012/03/25 15:54:54 armin76 Exp $

EAPI="2"

inherit eutils autotools

DESCRIPTION="Serial To Network Proxy"
SRC_URI="mirror://sourceforge/ser2net/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/ser2net"

KEYWORDS="~amd64 ppc x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="tcpd? ( sys-apps/tcp-wrappers )"

IUSE="tcpd"

src_prepare() {
	eautoreconf
}

src_configure() {
	local myopts="$(use_with tcpd tcp-wrappers) --with-uucp-locking"
	econf ${myopts} || die "econf failed"
}

src_install () {
	einstall
	insinto /etc
	newins ${PN}.conf ${PN}.conf.dist
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
	dodoc AUTHORS NEWS README ChangeLog
}
