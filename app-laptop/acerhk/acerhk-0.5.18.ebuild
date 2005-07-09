# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/acerhk/acerhk-0.5.18.ebuild,v 1.6 2005/07/09 16:08:19 swegener Exp $

inherit kernel-mod eutils

DESCRIPTION="Hotkey driver for some Acer and Acer-like laptops"
HOMEPAGE="http://www.informatik.hu-berlin.de/~tauber/acerhk/"
SRC_URI="http://www.informatik.hu-berlin.de/~tauber/acerhk/archives/acerhk-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"

IUSE=""
DEPEND="virtual/linux-sources"
RDEPEND=""

src_compile() {
	unset ARCH
	emake || die
}

src_install() {
	kernel-mod_getversion
	if [ ${KV_MINOR} -gt 4 ]
	then
		KV_OBJ="ko"
	else
		KV_OBJ="o"
	fi

	insinto  /lib/modules/${KV}/extra
	doins acerhk.${KV_OBJ}

	dodoc README COPYING NEWS doc/*
}
pkg_postinst() {
	kernel-mod_getversion
	if [ ${KV_MINOR} -gt 4 ]
	then
		KV_OBJ="ko"
	else
		KV_OBJ="o"
	fi

	echo
	einfo "Checking kernel module dependancies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}

	einfo "You can load the module:"
	einfo "% modprobe acerhk poll=1"
	echo
	einfo "If you need more info about this driver you can read the README file"
	einfo "% zmore /usr/share/doc/${PF}/README.gz"
}
