# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/linux32/linux32-1.0.ebuild,v 1.6 2004/11/13 00:52:49 mr_bones_ Exp $

DESCRIPTION="A utility that allows AMD64 code to run in an environment so that the uname() call returns non-AMD64-specific info"
HOMEPAGE="ftp://ftp.x86-64.org/pub/linux-x86_64/tools/linux32/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
LICENSE="GPL-2"

src_compile() {
	cd ${S}
	emake linux32
}

src_install() {
	into /
	dobin ${S}/linux32
	ln -s linux32 ${D}/bin/linux64
	doman ${S}/linux32.1
	ln -s linux32.1.gz ${D}/usr/share/man/man1/linux64.1.gz
	dodoc ${S}/README
}
