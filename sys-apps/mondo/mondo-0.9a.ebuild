# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mondo/mondo-0.9a.ebuild,v 1.2 2005/02/12 04:21:31 vapier Exp $

DESCRIPTION="A System Health Monitor"
HOMEPAGE="http://mondo-daemon.sourceforge.net/"
SRC_URI="mirror://sourceforge/mondo-daemon/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=sys-apps/lm-sensors-2.6.3"

pkg_setup() {
	if [[ ${KV:0:3} != "2.4" ]] ; then
		eerror "Sorry, but mondo only works with linux-2.4."
		eerror "http://bugs.gentoo.org/show_bug.cgi?id=72467"
		die "kernel not supported"
	fi
}

src_install() {
	einstall || die "Install failed"
	newinitd ${FILESDIR}/mondo.sh mondo
	dodoc AUTHORS ChangeLog INSTALL README TODO
}

pkg_postinst() {
	einfo "The mondo system health monitor has been installed."
	einfo
	einfo "Don't forget to setup lm_sensors before starting mondo."
	einfo "Run mondo-setup or edit /etc/mondo.conf manually and run"
	einfo "'rc-update add mondo <runlevel>' to add mondo to a runlevel."
}
