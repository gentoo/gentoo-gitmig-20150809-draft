# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ipcad/ipcad-3.6.2.ebuild,v 1.1 2004/07/25 15:25:25 eldad Exp $

DESCRIPTION="IP Cisco Accounting Daemon"
HOMEPAGE="http://ipcad.sourceforge.net/"
SRC_URI="http://ipcad.sourceforge.net/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="net-libs/libpcap"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	sed -i -e "s/^chroot = \/adm\/tmp;/chroot = \/var\/ipcad;/" ipcad.conf.default
	sed -i -e "s/^interface/#interface/" ipcad.conf.default
	sed -i -e "s/^aggregate/#aggregate/" ipcad.conf.default
	sed -i -e "s/^pidfile = ipcad.pid;/pidfile = \/run\/ipcad.pid;/" ipcad.conf.default

	dodoc AUTHORS ChangeLog COPYING INSTALL README TODO BUGS FAQ
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
