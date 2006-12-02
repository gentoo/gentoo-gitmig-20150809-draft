# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/loop-aes/loop-aes-3.1e.ebuild,v 1.3 2006/12/02 16:11:19 alonbl Exp $

inherit linux-mod eutils

MY_P="${PN/aes/AES}-v${PV}"
DESCRIPTION="Linux kernel module to encrypt local file systems and disk partitions with AES cipher."
HOMEPAGE="http://loop-aes.sourceforge.net/loop-AES.README"
SRC_URI="mirror://sourceforge/loop-aes/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE="keyscrub padlock"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"

S="${WORKDIR}/${MY_P}"

CONFIG_CHECK="!BLK_DEV_LOOP"
MODULE_NAMES="loop(block:tmp-d-kbuild)"
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

	BUILD_PARAMS="
		LINUX_SOURCE=${KERNEL_DIR}
		KBUILD_OUTPUT=${KBUILD_OUTPUT}
		USE_KBUILD=y MODINST=n RUNDM=n"
	use keyscrub && BUILD_PARAMS="${BUILD_PARAMS} KEYSCRUB=y"
	use padlock && BUILD_PARAMS="${BUILD_PARAMS} PADLOCK=y"
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
