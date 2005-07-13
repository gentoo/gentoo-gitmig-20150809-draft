# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/astmanproxy/astmanproxy-1.1.ebuild,v 1.3 2005/07/13 11:04:13 swegener Exp $

inherit eutils

DESCRIPTION="Proxy for the Asterisk manager interface"
HOMEPAGE="http://www.popvox.com/astmanproxy/"
SRC_URI="http://www.popvox.com/${PN}/${P}-20050705-0643.tgz"

IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# small patch for cflags and path changes
	epatch "${FILESDIR}"/${P}-gentoo.diff
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc README README.* VERSIONS astmanproxy.conf

	docinto samples
	dodoc samples/*

	# fix permissions on config file
	fperms 0640 /etc/astmanproxy.conf

	newinitd "${FILESDIR}"/astmanproxy.rc6 astmanproxy
}
