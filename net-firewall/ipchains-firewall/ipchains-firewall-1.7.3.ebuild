# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipchains-firewall/ipchains-firewall-1.7.3.ebuild,v 1.1 2003/02/24 19:38:41 mholzer Exp $

S=${WORKDIR}/ipchains-firewall-1.7
DESCRIPTION="IP-Chains Firewall Script "
SRC_URI="mirror://sourceforge/plonk/${P}.tar.gz"
HOMEPAGE="http://plonk.sourceforge.net/"
KEYWORDS="x86 sparc "
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
