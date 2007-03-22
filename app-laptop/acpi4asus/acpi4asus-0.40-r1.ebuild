# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/acpi4asus/acpi4asus-0.40-r1.ebuild,v 1.1 2007/03/22 18:46:51 genstef Exp $

inherit linux-mod eutils

DESCRIPTION="Acpi daemon and kernel module to control ASUS Laptop Hotkeys"
HOMEPAGE="http://sourceforge.net/projects/acpi4asus"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
MODULE_NAMES="asus-laptop(acpi:${S}/driver)"
BUILD_TARGETS=" "
RDEPEND="sys-power/acpid"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KDIR=${KV_DIR}"
}

src_unpack() {
	unpack ${A}

	if kernel_is ge 2 6 20 ; then
		die "kernel 2.6.20 and later not yet supported in this release, feel
			free to provide a patch to change that :)"
	fi
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

	dodir /usr/share/${PN}/samples/actions
	insinto /usr/share/${PN}/samples/actions
	doins samples/actions/*.sh

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
