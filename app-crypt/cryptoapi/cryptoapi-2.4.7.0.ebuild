# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/cryptoapi/cryptoapi-2.4.7.0.ebuild,v 1.21 2004/05/31 20:34:33 vapier Exp $

inherit check-kernel

DESCRIPTION="Modules that add encryption ability at the kernel level."
HOMEPAGE="http://www.sourceforge.net/projects/cryptoapi"
SRC_URI="mirror://sourceforge/cryptoapi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"
IUSE=""

DEPEND=">=sys-apps/util-linux-2.11o-r2
	virtual/linux-sources
	>=sys-apps/portage-1.9.10"

pkg_setup() {
	if is_2_5_kernel || is_2_6_kernel ; then
		die "CryptoAPI is only for 2.4 kernels"
	fi
}

src_compile() {
	check_KV
	# rphillips - Fixes #19006
	# econf --enable-iv-mode-sector
	econf || die "econf failed"
	cd ${S}/api
	sed -i -e "s:-DMODVERSIONS:-DMODVERSIONS -DEXPORT_SYMTAB:g" \
		Makefile
	cd ..
	sed -i -e "s:-DMODVERSIONS:-DMODVERSIONS -DEXPORT_SYMTAB:g" \
		config.status
	emake || die
}

src_install() {
	dodir ${D}/lib/modules/${KV}/misc
	make MODLIB=${D}/lib/modules/${KV}/misc install || die

	dodoc AUTHORS ChangeLog INSTALL LICENSE.crypto
	dodoc NEWS README* TODO doc/* doc/utils/*
}

pkg_postinst() {
	echo  " "
	einfo "Please add cryptoloop to your /etc/modules.autoload."
	echo  "   If you would like to enable the module now:"
	echo  "       depmod"
	echo  "       modprobe cryptoloop"
	einfo "Make sure loopback support is included within your kernel."
	echo  " "
}
