# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/syslog-notify/syslog-notify-0.1.ebuild,v 1.5 2012/04/23 17:28:11 mgorny Exp $

EAPI=2
inherit eutils

DESCRIPTION="Notifications for syslog entries via libnotify"
HOMEPAGE="http://jtniehof.github.com/syslog-notify/"
SRC_URI="mirror://github/jtniehof/${PN}/${P}.tar.bz2"

KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="x11-libs/libnotify"
RDEPEND="${DEPEND}
	app-admin/syslog-ng"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch
}

src_install() {
	dosbin src/syslog-notify || die
	ebegin "Creating /var/spool/syslog-notify FIFO"
	dodir /var/spool/ || die
	mkfifo "${D}"var/spool/syslog-notify || die
	eend $?
	dodoc AUTHORS INSTALL README || die
}

pkg_postinst() {
	elog "Add the following options on your"
	elog "/etc/syslog-ng/syslog-ng.conf file:"
	elog "	#  destination notify { pipe("/var/spool/syslog-notify"); };"
	elog "	#  log { source(src); destination(notify);};"
	elog "Remember to restart syslog-ng before starting syslog-notify."
}
