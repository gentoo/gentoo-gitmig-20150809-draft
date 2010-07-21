# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ser2net/ser2net-2.7.ebuild,v 1.1 2010/07/21 00:12:41 sbriesen Exp $

EAPI="2"
WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils autotools

DESCRIPTION="Serial To Network Proxy"
SRC_URI="mirror://sourceforge/ser2net/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/ser2net"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="tcpd? ( sys-apps/tcp-wrappers )"

IUSE="tcpd"

src_prepare() {
	eautoreconf
}

src_compile() {
	local myopts="$(use_with tcpd tcp-wrappers) --with-uucp-locking"
	econf ${myopts} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	einstall
	insinto /etc
	newins ${PN}.conf ${PN}.conf.dist
	newinitd "${FILESDIR}/${PN}.initd" ${PN}
	newconfd "${FILESDIR}/${PN}.confd" ${PN}
	dodoc AUTHORS NEWS README ChangeLog
}
