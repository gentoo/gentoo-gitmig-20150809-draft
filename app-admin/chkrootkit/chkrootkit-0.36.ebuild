# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chkrootkit/chkrootkit-0.36.ebuild,v 1.11 2003/02/13 05:17:32 vapier Exp $

S=${WORKDIR}/${PN}-pre-${PV}
DESCRIPTION="chkrootkit is a tool to locally check for signs of a rootkit."
SRC_URI="ftp://ftp.pangeia.com.br/pub/seg/pac/${P}.tar.gz"
HOMEPAGE="http://www.chkrootkit.org/"

SLOT="0"
KEYWORDS="x86 ppc sparc "
LICENSE="AMS"

DEPEND="virtual/glibc"

src_compile() {
	make sense
}

src_install() {
	dosbin check_wtmpx chklastlog chkproc chkrootkit chkwtmp ifpromisc 
	dodoc COPYRIGHT README README.chklastlog README.chkwtmp
}
