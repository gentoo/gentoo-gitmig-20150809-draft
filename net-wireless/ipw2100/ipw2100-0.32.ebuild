# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ipw2100/ipw2100-0.32.ebuild,v 1.1 2004/03/13 00:06:01 latexer Exp $

inherit kernel-mod eutils

MY_P=${P/ipw2100/ipw2100-full}
FW_VERSION="1.0"

DESCRIPTION="Driver for the Intel Centrino wireless chipset"

HOMEPAGE="http://ipw2100.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz
		mirror://gentoo/${PN}-fw-${FW_VERSION}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	kernel-mod_getversion

	cd ${S}
	if [ ${KV_MINOR} -gt 4 ]
	then
		ln -sf Makefile.26 Makefile
	else
		ln -sf Makefile.24 Makefile
	fi

	# Sed our makefile to have targets be obj-m instead of obj-$(CONFIG_VAR)
	sed -i -e "s:\$(CONFIG_IPW2100_AVERATEC_5100P):m:" \
		-e "s:\$(CONFIG_IPW2100):m:" \
		Makefile
}
src_compile() {
	cd ${S}
	if [ ${KV_MINOR} -gt 4 ]
	then
		unset ARCH
		mkdir ${S}/tmp
		make -C ${ROOT}/usr/src/linux SUBDIRS=${S} \
			MODVERDIR=${S}/tmp modules || die "Module compilation failed"
	else
		make -C ${ROOT}/usr/src/linux SUBDIRS=${S} \
			modules || die "Module compilation failed"
	fi
}

src_install() {
	if [ ${KV_MINOR} -gt 4 ]
	then
		KV_OBJ="ko"
	else
		KV_OBJ="o"
	fi

	dodoc ISSUES README.ipw2100 DESIGN

	insinto /lib/modules/${KV}/net
	doins ipw2100.${KV_OBJ}
	doins av5100.${KV_OBJ}

	insinto /etc/firmware
	doins ${WORKDIR}/${PN}-${FW_VERSION}.fw
	doins ${WORKDIR}/LICENSE
}
