# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/loop-aes/loop-aes-3.0b.ebuild,v 1.1 2005/01/31 16:33:00 genstef Exp $

inherit linux-mod

MY_P="${PN/aes/AES}-v${PV}"
DESCRIPTION="Linux kernel module to encrypt local file systems and disk partitions with AES cipher."
HOMEPAGE="http://loop-aes.sourceforge.net/loop-AES.README"
SRC_URI="mirror://sourceforge/loop-aes/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86"

S=${WORKDIR}/${MY_P}

CONFIG_CHECK="BLK_DEV_LOOP"
MODULE_NAMES="loop(block:)"
BUILD_PARAMS="LINUX_SOURCE=${KV_DIR} MODINST=n RUNDM=n"
BUILD_TARGETS="all"

pkg_setup() {
	linux-mod_pkg_setup

	if ! linux_chkconfig_present KMOD && \
	   ! linux_chkconfig_present KERNELD
	then
		ewarn ""
		ewarn "It is recommended to have Automatic kernel module loading"
		ewarn "(CONFIG_KERNELD in kernels 2.0 or CONFIG_KMOD in newer)"
		ewarn ""
	fi
}

src_unpack () {
	unpack ${A}
	convert_to_m ${S}/Makefile
}

src_install() {
	linux-mod_src_install

	dodoc README
}

pkg_postinst() {
	linux-mod_pkg_postinst

	ewarn ""
	ewarn "Note, that you will need >=util-linux-2.12p compiled with crypt"
	ewarn "in USE flag enabled in order to use this module."
	ewarn ""
	einfo "For more instructions take a look at examples in"
	einfo "/usr/share/doc/${PF}/README.gz"
	einfo ""

}
