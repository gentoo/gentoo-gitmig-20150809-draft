# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/powerd/powerd-2.0.2.ebuild,v 1.3 2004/04/20 15:36:27 mholzer Exp $
inherit eutils

IUSE=""

DESCRIPTION="Generic UPS daemon"
HOMEPAGE="http://power.sourceforge.net/"

SRC_URI="mirror://sourceforge/power/${P}.tar.gz"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	cd ${S}
	./configure --prefix=${D}
	emake || die
}

src_install() {
	dosbin powerd
	dobin detectups
	dodoc powerd.conf.monitor powerd.conf.peer README FAQ INSTALL

	exeinto /etc/init.d
	newexe ${FILESDIR}/powerd-init powerd
}

pkg_postinst() {
	einfo "Add the following lines to your /etc/inittab, then do kill -SIGHUP 1"
	einfo "pf:12345:powerfail:/sbin/shutdown -h +10 Power failure."
	einfo "po:12345:powerokwait:/sbin/shutdown -c Power restored"
	einfo "Change the +10 in whatever shutdown timeout you want."
}
