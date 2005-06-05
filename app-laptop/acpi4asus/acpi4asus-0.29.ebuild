# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/acpi4asus/acpi4asus-0.29.ebuild,v 1.2 2005/06/05 10:32:48 genstef Exp $

inherit linux-mod

DESCRIPTION="Acpi daemon and kernel module to control ASUS Laptop Hotkeys"
HOMEPAGE="http://sourceforge.net/projects/acpi4asus"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
MODULE_NAMES="asus_acpi(acpi:${S}/driver)"
BUILD_TARGETS=" "
RDEPEND="sys-power/acpid"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELSRC=${KV_DIR}"
}

src_compile() {
	linux-mod_src_compile

	emake -C asus_acpid
}


src_install() {
	linux-mod_src_install

	dobin asus_acpid/asus_acpid
	doman asus_acpid/asus_acpid.8

	dodoc README Changelog

	dodir /usr/share/${PN}/samples
	insinto /usr/share/${PN}/samples
	doins samples/*.{sh,pl}

	dodir /usr/share/${PN}/samples/events
	insinto /usr/share/${PN}/samples/events
	doins samples/events/*
}

pkg_postinst() {
	linux-mod_pkg_postinst
	einfo
	einfo "Don't forget to create your ~/.asus_acpi,"
	einfo "see /usr/share/doc/${PF}/README.gz for details"
	einfo
}
