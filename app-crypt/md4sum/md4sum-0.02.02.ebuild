# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/md4sum/md4sum-0.02.02.ebuild,v 1.1 2007/04/11 20:26:36 hanno Exp $

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
