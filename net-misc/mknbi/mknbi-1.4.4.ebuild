# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mknbi/mknbi-1.4.4.ebuild,v 1.4 2006/12/17 11:11:01 masterdriverz Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Utility for making tagged kernel images useful for netbooting"
SRC_URI="mirror://sourceforge/etherboot/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://etherboot.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1
	dev-lang/nasm
	!sys-boot/netboot"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/mknbi-1.4.3-nossp.patch
	epatch "${FILESDIR}"/${P}-gcc4.patch

	sed -i -e "s:\/usr\/local:\/usr:"  Makefile
	sed -i -e "s:\-mcpu:\-march:" Makefile

	#apply modifications to CFLAGS to fix for gcc 3.4: bug #64049
	if [ "`gcc-major-version`" -ge "3" -a "`gcc-minor-version`" -ge "4" ]
	then
		sed -i -e 's:\-mcpu:\-mtune:' Makefile
		sed -i -e 's:CFLAGS=:CFLAGS= -minline-all-stringops:' Makefile
	fi
	if [ "`gcc-major-version`" = "4" ]; then
		sed -i -e 's:\-fno-stack-protector-all::' Makefile
	fi
}

src_install() {
	export BUILD_ROOT="${D}"
	make DESTDIR="${D}" install || die "Installation failed"
}
