# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tftp-hpa/tftp-hpa-0.16.ebuild,v 1.12 2003/02/28 23:04:09 vapier Exp $

DESCRIPTION="HPA's TFTP Daemon is a port of the OpenBSD TFTP server"
SRC_URI="ftp://ftp.kernel.org/pub/software/network/tftp/${P}.tar.bz2"
HOMEPAGE="http://www.kernel.org/pub/software/network/tftp/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 sparc"

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	make || die
}

src_install() {
	dodir /usr/{bin,sbin} /usr/share/man/man{1,8}
	make INSTALLROOT=${D} install || die
	dodoc README
}
