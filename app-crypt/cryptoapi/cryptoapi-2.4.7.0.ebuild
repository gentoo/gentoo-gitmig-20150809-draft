# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Preston A. Elder <prez@goth.net>
# $Header: /var/cvsroot/gentoo-x86/app-crypt/cryptoapi/cryptoapi-2.4.7.0.ebuild,v 1.1 2002/04/26 06:13:55 rphillips Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Modules that add encryption ability at the kernel level."
SRC_URI="http://prdownloads.sourceforge.net/cryptoapi/${P}.tar.gz"
HOMEPAGE="http://www.sourceforge.net/projects/cryptoapi"

DEPEND=">=sys-apps/util-linux-2.11o-r2
		sys-kernel/linux-sources"

src_compile() {
	econf || die
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
	dodir /lib/modules/misc
	make MODLIB=${D}/lib/modules/misc \
		install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL LICENSE.crypto
	dodoc NEWS README* TODO doc/* doc/utils/*
}

pkg_postinst() {
	einfo " "
	einfo "Please add cryptoloop to your /etc/modules.autoload."
	einfo "If you would like to enable the module now:"
	einfo "    depmod"
	einfo "    modprobe cryptoloop"
	einfo " "
}
