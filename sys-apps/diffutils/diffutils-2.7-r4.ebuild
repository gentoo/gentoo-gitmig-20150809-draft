# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/diffutils/diffutils-2.7-r4.ebuild,v 1.3 2001/08/13 19:20:17 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Tools to make diffs and compare files"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/diffutils/${A}
	 ftp://ftp.gnu.org/gnu/diffutils/${A}"

HOMEPAGE="http://www.gnu.org/software/diffutils/diffutils.html"
DEPEND="virtual/glibc nls? ( sys-devel/gettext )"
if [ -z "`use build`" ]
then
	DEPEND="$DEPEND sys-apps/texinfo"
fi
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

	if [ "`use build`" ]
	then
		#disable texinfo building so we can remove the dep
		cp Makefile Makefile.orig
		sed -e 's/^all: ${PROGRAMS} info/all: ${PROGRAMS}/g' Makefile.orig > Makefile
	fi

    if [ -z "`use static`" ]
    then
        try emake
    else
        try emake LDFLAGS=-static
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


