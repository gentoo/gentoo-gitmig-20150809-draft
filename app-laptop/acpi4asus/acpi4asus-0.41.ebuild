# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/acpi4asus/acpi4asus-0.41.ebuild,v 1.4 2009/02/15 14:40:39 mr_bones_ Exp $

inherit linux-mod eutils

DESCRIPTION="Acpi daemon and kernel module to control ASUS Laptop Hotkeys"
HOMEPAGE="http://sourceforge.net/projects/acpi4asus"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="sys-power/acpid"

pkg_setup() {
	if kernel_is lt 2 6 23 ; then
		CONFIG_CHECK="LEDS_CLASS"
		MODULE_NAMES="asus-laptop(acpi:${S}/driver)"
		BUILD_TARGETS=" "
		linux-mod_pkg_setup
		BUILD_PARAMS="KDIR=${KV_DIR}"
	else
		CONFIG_CHECK="~ASUS_LAPTOP"
		ERROR_ASUS_LAPTOP="Enable CONFIG_ASUS_LAPTOP under Device drivers - Misc Devices - Asus Laptop Extras (EXPERIMENTAL)."
		einfo "Required kernel module is already included with 2.6.23 kernels, we will not compile it."
		linux-mod_pkg_setup
	fi
}

src_unpack() {
	unpack ${A}
	if kernel_is ge 2 6 21 && kernel_is lt 2 6 23 ; then
		epatch "${FILESDIR}"/cvs.patch
	fi
}

src_compile() {
	kernel_is lt 2 6 23 && linux-mod_src_compile
	emake -C asus_acpid
}

src_install() {
	kernel_is lt 2 6 23 && linux-mod_src_install

	dobin asus_acpid/asus_acpid
	doman asus_acpid/asus_acpid.8

	dodoc README Changelog

	insinto /usr/share/${PN}/samples/actions
	doins samples/actions/*.sh

	insinto /usr/share/${PN}/samples/events
	doins samples/events/*
}

pkg_preinst() {
	kernel_is lt 2 6 23 && linux-mod_pkg_preinst
}

pkg_postinst() {
	kernel_is lt 2 6 23 && linux-mod_pkg_postinst
	elog
	elog "Don't forget to create your ~/.asus_acpi,"
	elog "see README in /usr/share/doc/${PF} for details"
	elog
}

pkg_postrm() {
	kernel_is lt 2 6 23 && linux-mod_pkg_postrm
}
