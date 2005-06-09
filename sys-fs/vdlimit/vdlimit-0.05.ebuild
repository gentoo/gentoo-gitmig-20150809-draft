# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/vdlimit/vdlimit-0.05.ebuild,v 1.1 2005/06/09 10:47:37 hollow Exp $

inherit toolchain-funcs

DESCRIPTION="Linux-VServer - virtual disk limit utility"
SRC_URI="http://vserver.13thfloor.at/Experimental/SYSCALL/${P}.tar.bz2"
HOMEPAGE="http://linux-vserver.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=""

src_compile() {
	`tc-getCC` ${CFLAGS} -Ivserver -o vdlimit vdlimit.c
}

src_install() {
	dosbin vdlimit
}
