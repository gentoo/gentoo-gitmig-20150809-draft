# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/console-tools/console-tools-0.2.3-r2.ebuild,v 1.2 2000/11/30 23:14:32 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Console and font utilities"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/keyboards/${A}"
HOMEPAGE="http://altern.org/ydirson/en/lct/"

DEPEND=">=sys-libs/glibc-2.1.3"
RDEPEND="$DEPEND
	>=sys-apps/bash-2.04"

src_unpack() {
	unpack ${A}
	cd ${S}
	gzip -dc ${FILESDIR}/${PN}-${PV}.patch.gz | patch -p1
}

src_compile() {  

	local myconf
  
	if [ "$DEBUG" ]
        then
	  myconf="--enable-debugging"
	fi
                       
	try ./configure --prefix=/usr --host=${CHOST}
	try make $MAKEOPTS all
}

src_install() {    
	into /usr
	cd ${S}
	try make DESTDIR=${D} install
	dodoc BUGS COPYING* CREDITS ChangeLog NEWS README RELEASE TODO
	docinto txt
	dodoc doc/*.txt doc/README.*
	docinto sgml
	dodoc doc/*.sgml
	docinto txt/contrib
	dodoc doc/contrib/*
	docinto txt/dvorak
	dodoc doc/dvorak/*
	docinto txt/file-formats
	dodoc doc/file-formats/*
	doman doc/man/*.[1-8]
	MOPREFIX="console-tools"
	domo ${S}/po/*.gmo
}



