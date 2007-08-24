# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/loop-aes/loop-aes-3.2a.ebuild,v 1.3 2007/08/24 21:01:52 alonbl Exp $

inherit linux-mod

MY_P="${PN/aes/AES}-v${PV}"
DESCRIPTION="Linux kernel module to encrypt local file systems and disk partitions with AES cipher."
HOMEPAGE="http://loop-aes.sourceforge.net/loop-AES.README"
SRC_URI="mirror://sourceforge/loop-aes/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE="keyscrub padlock"
KEYWORDS="~amd64 ~hppa ~ppc x86"

RDEPEND=">=sys-apps/util-linux-2.12r"
DEPEND=""

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if ! built_with_use sys-apps/util-linux crypt; then
		eerror "loop-aes needs >=util-linux-2.12q-r1 compiled with crypt use-flag enabled!"
		die "util-linux without crypt detected"
	fi

	linux-mod_pkg_setup

	CONFIG_CHECK="!BLK_DEV_LOOP"
	MODULE_NAMES="loop(block::tmp-d-kbuild)"
	BUILD_TARGETS="all"

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
	dobin loop-aes-keygen
	doman loop-aes-keygen.1
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo ""
	einfo "For more instructions take a look at examples in"
	einfo "/usr/share/doc/${PF}/README.gz"
	einfo ""
}
