# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipchains-firewall/ipchains-firewall-1.7.0-r1.ebuild,v 1.3 2003/02/24 09:45:11 seemant Exp $

S=${WORKDIR}/ipchains-firewall-1.7
DESCRIPTION="IP-Chains Firewall Script "
SRC_URI="http://firewall.langistix.com/download/${P}.tar.gz"
HOMEPAGE="http://www.freshmeat.net/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc"

RDEPEND="sys-devel/perl"

src_install() {
	into /usr
	dosbin firewall.sh
	dodoc README
	cd midentd-1.6
	insinto /etc
	doins midentd.conf midentd.mircusers
	dodir /var/log
	touch ${D}/var/log/midentd.log
	chown nobody ${D}/var/log/midentd.log
	dosbin midentd midentd.logcycle
	docinto midentd
	dodoc CHANGES README LICENSE
}
