# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/fake/fake-1.1.8.ebuild,v 1.1 2003/10/31 14:30:46 tantive Exp $

DESCRIPTION="Fake has been designed to switch in backup servers on a LAN. In particular it has been designed to backup Mail, Web and Proxy servers during periods of both unscheduled and scheduled down time. Fake allows you to take over the IP address of another machine in the LAN by bringing up an additional interface and making use of ARP spoofing. The additional interface can be either a physical interface or an IP alias."
SRC_URI="http://www.vergenet.net/linux/${PN}/download/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.vergenet.net/linux/fake/"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"
IUSE=""

DEPEND=""

src_compile(){
	make patch || die "building patch failed"
	emake || die "make failed"
}

src_install(){
	make ROOT_DIR=${D} install || die "install failed"
	dodoc AUTHORS ChangeLog COPYING README docs/*
}
