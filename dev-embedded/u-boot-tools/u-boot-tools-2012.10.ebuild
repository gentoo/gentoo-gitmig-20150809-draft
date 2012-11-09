# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/u-boot-tools/u-boot-tools-2012.10.ebuild,v 1.3 2012/11/09 21:57:35 hwoarang Exp $

EAPI="4"

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

src_prepare() {
	sed -i -e "s:-g ::" tools/Makefile || die
	# We don't have a config.h as we are building
	# for host and not for a board
	sed -i -e "/config.h/d" tools/env/fw_env.c || die
	# All this insanity is not required if there is no
	# /usr/include/image.h installed
	if [[ -e ${ROOT}/usr/include/image.h ]]; then
		einfo "A image.h header is installed in /usr/include/"
		einfo "Fixing u-boot files to use the local image.h header"
		# FIXME: HACK. media-libs/lensfun installs image.h
		# Copy local image.h to tools/ and common/ directory
		cp include/image.h common/image.h || die
		cp include/image.h tools/image.h || die
		sed -i -e "s:<image.h>:\"image.h\":" common/image.c || die
		# Fix headers so local copy is picked up first
		grep -r "<image\.h>" tools/* | cut -d ":" -f 1 | \
			xargs sed -i -e "s:<image.h>:\"image.h\":" || die
	fi
}

src_compile() {
	emake \
		HOSTSTRIP=echo \
		HOSTCC="$(tc-getCC)" \
		HOSTCFLAGS="${CFLAGS} ${CPPFLAGS}"' $(HOSTCPPFLAGS)' \
		HOSTLDFLAGS="${LDFLAGS}" \
		tools-all
}

src_install() {
	cd tools env
	dobin bmp_logo gen_eth_addr img2srec mkimage
	dobin easylogo/easylogo
	dobin env/fw_printenv
	dosym fw_printenv /usr/bin/fw_setenv
	insinto /etc
	doins env/fw_env.config
}
