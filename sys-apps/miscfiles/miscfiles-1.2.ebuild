# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Peter Gavin <alkaline@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/miscfiles/miscfiles-1.2.ebuild,v 1.2 2002/01/01 22:35:51 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Miscellaneous files"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/directory/${PN}.html"

src_compile() {
	cd ${S}
	./configure --prefix=/usr \
		--target=${CHOST} || die
	make || die
}

src_install() {
	make prefix=${D}/usr \
		install || die
}
