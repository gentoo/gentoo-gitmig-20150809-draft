# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usbd/usbd-0.1.ebuild,v 1.10 2005/03/19 11:17:51 plasmaroo Exp $

inherit eutils

DESCRIPTION="USB Daemon"
HOMEPAGE="http://usb.cs.tum.edu"
SRC_URI="http://usb.cs.tum.edu/download/usbd/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc"
IUSE=""
DEPEND="virtual/libc
	>=sys-apps/usbutils-0.11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/usbd-gcc-3.4.patch || die 'Failed to apply GCC 3.4 patch!'
}

src_compile() {
	econf --prefix=/usr --sysconfdir=/etc/usbd || die "econf failed"
	mv Makefile Makefile.orig
	sed s/example1/''/ Makefile.orig > Makefile
	emake || die
}

src_install() {
	make DESTDIR=${D} install
	exeinto /etc/init.d
	newexe ${FILESDIR}/usbd usbd
	insinto /usr/share/doc/${P}/example1
	doins example1/*
	dodoc AUTHORS COPYING ChangeLog INSTALL README NEWS
}
