# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nqc/nqc-3.1_p4.ebuild,v 1.1 2006/06/18 14:06:51 pylon Exp $

inherit eutils

DESCRIPTION="Not Quite C - C-like compiler for Lego Mindstorms"
SRC_URI="http://bricxcc.sourceforge.net/nqc/release/${P/_p/.r}.tgz"
HOMEPAGE="http://bricxcc.sourceforge.net/nqc/"

S=${WORKDIR}/${P/_p/.r}

SLOT="0"
LICENSE="MPL-1.0"
KEYWORDS="~x86 ~amd64"
IUSE="usb"

DEPEND="virtual/libc
	usb? ( dev-libs/legousbtower )"

src_compile()
{
	if use usb; then
		epatch ${FILESDIR}/${P}-usb.patch
	fi
	if use amd64; then
		epatch ${FILESDIR}/${P}-amd64.patch
	fi
	sed -i -e 's/PREFIX?\=\/usr\/local/PREFIX?\=\/usr/' Makefile
	emake || die
}

src_install() {
	dobin bin/*
	mv nqc-man-2.1r1-0.man nqc.1
	doman nqc.1
	dodoc history.txt readme.txt scout.txt test.nqc
}

pkg_postinst() {
	einfo "To change the default serial name for nqc (/dev/ttyS0) set"
	einfo "the environment variable RCX_PORT or use the nqc command line"
	einfo "option -S to specify your serial port."
	if use usb; then
		einfo
		einfo "You have enabled USB support. To use usb on the"
		einfo "command line use the -Susb command line option"
	else
		einfo
		einfo "You have not enabled usb support and will be unable"
		einfo "to use the usb IR tower. To enable USB use the usb use flag"
	fi
}
