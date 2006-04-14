# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/loop-aes/loop-aes-3.1d.ebuild,v 1.1 2006/04/14 22:23:34 genstef Exp $

inherit linux-mod eutils

MY_P="${PN/aes/AES}-v${PV}"
DESCRIPTION="Linux kernel module to encrypt local file systems and disk partitions with AES cipher."
HOMEPAGE="http://loop-aes.sourceforge.net/loop-AES.README"
SRC_URI="mirror://sourceforge/loop-aes/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE="keyscrub"
KEYWORDS="~amd64 ~ppc ~x86"

S=${WORKDIR}/${MY_P}

CONFIG_CHECK="!BLK_DEV_LOOP"
MODULE_NAMES="loop(block:)"
BUILD_TARGETS="all"

RDEPEND=">=sys-apps/util-linux-2.12r"

pkg_setup() {
	if ! built_with_use sys-apps/util-linux crypt; then
		eerror "loop-aes needs >=util-linux-2.12q-r1 compiled with crypt use-flag enabled!"
		die "util-linux without crypt detected"
	fi

	linux-mod_pkg_setup

	if ! linux_chkconfig_present KMOD && \
	   ! linux_chkconfig_present KERNELD
	then
		ewarn ""
		ewarn "It is recommended to have Automatic kernel module loading"
		ewarn "(CONFIG_KERNELD in kernels 2.0 or CONFIG_KMOD in newer)"
		ewarn ""
	fi

	BUILD_PARAMS="LINUX_SOURCE=${KV_DIR} MODINST=n RUNDM=n"
	use keyscrub && BUILD_PARAMS="${BUILD_PARAMS} KEYSCRUB=y"
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

	einfo ""
	einfo "For more instructions take a look at examples in"
	einfo "/usr/share/doc/${PF}/README.gz"
	einfo ""
}
