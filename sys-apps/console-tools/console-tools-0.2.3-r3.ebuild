# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/console-tools/console-tools-0.2.3-r3.ebuild,v 1.7 2002/07/14 19:20:16 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Console and font utilities"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/system/keyboards/${P}.tar.gz"
HOMEPAGE="http://altern.org/ydirson/en/lct/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
        nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}.patch

    patch -p0 < ${FILESDIR}/${P}-po-Makefile.in.in-gentoo.diff

}

src_compile() {

	local myconf

	if [ "$DEBUG" ]
        then
	  myconf="--enable-debugging"
	fi
    if [ -z "`use nls`" ]
    then
      myconf="${myconf} --disable-nls"
    fi

	try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} ${myconf}
	try make $MAKEOPTS all
}

src_install() {

    # DESTDIR does not work correct
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

}



