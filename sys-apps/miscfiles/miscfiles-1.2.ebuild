# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <alkaline@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/miscfiles/miscfiles-1.2.ebuild,v 1.1 2001/08/06 21:22:17 pete Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Miscellaneous files"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"

HOMEPAGE="http://www.gnu.org/directory/${PN}.html"

src_compile () {
	cd ${S}
	./configure --prefix=/usr --target=${CHOST}
	try make
}

src_install () {
	try make prefix=${D}/usr install
}
