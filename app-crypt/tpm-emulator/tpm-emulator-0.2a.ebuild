# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/tpm-emulator/tpm-emulator-0.2a.ebuild,v 1.3 2006/10/19 00:19:21 jokey Exp $

inherit toolchain-funcs linux-mod eutils

MY_P=${P/-/_}
DESCRIPTION="Emulator driver for tpm"
HOMEPAGE="https://developer.berlios.de/projects/tpm-emulator"

SRC_URI="http://download.berlios.de/tpm-emulator/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-libs/gmp"
RDEPEND=""
S=${WORKDIR}/${PN/-/_}-0.2


MODULE_NAMES="tpm_emulator(crypt:)"
BUILD_TARGETS="all"
BUILD_PARAMS="-j1 CC=$(tc-getCC) MODULE=tpm_emulator.${KV_OBJ} USE_GMP=/usr/lib/libgmp.a"

# INCLUDE="${CFLAGS}"

src_unpack() {
	unpack ${A}
	cd ${S}/tpm
	epatch ${FILESDIR}/${P}-inline.patch
}

src_install() {
	linux-mod_src_install
	dodoc README
}

pkg_postinst() {
	linux-mod_pkg_postinst
	einfo 'when starting for the first time:'
	einfo 'modprobe tpm_emulator startup="clear"'
}
