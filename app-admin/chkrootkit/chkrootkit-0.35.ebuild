# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/chkrootkit/chkrootkit-0.35.ebuild,v 1.6 2002/08/16 02:21:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="chkrootkit is a tool to locally check for signs of a rootkit.
"
SRC_URI="ftp://ftp.pangeia.com.br/pub/seg/pac/${PN}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.chkrootkit.org/"
LICENSE="AMS"
KEYWORDS="x86 sparc sparc64"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {
	make sense
}

src_install () {
	dosbin check_wtmpx chklastlog chkproc chkrootkit chkwtmp ifpromisc 
	dodoc COPYRIGHT README README.chklastlog README.chkwtmp
}
