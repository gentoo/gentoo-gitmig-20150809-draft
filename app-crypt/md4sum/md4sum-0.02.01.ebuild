# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/md4sum/md4sum-0.02.01.ebuild,v 1.2 2007/03/06 19:03:13 peper Exp $

DESCRIPTION="md4 and edonkey hash algorithm tool"
HOMEPAGE="http://linux.xulin.de/c/"
SRC_URI="http://linux.xulin.de/c/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/usr/share/man/man1
	einstall || die "einstall failed"
}
