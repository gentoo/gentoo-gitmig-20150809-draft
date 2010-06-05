# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/u-boot-tools/u-boot-tools-2009.11.1.ebuild,v 1.1 2010/06/05 13:58:54 armin76 Exp $

inherit flag-o-matic

MY_P="u-boot-${PV/_/-}"

DESCRIPTION="utilities for working with Das U-Boot"
HOMEPAGE="http://www.denx.de/wiki/U-Boot/WebHome"
SRC_URI="ftp://ftp.denx.de/pub/u-boot/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_P}

domake() {
	emake \
		HOSTSTRIP=echo \
		HOSTCC="$(tc-getCC)" CC="$(tc-getCC)" \
		HOSTCFLAGS="${CFLAGS} ${CPPFLAGS}" \
		"$@"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	touch include/config.{h,mk} include/autoconf.mk{.dep,}
	sed -i \
		-e 's:HOST_CFLAGS:HOSTCFLAGS:g' \
		Makefile *.mk tools/Makefile
	sed -i \
		-e '/CFLAGS/s:-O::' \
		tools/Makefile
}

src_compile() {
	domake SUBDIRS=tools BIN_FILES-y="bmp_logo gen_eth_addr img2srec mkimage" tools || die
	domake -C tools/easylogo || die
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
