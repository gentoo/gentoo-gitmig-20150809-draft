# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/nvi/nvi-1.81.4.ebuild,v 1.3 2002/07/11 06:30:12 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Vi clone"
SRC_URI="http://www.kotnet.org/~skimo/nvi/devel/${P}.tar.gz"
HOMEPAGE="http://www.kotnet.org/~skimo/nvi"
DEPEND=">=sys-libs/db-3.1"
#RDEPEND=""

src_compile() {
	cd build.unix
	try ../dist/configure --infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST}
	try emake
}

src_install () {
	cd ${S}/build.unix
	try make prefix=${D}/usr install
}
