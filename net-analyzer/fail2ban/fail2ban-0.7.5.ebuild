# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/fail2ban/fail2ban-0.7.5.ebuild,v 1.1 2006/12/10 03:43:03 vanquirius Exp $

inherit distutils

DESCRIPTION="Bans IP that make too many password failures"
HOMEPAGE="http://fail2ban.sourceforge.net/"
SRC_URI="mirror://sourceforge/fail2ban/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.4"
RDEPEND="${DEPEND}
	net-firewall/iptables"

src_install() {
	distutils_src_install

	newinitd files/gentoo-initd fail2ban
	dodoc CHANGELOG README TODO
}

pkg_postinst() {
	einfo
	einfo "Configuration files are now in /etc/fail2ban"
	einfo
}

