# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/omnibook/omnibook-20040916.ebuild,v 1.1 2004/11/15 19:31:46 genstef Exp $

inherit kernel-mod

MY_P="${PN}-${PV:0:4}-${PV:4:2}-${PV:6:2}"

DESCRIPTION="Linux kernel module for HP Omnibook support"
HOMEPAGE="http://www.sourceforge.net/projects/omke"
SRC_URI="mirror://sourceforge/omke/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/kernel"
S="${WORKDIR}/${MY_P}"

pkg_setup() {
	kernel-mod_check_modules_supported
}

src_compile() {
	# http://marc.theaimsgroup.com/?l=gentoo-dev&m=109672618708314&w=2
	kernel-mod_getversion
	if [ ${KV_MINOR} -gt 5 ] && [ ${KV_PATCH} -gt 5 ]
	then
		sed -i 's:SUBDIRS=:M=:g' Makefile
	fi

	unset ARCH
	emake KSRC="${ROOT}/usr/src/linux" KERNEL="$(echo ${KV} | cut -c 1-3)" || die "emake failed"

	cd misc/obtest
	emake || die "make obtest failed"
}

src_install() {
	dosbin misc/obtest/obtest

	# The driver goes into the standard modules location
	# Not the make install location, because that way it would get deleted
	# when the user did a make modules_install in the Kernel tree

	insinto /lib/modules/${KV}/char
	if kernel-mod_is_2_6_kernel; then
		doins omnibook.ko
	else
		doins omnibook.o
	fi

	dodoc doc/*
	docinto misc
	dodoc misc/*
	docinto hotkeys
	dodoc misc/hotkeys/*
}

pkg_postinst() {
	einfo "Checking kernel module dependencies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}
}
