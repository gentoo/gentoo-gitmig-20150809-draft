# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/watchpid/watchpid-0.1.ebuild,v 1.1 2000/11/13 08:18:24 drobbins Exp $

A=watchpid_0.1.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Watches a process for termination"
SRC_URI="http://www.codepark.org/projects/utils/${A}"
HOMEPAGE="http://www.codepark.org"

src_compile() {                           
	try ./configure --prefix=/usr --host=${CHOST}
	try make
}

src_install() {                               
	try make prefix=${D}/usr install
	cd ${S}
	dodoc README AUTHOR
}



