# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/linux32/linux32-2.0.ebuild,v 1.1 2005/07/08 04:06:59 kumba Exp $

DESCRIPTION="A simple utility that tricks uname into returning a 32bit environment identifier."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
SLOT="0"
KEYWORDS="-* ~mips ~sparc ~ppc ~ppc64"
IUSE=""
LICENSE="GPL-2"

src_compile() {
	cd ${S}
	emake linux32
}

src_install() {
	into /
	cd ${S}
	dobin linux32
	ln -s linux32 ${D}/bin/linux64
	doman linux32.8
	ln -s linux32.8.gz ${D}/usr/share/man/man1/linux64.8.gz
	dodoc CHANGELOG COPYING CREDITS README
}
