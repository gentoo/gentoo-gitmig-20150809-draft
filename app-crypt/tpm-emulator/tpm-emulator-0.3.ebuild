# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/tpm-emulator/tpm-emulator-0.3.ebuild,v 1.3 2006/10/19 00:19:21 jokey Exp $

inherit toolchain-funcs linux-mod eutils flag-o-matic

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
S=${WORKDIR}/${P/-/_}


MODULE_NAMES="tpm_emulator(crypt:)"
BUILD_TARGETS="all"
BUILD_PARAMS="-j1 CC=$(tc-getCC) MODULE=tpm_emulator.${KV_OBJ} USE_GMP=/usr/lib/libgmp.a"

src_install() {
	linux-mod_src_install
	dodoc README
	if [ -x /usr/bin/scanelf ]; then
		[ -z "$(/usr/bin/scanelf -qs __guard tpm_emulator.ko)" ] || \
			die 'cannot have gmp compiled with hardened flags'
		[ -z "$(/usr/bin/scanelf -qs __stack_smash_handler tpm_emulator.ko)" ] || \
			die 'cannot have gmp compiled with hardened flags'
	fi
}

pkg_postinst() {
	linux-mod_pkg_postinst
	einfo 'when starting for the first time:'
	einfo 'modprobe tpm_emulator startup="clear"'
}
