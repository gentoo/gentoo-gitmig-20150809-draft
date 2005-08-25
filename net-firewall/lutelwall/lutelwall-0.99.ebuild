# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/lutelwall/lutelwall-0.99.ebuild,v 1.1 2005/08/25 18:59:50 vanquirius Exp $

DESCRIPTION="High-level tool for firewall configuration"
HOMEPAGE="http://firewall.lutel.pl"
SRC_URI="http://firewall.lutel.pl/download/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64 ~alpha"
IUSE=""

DEPEND=">=net-firewall/iptables-1.2.6
	sys-apps/iproute2
	>=sys-apps/gawk-3.1"

src_install() {
	insinto /etc ; doins lutelwall.conf
	dosbin lutelwall
	exeinto /etc/init.d ; doexe ${FILESDIR}/lutelwall
	dodoc FEATURES ChangeLog
}

pkg_postinst() {
	einfo "Basic configuration file is /etc/lutelwall.conf"
	einfo "Adjust it to your needs before using"
}
