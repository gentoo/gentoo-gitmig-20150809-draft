# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vde/vde-1.5.8.ebuild,v 1.4 2006/04/04 02:01:31 rphillips Exp $

inherit eutils autotools

DESCRIPTION="vde is a virtual distributed ethernet emulator for emulators like qemu, bochs, and uml."
SRC_URI="mirror://sourceforge/vde/${P}.tgz"
HOMEPAGE="http://vde.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-makefile.patch
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die

	dodir /etc/init.d
	cp "${FILESDIR}"/vde.init.d "${D}"/etc/init.d/vde
	fperms a+x /etc/init.d/vde

	dodoc INSTALL README
}
