# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vnet/vnet-0.03.ebuild,v 1.1 2005/05/27 07:40:21 hollow Exp $

inherit toolchain-funcs

DESCRIPTION="NGNET interface utility"
SRC_URI="http://vserver.13thfloor.at/Experimental/NGNET/${P}.tar.bz2"
HOMEPAGE="http://vserver.13thfloor.at/Experimental/NGNET/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=""

src_compile() {
	`tc-getCC` ${CFLAGS} -Ivserver -o vnet vnet.c
}

src_install() {
	dosbin vnet
}
