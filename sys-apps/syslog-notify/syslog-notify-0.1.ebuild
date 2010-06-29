# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/syslog-notify/syslog-notify-0.1.ebuild,v 1.3 2010/06/29 08:57:31 fauli Exp $

EAPI="2"

DESCRIPTION="Notifications for syslog entries via libnotify"
HOMEPAGE="http://jtniehof.github.com/syslog-notify/"
SRC_URI="http://cloud.github.com/downloads/jtniehof/${PN}/${P}.tar.bz2"

KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="x11-libs/libnotify"
RDEPEND="${DEPEND}
	app-admin/syslog-ng"

src_install() {
	dosbin src/syslog-notify || die "install failed"
	ebegin "Creating /var/spool/syslog-notify FIFO"
	dodir /var/spool/ || die "dodir failed"
	mkfifo "${D}"var/spool/syslog-notify || die "mkfifo failed"
	eend $?
	dodoc AUTHORS INSTALL README || die "dodoc failed"
}

pkg_postinst() {
	elog "Add the following options on your"
	elog "/etc/syslog-ng/syslog-ng.conf file:"
	elog "	#  destination notify { pipe("/var/spool/syslog-notify"); };"
	elog "	#  log { source(src); destination(notify);};"
	elog "Remember to restart syslog-ng before starting syslog-notify."
}
