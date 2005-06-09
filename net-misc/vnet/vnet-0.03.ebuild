# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vnet/vnet-0.03.ebuild,v 1.2 2005/06/09 10:50:26 hollow Exp $

inherit toolchain-funcs

DESCRIPTION="Linux-VServer - NGNET interface utility"
SRC_URI="http://vserver.13thfloor.at/Experimental/NGNET/${P}.tar.bz2"
HOMEPAGE="http://linux-vserver.org/NGNET-Testing-HOWTO"

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
