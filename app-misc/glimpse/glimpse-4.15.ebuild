# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/glimpse/glimpse-4.15.ebuild,v 1.9 2003/02/15 07:08:39 gerk Exp $

DESCRIPTION="A index/query system to search a large set of files quickly"
SRC_URI="http://webglimpse.net/trial/${P}.tar.gz"
HOMEPAGE="http://webglimpse.net/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~ppc"

src_compile() {
	make clean
	econf
	make || die
}

src_install() {
	einstall
	doman *.1 	
}
