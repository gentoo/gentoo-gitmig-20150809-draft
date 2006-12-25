# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/squidclamav/squidclamav-3.0.ebuild,v 1.2 2006/12/25 08:58:28 kingtaco Exp $

inherit eutils

DESCRIPTION="A Squid redirector to allow easy antivirus file scanning, using ClamAV"
HOMEPAGE="http://www.samse.fr/GPL/"
SRC_URI="http://www.samse.fr/GPL/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-misc/curl-7.12.1
	dev-libs/openssl
	sys-libs/zlib
	app-arch/bzip2"
RDEPEND="${DEPEND}
	net-proxy/squid"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_install() {
	dosbin squidclamav
	insinto /etc
	newins squidclamav.conf.dist squidclamav.conf
	keepdir /var/log/squidclamav
	fowners squid:squid /var/log/squidclamav
	dodoc ChangeLog README squidclamav.conf.dist clwarn.cgi*
}

pkg_postinst() {
	einfo "To enable squidclam, add the following lines to /etc/squid/squid.conf:"
	einfo " - for squid ver 2.5"
	einfo "    ${HILITE}redirect_program /usr/sbin/squidclamav${NORMAL}"
	einfo "    ${HILITE}redirect_children 15${NORMAL}"
	einfo "    ${HILITE}redirector_access deny localhost${NORMAL} # prevent loops"
	einfo "    ${HILITE}redirector_access deny SSL_ports${NORMAL} # SSL URLs cannot be scanned"
	einfo " - for squid ver 2.6"
	einfo "    ${HILITE}url_rewrite_program /usr/sbin/squidclamav${NORMAL}"
	einfo "    ${HILITE}url_rewrite_children 15${NORMAL}"
	einfo "    ${HILITE}url_rewrite_access deny localhost${NORMAL} # prevent loops"
	einfo "    ${HILITE}url_rewrite_access deny SSL_ports${NORMAL} # SSL URLs cannot be scanned"
}
