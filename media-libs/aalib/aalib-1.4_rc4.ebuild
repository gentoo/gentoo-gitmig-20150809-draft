## Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/aalib/aalib-1.4_rc4.ebuild,v 1.1 2001/05/06 18:59:59 achim Exp $

A=${PN}-1.4rc4.tar.gz
S=${WORKDIR}/${PN}-1.4.0
DESCRIPTION="A ASCI-Graphics Library"
SRC_URI="http://prdownloads.sourceforge.net/aa-project/${A}"
HOMEPAGE="http://www.ta.jcu.cz/aa/"

DEPEND=">=sys-libs/ncurses-5.1
	    slang? ( >=sys-libs/slang-1.4.2 )
	    X? ( virtual/x11 )"

RDEPEND=">=sys-libs/ncurses-5.1
	    slang? ( >=sys-libs/slang-1.4.2 )
	    X? ( virtual/x11 )"

src_unpack() {

    unpack ${A}
    patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
    touch *
}

src_compile() {

    local myconf
    if [ "`use slang`" ]
    then
      myconf="--with-slang-driver=yes"
    else
      myconf="--with-slang-driver=no"
    fi
    if [ "`use X`" ]
    then
      myconf="${myconf} --with-x11-driver=yes"
    else
      myconf="${myconf} --with-x11-driver=no"
    fi
    if [ -z "`use gpm`" ]
    then
      myconf="${myconf} --with-gpm-mouse=no"
    fi

    try ./configure --prefix=/usr --infodir=/usr/share/info \
	--mandir=${D}/usr/share/man --host=${CHOST} ${myconf}
    try make

}

src_install () {

    try make prefix=${D}/usr infodir=${D}/usr/share/info \
	mandir=${D}/usr/share/man install

    dodoc ANNOUNCE AUTHORS ChangeLog COPYING NEWS README*

}

