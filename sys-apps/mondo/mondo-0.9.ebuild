# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mondo/mondo-0.9.ebuild,v 1.10 2007/04/28 17:09:39 swegener Exp $

DESCRIPTION="A System Health Monitor"
HOMEPAGE="http://mondo-daemon.sourceforge.net/"
KEYWORDS="x86 amd64 -ppc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=sys-apps/lm_sensors-2.6.3"

SRC_URI="mirror://sourceforge/mondo-daemon/${P}.tar.bz2"

src_compile() {
	econf || die "Configure failed"
	emake || die
}

src_install() {
	einstall || die "Install failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO

	newinitd ${FILESDIR}/mondo.sh mondo
}

pkg_postinst() {
	einfo
	einfo "The mondo system health monitor has been installed."
	einfo
	einfo "Don't forget to setup lm_sensors before starting mondo."
	einfo "Run mondo-setup or edit /etc/mondo.conf manually and run"
	einfo "'rc-update add mondo <runlevel>' to add mondo to a runlevel."
	einfo
}
