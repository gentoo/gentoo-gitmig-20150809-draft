# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author David Chamberlain <daybird@gentoo.org>

S=${WORKDIR}/${P}
DESCRIPTION="MOL (Mac-on-Linux) is a PPC-only program to run Mac OS <=9.2 natively within Linux"
SRC_URI="ftp://ftp.nada.kth.se/pub/home/f95-sry/Public/mac-on-linux/${P}.tgz"
HOMEPAGE="http://www.maconlinux.net/"

DEPEND=""

src_compile() {

	./configure --prefix=/usr || die "This is a ppc-only package (time to buy that iBook, no?)"
	make || die "Failed to compile MOL"
}

src_install() {

	make install || die "Failed to install MOL"

	dodoc 0README BUILDING COPYING COPYRIGHT CREDITS Doc/*
	
}

pkg_postinst() {
	einfo "Mac-on-Linux is now installed.  To run, use the command startmol"
	einfo "You might want to configure video modes first with molvconfig"
	einfo "Other configuration is in /etc/molrc.  For more info see:"
	einfo "              www.maconlinux.net"
	einfo "Also try man molrc, man molvconfig, man startmol"
}
