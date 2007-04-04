# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/acer_acpi/acer_acpi-0.4.ebuild,v 1.1 2007/04/04 20:30:47 jurek Exp $

inherit linux-mod

DESCRIPTION="A kernel module to allow hardware control on newer Acer laptops"
HOMEPAGE="http://code.google.com/p/aceracpi"
SRC_URI="http://aceracpi.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

MODULE_NAMES="acer_acpi(extra:)"
BUILD_TARGETS="all"

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNELSRC=${KV_DIR} KERNELVERSION=${KV_FULL}"
}

src_install() {
	linux-mod_src_install
	dodoc README COPYING NEWS AUTHORS
}

pkg_postinst() {
	linux-mod_pkg_postinst

	elog "You can load the module:"
	elog "% modprobe acer_acpi"
	elog
	ewarn "From Version 0.3 on it is sufficient to load acer_acpi ONCE in your"
	ewarn "/etc/modules.autoload.d/kernel-2.${KV_MINOR} file!"
	ewarn "If you upgraded from version 0.1 or 0.2, than please delete on of the lines from that file!"
	elog
	elog "If you need more info about this driver you can read the README file"
	elog "% zmore /usr/share/doc/${PF}/README.gz"
}
