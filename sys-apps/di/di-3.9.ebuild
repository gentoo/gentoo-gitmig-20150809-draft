# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/di/di-3.9.ebuild,v 1.1 2003/05/25 22:56:17 avenj Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Disk Information Utility"
SRC_URI="http://www.gentoo.com/di/${P}.tar.gz"
HOMEPAGE="http://www.gentoo.com/di/"
KEYWORDS="~x86"
LICENSE="as-is"
DEPEND=""
SLOT="0"

src_compile() {
	./configure \
		--host=${CHOST} || die "./configure failed"
	emake || die
}

src_install () {
	mkdir -p ${D}/usr/share/man/man1/
	make MANDIR=${D}/usr/share/man/man1 PREFIX=${D}/usr install || die
	dodoc LICENSE README
}
