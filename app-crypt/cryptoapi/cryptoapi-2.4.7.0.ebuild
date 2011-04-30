# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/cryptoapi/cryptoapi-2.4.7.0.ebuild,v 1.30 2011/04/30 21:52:09 halcy0n Exp $

inherit linux-mod

DESCRIPTION="Modules that add encryption ability at the kernel level."
HOMEPAGE="http://www.sourceforge.net/projects/cryptoapi"
SRC_URI="mirror://sourceforge/cryptoapi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"
IUSE=""

RDEPEND=">=sys-apps/util-linux-2.11o-r2"
DEPEND="${RDEPEND}
	virtual/linux-sources"

pkg_setup() {
	if kernel_is gt 2 5; then
		die "CryptoAPI is only for 2.4 kernels"
	fi
}

src_compile() {
	# rphillips - Fixes #19006
	# econf --enable-iv-mode-sector
	econf || die "econf failed"
	cd "${S}"/api
	sed -i -e "s:-DMODVERSIONS:-DMODVERSIONS -DEXPORT_SYMTAB:g" \
		Makefile
	cd ..
	sed -i -e "s:-DMODVERSIONS:-DMODVERSIONS -DEXPORT_SYMTAB:g" \
		config.status
	emake || die
}

src_install() {
	dodir /lib/modules/${KV}/misc
	make MODLIB="${D}"/lib/modules/${KV}/misc install || die

	dodoc AUTHORS ChangeLog INSTALL LICENSE.crypto
	dodoc NEWS README* TODO doc/* doc/utils/*
}

pkg_postinst() {
	elog  " "
	elog "Please add cryptoloop to your /etc/modules.autoload."
	elog  "   If you would like to enable the module now:"
	elog  "       depmod"
	elog  "       modprobe cryptoloop"
	elog "Make sure loopback support is included within your kernel."
	elog  " "
}
