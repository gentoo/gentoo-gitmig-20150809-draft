# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-build/file/file-3.33.ebuild,v 1.2 2001/02/15 18:17:31 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Program to identify a file's format by scanning binary data for patters"
#unfortunately, this ftp site doesn't support passive ftp
#maybe we can find an alternative for those behind firewalls, or mirror
#on cvs.gentoo.org
SRC_URI="ftp://ftp.astron.com/pub/file/${A}"

src_compile() {
    try ./configure --prefix=/usr --datadir=/etc --host=${CHOST}
    try pmake LDFLAGS=-static
}

src_install() {
	into /usr
	dobin file
	insinto /etc
	doins magic magic.mime
}



