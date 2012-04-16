# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpid/acpid-2.0.16.ebuild,v 1.1 2012/04/16 05:39:30 ssuominen Exp $

EAPI=4
inherit systemd

DESCRIPTION="Daemon for Advanced Configuration and Power Interface"
HOMEPAGE="http://tedfelix.com/linux/acpid-netlink.html"
SRC_URI="http://tedfelix.com/linux/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 -ppc ~x86"
IUSE=""

src_configure() {
	econf --docdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install

	newdoc kacpimon/README README.kacpimon
	dodoc -r samples
	rm -f "${D}"/usr/share/doc/${PF}/COPYING

	exeinto /etc/acpi
	newexe "${FILESDIR}"/${PN}-1.0.6-default.sh default.sh
	insinto /etc/acpi/events
	newins "${FILESDIR}"/${PN}-1.0.4-default default

	newinitd "${FILESDIR}"/${PN}-2.0.11-init.d acpid
	newconfd "${FILESDIR}"/${PN}-1.0.6-conf.d acpid

	systemd_dounit "${FILESDIR}"/${PN}.service
}

pkg_postinst() {
	elog
	elog "You may wish to read the Gentoo Linux Power Management Guide,"
	elog "which can be found online at:"
	elog "http://www.gentoo.org/doc/en/power-management-guide.xml"
	elog
}
