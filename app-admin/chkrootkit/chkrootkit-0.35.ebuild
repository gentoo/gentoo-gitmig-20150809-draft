# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chkrootkit/chkrootkit-0.35.ebuild,v 1.14 2003/02/28 23:02:15 vapier Exp $

DESCRIPTION="a tool to locally check for signs of a rootkit"
SRC_URI="ftp://ftp.pangeia.com.br/pub/seg/pac/${PN}.tar.gz"
HOMEPAGE="http://www.chkrootkit.org/"

SLOT="0"
LICENSE="AMS"
KEYWORDS="x86 ppc sparc"

DEPEND="virtual/glibc"

src_compile() {
	make sense || die
}

src_install() {
	dosbin check_wtmpx chklastlog chkproc chkrootkit chkwtmp ifpromisc 
	dodoc COPYRIGHT README README.chklastlog README.chkwtmp
}
