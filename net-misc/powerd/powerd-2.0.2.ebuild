# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/powerd/powerd-2.0.2.ebuild,v 1.7 2005/07/30 18:19:50 swegener Exp $

IUSE=""

DESCRIPTION="Generic UPS daemon"
HOMEPAGE="http://power.sourceforge.net/"

SRC_URI="mirror://sourceforge/power/${P}.tar.gz"
KEYWORDS="x86 ~amd64"
LICENSE="GPL-2"
SLOT="0"

src_compile() {
	./configure --prefix=${D}
	emake || die
}

src_install() {
	dosbin powerd
	dobin detectups
	dodoc powerd.conf.monitor powerd.conf.peer README FAQ INSTALL SUPPORTED TODO Changelog
	doman powerd.8 detectups.8

	newinitd ${FILESDIR}/powerd-init powerd
}

pkg_postinst() {
	einfo "Add the following lines to your /etc/inittab, then do kill -SIGHUP 1"
	einfo "pf:12345:powerfail:/sbin/shutdown -h +10 Power failure."
	einfo "po:12345:powerokwait:/sbin/shutdown -c Power restored"
	einfo "Change the +10 in whatever shutdown timeout you want."
}
