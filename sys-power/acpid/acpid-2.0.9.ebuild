# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpid/acpid-2.0.9.ebuild,v 1.4 2011/05/31 15:47:13 phajdan.jr Exp $

EAPI=4
inherit eutils toolchain-funcs

DESCRIPTION="Daemon for Advanced Configuration and Power Interface"
HOMEPAGE="http://tedfelix.com/linux/acpid-netlink.html"
SRC_URI="http://tedfelix.com/linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 -ppc x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.0.3.patch
}

src_compile() {
	tc-export CC CPP
	emake
	emake -C kacpimon
}

src_install() {
	emake DESTDIR="${D}" DOCDIR=/usr/share/doc/${PF} install

	dobin kacpimon/kacpimon
	newdoc kacpimon/README README.kacpimon

	exeinto /etc/acpi
	newexe "${FILESDIR}"/${PN}-1.0.6-default.sh default.sh
	insinto /etc/acpi/events
	newins "${FILESDIR}"/${PN}-1.0.4-default default

	newinitd "${FILESDIR}"/${PN}-2.0.3-init.d acpid
	newconfd "${FILESDIR}"/${PN}-1.0.6-conf.d acpid
}

pkg_postinst() {
	elog
	elog "You may wish to read the Gentoo Linux Power Management Guide,"
	elog "which can be found online at:"
	elog "http://www.gentoo.org/doc/en/power-management-guide.xml"
	elog
}
