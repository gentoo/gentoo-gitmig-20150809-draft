# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipchains-firewall/ipchains-firewall-1.7.0-r1.ebuild,v 1.2 2000/08/16 04:38:17 drobbins Exp $

P=ipchains-firewall-1.7.0
A=${P}.tar.gz
S=${WORKDIR}/ipchains-firewall-1.7
DESCRIPTION="IP-Chains Firewall Script "
SRC_URI="http://firewall.langistix.com/download/"${A}
HOMEPAGE="http://firewall.langistix.com/"

src_compile() {                           
  cd ${S}
}

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




