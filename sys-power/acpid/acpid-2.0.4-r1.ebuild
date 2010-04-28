# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/acpid/acpid-2.0.4-r1.ebuild,v 1.1 2010/04/28 15:21:07 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Daemon for Advanced Configuration and Power Interface"
HOMEPAGE="http://tedfelix.com/linux/acpid-netlink.html"
SRC_URI="http://tedfelix.com/linux/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 -ppc ~x86"
IUSE="consolekit"

RDEPEND="consolekit? ( sys-auth/consolekit )"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.0.3.patch
	cp "${FILESDIR}"/${PN}-2.0.4-default.sh "${T}" || die

	if ! use consolekit; then
		sed -i \
			-e 's:/etc/acpi/powerbtn.sh:/sbin/init 0:' \
			"${T}"/${PN}-2.0.4-default.sh || die
	fi
}

src_compile() {
	tc-export CC CPP
	emake || die
	emake -C kacpimon || die
}

src_install() {
	emake DESTDIR="${D}" DOCDIR="/usr/share/doc/${PF}" install || die

	dobin kacpimon/kacpimon || die
	newdoc kacpimon/README README.kacpimon

	exeinto /etc/acpi
	newexe "${T}"/${PN}-2.0.4-default.sh default.sh || die

	if use consolekit; then
		newexe "${FILESDIR}"/${PN}-2.0.4-powerbtn.sh powerbtn.sh || die
	fi

	insinto /etc/acpi/events
	newins "${FILESDIR}"/${PN}-1.0.4-default default || die

	newinitd "${FILESDIR}"/${PN}-2.0.3-init.d acpid || die
	newconfd "${FILESDIR}"/${PN}-1.0.6-conf.d acpid || die

	prepalldocs
}

pkg_postinst() {
	echo
	elog "You may wish to read the Gentoo Linux Power Management Guide,"
	elog "which can be found online at:"
	elog "http://www.gentoo.org/doc/en/power-management-guide.xml"
	echo
}
