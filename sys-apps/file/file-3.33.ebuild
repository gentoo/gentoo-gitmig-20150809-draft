# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/file/file-3.33.ebuild,v 1.2 2000/11/30 23:14:32 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Program to identify a file's format by scanning binary data for patters"
#unfortunately, this ftp site doesn't support passive ftp
#maybe we can find an alternative for those behind firewalls, or mirror
#on cvs.gentoo.org
SRC_URI="ftp://ftp.astron.com/pub/file/${A}"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {                           
    try ./configure --prefix=/usr --datadir=/etc --host=${CHOST}
    try pmake
}

src_install() {                               
	into /usr
	dobin file
	doman file.1 magic.4
	insinto /etc
	doins magic magic.mime
	dodoc LEGAL.NOTICE MAINT README
}



