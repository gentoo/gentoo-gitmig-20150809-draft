# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usbd/usbd-0.1.ebuild,v 1.8 2004/07/15 02:45:47 agriffis Exp $

DESCRIPTION="USB Daemon"
HOMEPAGE="http://usb.cs.tum.edu"
SRC_URI="http://usb.cs.tum.edu/download/usbd/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""
DEPEND="virtual/libc
	>=sys-apps/usbutils-0.11"

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
