# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-crypt/cryptoapi/cryptoapi-2.4.7.0.ebuild,v 1.10 2002/07/23 01:12:09 cselkirk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Modules that add encryption ability at the kernel level."
SRC_URI="mirror://sourceforge/cryptoapi/${P}.tar.gz"
HOMEPAGE="http://www.sourceforge.net/projects/cryptoapi"
KEYWORDS="x86 -ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=sys-apps/util-linux-2.11o-r2
		virtual/linux-sources
		>=sys-apps/portage-1.9.10"

RDEPEND=">=sys-apps/util-linux-2.11o-r2"

src_compile() {
	check_KV
	econf --enable-iv-mode-sector || die
	cd ${S}/api
	cp Makefile Makefile.orig
	sed -e "s:-DMODVERSIONS:-DMODVERSIONS -DEXPORT_SYMTAB:g" \
		Makefile.orig >Makefile
	cd ..
	cp config.status config.status.orig
	sed -e "s:-DMODVERSIONS:-DMODVERSIONS -DEXPORT_SYMTAB:g" \
		config.status.orig >config.status
	emake || die
}

src_install() {
	dodir ${D}/lib/modules/${KV}/misc
	make MODLIB=${D}/lib/modules/${KV}/misc install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL LICENSE.crypto
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
