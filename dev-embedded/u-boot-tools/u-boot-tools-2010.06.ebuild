# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/u-boot-tools/u-boot-tools-2010.06.ebuild,v 1.1 2010/08/15 03:08:26 vapier Exp $

inherit toolchain-funcs

MY_P="u-boot-${PV/_/-}"
DESCRIPTION="utilities for working with Das U-Boot"
HOMEPAGE="http://www.denx.de/wiki/U-Boot/WebHome"
SRC_URI="ftp://ftp.denx.de/pub/u-boot/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

S=${WORKDIR}/${MY_P}

domake() {
	emake \
		HOSTSTRIP=echo \
		HOSTCC="$(tc-getCC)" \
		HOSTCFLAGS="${CFLAGS} ${CPPFLAGS}"' $(HOSTCPPFLAGS)' \
		HOSTLDFLAGS="${LDFLAGS}" \
		"$@"
}

src_compile() {
	rm -f include/config.mk
	domake CONFIG_CMD_LOADS=y tools-all || die
	touch include/config.mk
	domake -C tools/easylogo TOPDIR=$PWD SRCTREE=$PWD obj=$PWD/tools/easylogo/ || die
	domake env || die
}

src_install() {
	cd tools
	dobin bmp_logo gen_eth_addr img2srec mkimage || die
	dobin easylogo/easylogo || die
	dobin env/fw_printenv || die
	dosym fw_printenv /usr/bin/fw_setenv || die
	insinto /etc
	doins env/fw_env.config || die
}
