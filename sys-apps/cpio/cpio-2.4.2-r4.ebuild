# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpio/cpio-2.4.2-r4.ebuild,v 1.1 2001/03/04 04:58:10 drobbins Exp $


A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="A file archival tool which can also read and write tar files"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/cpio/${A}
	 ftp://prep.ai.mit.edu/gnu/cpio/${A}"

HOMEPAGE="http://www.gnu.org/software/cpio/cpio.html"

DEPEND="virtual/glibc"

RDEPEND="virtual/glibc"

src_compile() {
	try ./configure --host=${CHOST} --prefix=/usr
	try pmake
}

src_unpack() {
    unpack ${A}
    cd ${S}
    mv rmt.c rmt.c.orig
    sed -e "78d" rmt.c.orig > rmt.c
    mv userspec.c userspec.c.orig
    sed -e "85d" userspec.c.orig > userspec.c
}

src_install() {
	#our official mt is now the mt in app-arch/mt-st (supports Linux 2.4, unlike this one)
	dobin cpio
	doman cpio.1
	doinfo cpio.info
	dodoc COPYING* ChangeLog NEWS README

}

