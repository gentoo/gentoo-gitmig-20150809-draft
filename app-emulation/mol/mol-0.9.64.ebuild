# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-emulation/mol/mol-0.9.64.ebuild,v 1.2 2002/07/21 01:01:13 sunflare Exp $

S=${WORKDIR}/${P}
DESCRIPTION="MOL (Mac-on-Linux) is a PPC-only program to run Mac OS <=9.2 natively within Linux"
SRC_URI="ftp://ftp.nada.kth.se/pub/home/f95-sry/Public/mac-on-linux/${P}.tgz"
HOMEPAGE="http://www.maconlinux.net/"

DEPEND="virtual/glibc"
RDEPEND=""
SLOT="0"
LICENSE="GPL"
KEYWORDS="ppc -x86 -sparc -sparc64"

pkg_setup() {
        if [ ${ARCH} != "ppc" ] ; then
                eerror "Sorry, this is a PPC only package."
                die "Sorry, this as a PPC only pacakge."
        fi
}

src_compile() {

	./configure --prefix=/usr || die "This is a ppc-only package (time to buy that iBook, no?)"
	emake || die "Failed to compile MOL"
}

src_install() {

	emake DESTDIR=${D} install || die "Failed to install MOL"

	dodoc 0README BUILDING COPYING COPYRIGHT CREDITS Doc/*
	
}

pkg_postinst() {
	einfo "Mac-on-Linux is now installed.  To run, use the command startmol"
	einfo "You might want to configure video modes first with molvconfig"
	einfo "Other configuration is in /etc/molrc.  For more info see:"
	einfo "              www.maconlinux.net"
	einfo "Also try man molrc, man molvconfig, man startmol"
}
