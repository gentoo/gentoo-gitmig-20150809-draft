# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipchains-firewall/ipchains-firewall-1.7.0-r1.ebuild,v 1.8 2002/08/14 12:08:07 murphy Exp $

S=${WORKDIR}/ipchains-firewall-1.7
DESCRIPTION="IP-Chains Firewall Script "
SRC_URI="http://firewall.langistix.com/download/${P}.tar.gz"
HOMEPAGE="http://firewall.langistix.com/"
KEYWORDS="x86 sparc sparc64"
LICENSE="as-is"
SLOT="0"

RDEPEND="sys-devel/perl"

src_install() {
	cd ${S}
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
