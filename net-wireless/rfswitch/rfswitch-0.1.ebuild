# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/rfswitch/rfswitch-0.1.ebuild,v 1.1 2004/07/09 19:39:55 latexer Exp $

inherit kernel-mod
DESCRIPTION="Drivers for software based wireless radio switches"
HOMEPAGE="http://rfswitch.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/linux-sources
		!<=net-wireless/ipw2100-0.48"

src_unpack() {
	kernel-mod_getversion
	unpack ${A}

	if [ ${KV_MINOR} -gt 5 ] && [ ${KV_PATCH} -gt 5 ]
	then
		sed -i 's:SUBDIRS=:M=:g' ${S}/Makefile
	fi
}

src_compile() {
	check_KV
	unset ARCH
	make KSRC=${ROOT}/usr/src/linux || die
}

src_install() {
	if [ ${KV_MINOR} -gt 4 ]
	then
		KV_OBJ=ko
	else
		KV_OBJ=o
	fi

	insinto /lib/modules/${KV}/kernel/drivers/net/wireless
	doins pbe5.${KV_OBJ} av5100.${KV_OBJ}

	dodoc FILES ISSUES README
}
