# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/diffutils/diffutils-2.7-r4.ebuild,v 1.2 2001/08/12 19:20:15 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Tools to make diffs and compare files"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/diffutils/${A}
	 ftp://ftp.gnu.org/gnu/diffutils/${A}"

HOMEPAGE="http://www.gnu.org/software/diffutils/diffutils.html"
DEPEND="virtual/glibc nls? ( sys-devel/gettext ) sys-apps/texinfo"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {

    local myconf
    if [ -z "`use nls`" ]
    then
      myconf="--disable-nls"
    fi
    try ./configure --host=${CHOST} --prefix=/usr ${myconf}

    if [ -z "`use static`" ]
    then
        try pmake
    else
        try pmake LDFLAGS=-static
    fi

}

src_install() {

    try make prefix=${D}/usr infodir=${D}/usr/share/info install

    if [ -z "`use build`" ]
    then
	    dodoc COPYING ChangeLog NEWS README
    else
      rm -rf ${D}/usr/share/info
    fi

}


