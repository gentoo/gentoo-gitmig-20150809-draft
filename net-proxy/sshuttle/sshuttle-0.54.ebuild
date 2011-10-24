# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/sshuttle/sshuttle-0.54.ebuild,v 1.3 2011/10/24 21:35:33 radhermit Exp $

EAPI=3
PYTHON_DEPEND="2"

inherit python linux-info

DESCRIPTION="Transparent proxy server that works as a poor man's VPN using ssh"
HOMEPAGE="https://github.com/apenwarr/sshuttle/"
SRC_URI="http://dev.gentoo.org/~radhermit/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/xz-utils"
RDEPEND="net-firewall/iptables
	|| ( app-admin/sudo sys-apps/shadow )"

CONFIG_CHECK="~NETFILTER_XT_TARGET_HL ~IP_NF_TARGET_REDIRECT ~NF_NAT"

src_compile() { :; }

src_install() {
	rm -f stresstest.py
	insinto "$(python_get_sitedir)"/${PN}
	doins -r *.py compat || die

	exeinto "$(python_get_sitedir)"/${PN}
	doexe ${PN} || die
	dosym "$(python_get_sitedir)"/${PN}/${PN} /usr/bin/${PN} || die

	dodoc README.md || die
	doman ${PN}.8 || die
}
