# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chkrootkit/chkrootkit-0.37.ebuild,v 1.4 2002/10/20 18:14:57 vapier Exp $

S=${WORKDIR}/${P}

DESCRIPTION="chkrootkit is a tool to locally check for signs of a rootkit."
SRC_URI="ftp://ftp.pangeia.com.br/pub/seg/pac/${P}.tar.gz"
HOMEPAGE="http://www.chkrootkit.org/"

KEYWORDS="x86 ppc sparc sparc64"
LICENSE="AMS"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {

	make sense

}

src_install () {

	dosbin check_wtmpx chklastlog chkproc chkrootkit chkwtmp ifpromisc 

	dodoc COPYRIGHT README README.chklastlog README.chkwtmp

}


