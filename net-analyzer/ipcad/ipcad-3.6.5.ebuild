# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ipcad/ipcad-3.6.5.ebuild,v 1.1 2005/03/21 23:16:46 vanquirius Exp $

DESCRIPTION="IP Cisco Accounting Daemon"
HOMEPAGE="http://ipcad.sourceforge.net/"
SRC_URI="mirror://sourceforge/ipcad/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=sys-apps/sed-4"

RDEPEND="virtual/libc
	virtual/libpcap
	net-firewall/iptables"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	sed -i -e "s/^chroot = \/adm\/tmp;/chroot = \/var\/ipcad;/" ipcad.conf.default
	sed -i -e "s/^interface/#interface/" ipcad.conf.default
	sed -i -e "s/^aggregate/#aggregate/" ipcad.conf.default
	sed -i -e "s/^pidfile = ipcad.pid;/pidfile = \/run\/ipcad.pid;/" ipcad.conf.default

	dodoc AUTHORS ChangeLog COPYING INSTALL README BUGS FAQ ipcad.conf.simple ipcad.conf.default
	dosbin ipcad

	insinto /etc
	insopts -m0600
	newins ipcad.conf.default ipcad.conf

	dodir /var/ipcad/run

	doman ipcad.8 ipcad.conf.5

	exeinto /etc/init.d
	newexe ${FILESDIR}/ipcad.init ipcad

	insinto /etc/conf.d
	newins ${FILESDIR}/ipcad.conf.d ipcad
}
