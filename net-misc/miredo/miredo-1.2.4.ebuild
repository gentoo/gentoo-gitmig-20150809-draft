# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/miredo/miredo-1.2.4.ebuild,v 1.1 2011/07/26 21:59:17 xmw Exp $

EAPI=3

inherit eutils

DESCRIPTION="Miredo is an open-source Teredo IPv6 tunneling software."
HOMEPAGE="http://www.remlab.net/miredo/"
SRC_URI="http://www.remlab.net/files/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+caps"

DEPEND="dev-libs/judy
	caps? ( sys-libs/libcap )"
RDEPEND="${DEPEND}
	sys-apps/iproute2"

#tries to connect to external networks (#339180)
RESTRICT="test"

src_configure() {
	econf --enable-miredo-user \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--docdir="/usr/share/doc/${P}"
	use caps || \
		echo "#undef HAVE_SYS_CAPABILITY_H" >> config.h
}

src_install() {
	emake DESTDIR="${D}" install || die
	newinitd "${FILESDIR}"/miredo-server.rc miredo-server || die
	newconfd "${FILESDIR}"/miredo-server.conf miredo-server || die
	newinitd "${FILESDIR}"/miredo.rc miredo || die
	newconfd "${FILESDIR}"/miredo.conf miredo || die
	insinto /etc/miredo
	doins misc/miredo-server.conf || die
	dodoc README NEWS ChangeLog AUTHORS THANKS TODO || die
}

pkg_preinst() {
	enewgroup miredo
	enewuser miredo -1 -1 /var/empty miredo
}
