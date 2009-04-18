# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/loop-aes/loop-aes-3.2e.ebuild,v 1.3 2009/04/18 12:42:14 maekke Exp $

EAPI="2"

inherit linux-mod

MY_P="${PN/aes/AES}-v${PV}"
DESCRIPTION="Linux kernel module to encrypt local file systems and disk partitions with AES cipher."
HOMEPAGE="http://loop-aes.sourceforge.net/loop-AES.README"
SRC_URI="mirror://sourceforge/loop-aes/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE="keyscrub padlock"
KEYWORDS="amd64 ~hppa ~ppc x86"

RDEPEND=">=sys-apps/util-linux-2.12r"
RDEPEND="|| ( ${RDEPEND}[crypt] ${RDEPEND}[loop-aes] )"
DEPEND=""

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	linux-mod_pkg_setup

	CONFIG_CHECK="!BLK_DEV_LOOP"
	MODULE_NAMES="loop(block::tmp-d-kbuild)"
	BUILD_TARGETS="all"

	BUILD_PARAMS=" \
		LINUX_SOURCE=\"${KERNEL_DIR}\" \
		KBUILD_OUTPUT=\"${KBUILD_OUTPUT}\" \
		USE_KBUILD=y MODINST=n RUNDM=n"
	use keyscrub && BUILD_PARAMS="${BUILD_PARAMS} KEYSCRUB=y"
	use padlock && BUILD_PARAMS="${BUILD_PARAMS} PADLOCK=y"
}

src_install() {
	linux-mod_src_install

	dodoc README || die
	dobin loop-aes-keygen
	doman loop-aes-keygen.1
}

pkg_postinst() {
	linux-mod_pkg_postinst

	einfo ""
	einfo "For more instructions take a look at examples in README at:"
	einfo "/usr/share/doc/${PF}"
	einfo ""
}
