# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/u-boot-tools/u-boot-tools-1.3.1.ebuild,v 1.2 2008/05/12 21:35:59 solar Exp $

MY_P="u-boot-${PV}"

DESCRIPTION="utilities for working with Das U-Boot"
HOMEPAGE="http://www.denx.de/wiki/UBoot"
SRC_URI="ftp://ftp.denx.de/pub/u-boot/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	touch include/config.mk
	sed -i 's:linux/string.h:string.h:' lib_generic/sha1.c || die
	sed -i 's:linux/mtd/mtd.h:mtd/mtd-user.h:' tools/env/fw_env.c || die
	sed -i \
		-e '1i#include <string.h>' \
		-e '1i#include <stdlib.h>' \
		tools/easylogo/easylogo.c || die
}

src_compile() {
	emake HOSTSTRIP=echo BIN_FILES="bmp_logo gen_eth_addr img2srec mkimage" tools || die
	emake HOSTSTRIP=echo -C tools/easylogo || die
	emake env || die
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
